//
//  NewRoomView.swift
//  Frame
//
//  Created by Ali Tamoor on 28/10/2023.
//

import SwiftUI

// MARK: - New Room


struct NewRoomView: View {
    @State private var roomName = ""
    @ObservedObject var drawingViewModel = DrawingViewModel()
    @State private var drawingImage: UIImage? = nil
    @State private var shouldClearCanvas: Bool = false // Added this line for the canvas clearing functionality
    var onSave: (String) -> Void

    var body: some View {
        NavigationView {
            VStack(spacing: 15) { // Added spacing for better visual appearance
                Text("New Area/Room")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0)))
                TextField("Add Data", text: $roomName)
//                    .frame(height: 200)
//
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 50)
                    .padding(5)
                    .background(Color(UIColor.tertiarySystemFill))
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 0.5))
                    .navigationBarTitle("Add New Room", displayMode: .inline)
                
//                VStack {
                    
//                    DrawingCanvas(drawingImage: $drawingImage, viewModel: drawingViewModel, shouldClear: $shouldClearCanvas)
//                }
//                    .cornerRadius(8) // Rounded the corners
                
                Button("Done Writing") {
                    // Update roomName with recognizedText from the ViewModel
                    if !drawingViewModel.recognizedText.isEmpty{
                        roomName = drawingViewModel.recognizedText
                        shouldClearCanvas = true // Added this line to clear the canvas
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button(action: { onSave(roomName) }) {
                    Text("Save")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(roomName.isEmpty ? Color.gray : Color.blue) // Disable button if roomName is empty
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(roomName.isEmpty) // Disable button if roomName is empty
                Spacer()
            }
            .padding() // Added padding for better visual appearance
        }
    }
}

//#Preview {
//    NewRoomView()
//}
