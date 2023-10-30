//
//  DrawingCanvas.swift
//  Frame
//
//  Created by Ali Tamoor on 28/10/2023.
//

import SwiftUI
import Vision
import UIKit
import PencilKit
import Vision

//MARK: - Drawing Canvas

struct DrawingCanvas: UIViewRepresentable {
    @Binding var drawingImage: UIImage?
    @ObservedObject var viewModel: DrawingViewModel
    @Binding var shouldClear: Bool  // Declare shouldClear as a @Binding variable

    class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: DrawingCanvas

        init(parent: DrawingCanvas) {
            self.parent = parent
        }

        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, 0)
            canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            parent.viewModel.drawingImage = image
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView()
        canvas.drawingPolicy = .anyInput
        canvas.delegate = context.coordinator
        canvas.backgroundColor = .lightGray
        canvas.layer.borderWidth = 2
        canvas.layer.cornerRadius = 8
        canvas.layer.borderColor = UIColor.black.cgColor
        return canvas
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if shouldClear {
            DispatchQueue.main.async {
            uiView.drawing = PKDrawing()  // Clear the canvas
                self.shouldClear = false  // Reset the flag asynchronously
            }
        }
    }
}
//
//#Preview {
//    DrawingCanvas()
//}


//MARK: - Drawing AI Model

class DrawingViewModel: ObservableObject {
    // The image drawn by the user.
    @Published var drawingImage: UIImage? {
        didSet {
            // Once the image is set, initiate text recognition.
            recognizeText()
        }
    }
    // The text recognized from the drawing.
    @Published var recognizedText: String = ""
    // Any error that occurs during the text recognition process.
    @Published var error: Error?
    
    // A queue that offloads the text recognition task from the main thread.
    private let queue = DispatchQueue(label: "textRecognitionQueue", qos: .userInitiated)
    
    // The function responsible for recognizing text from the drawing.
    func recognizeText() {
        // Ensure that the image is present before attempting text recognition.
        guard let image = drawingImage else { return }
        
        // Perform text recognition on a background thread to avoid UI freezing.
        queue.async {
            // Create a text recognition request.
            let request = VNRecognizeTextRequest { [weak self] (request, error) in
                // Handle any error that occurs during the request.
                if let error = error {
                    DispatchQueue.main.async {
                        self?.error = error
                    }
                    return
                }
                
                // Obtain the recognized text observations from the request's results.
                guard let observations = request.results as? [VNRecognizedTextObservation] else {
                    DispatchQueue.main.async {
                        self?.error = NSError(domain: "VisionError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Failed to cast results to VNRecognizedTextObservation"])
                    }
                    return
                }
                
                // Extract strings from the recognized text observations.
                var recognizedStrings = [""]
                for observation in observations {
                    guard let topCandidate = observation.topCandidates(1).first else { continue }
                    recognizedStrings.append(topCandidate.string)
                }
                
                // Update the recognizedText property with the concatenated recognized strings.
                DispatchQueue.main.async {
                    self?.recognizedText = recognizedStrings.joined(separator: " ")
                }
            }
            
            // Set the recognition level to accurate for more precise recognition.
            request.recognitionLevel = .accurate
            let requests = [request]
            
            // Convert the UIImage to CGImage as it's required by the VNImageRequestHandler.
            guard let cgImage = image.cgImage else { return }
            
            // Create a handler for the image and perform the text recognition request.
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            try? handler.perform(requests)
        }
    }
}
