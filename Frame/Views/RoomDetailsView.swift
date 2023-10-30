//
//  RoomDetailsView.swift
//  Frame
//
//  Created by Ali Tamoor on 28/10/2023.
//

import SwiftUI

// MARK: - Room Detail

struct RoomDetailsView: View {
    @Binding var room: Room
    @State private var currentField: FieldToFill = .projectName
    @State private var shouldClearCanvas: Bool = false
    @ObservedObject var drawingViewModel = DrawingViewModel()
    @State private var drawingImage: UIImage? = nil
    @State private var data: String = ""
    @State private var fieldTitle: String = "Category"
    
    enum FieldToFill {
        case projectName
        case projectType
        case projectLocation
        case damageType
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Form {
                Section(header: Text(room.name)) {
                    ForEach(room.details.indices, id: \.self) { index in
                        RowView(row: $room.details[index], data: $data, fieldTitle: $fieldTitle)
                    }
                    .onDelete(perform: deleteRow)
                }
            }
            .navigationBarTitle(room.name, displayMode: .inline)
            .navigationBarItems(trailing: EditButton())
            
            Spacer()
            if !room.details.isEmpty {
                VStack(alignment: .center) {
                    Text("Writing For: \(fieldTitle)").font(.headline)
//                    DrawingCanvas(drawingImage: $drawingImage, viewModel: drawingViewModel, shouldClear: $shouldClearCanvas)
//                        .padding()
//                        .frame(height: 400)
                    HStack {
//                        Spacer()
                        VStack {
                            
                            Button("Done Writing") {
                                data = drawingViewModel.recognizedText
                                shouldClearCanvas = true
                                drawingViewModel.recognizedText = ""
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                        .padding(.trailing, 80)
                        
//                        Spacer()
                        
                        Button(action: {
                            self.shouldClearCanvas = true
                        }) {
                            Text("Clear Canvas")
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.trailing)
                    }
                }
            }
            AddRowButton(action: addRow)
        }
    }
//    func updateCurrentField() {
//        if !drawingViewModel.recognizedText.isEmpty {
//            switch currentField {
//            case .projectName:
//                projectName = drawingViewModel.recognizedText
//                if projectType.isEmpty { currentField = .projectType }
//            case .projectType:
//                projectType = drawingViewModel.recognizedText
//                if projectLocation.isEmpty { currentField = .projectLocation }
//            case .projectLocation:
//                projectLocation = drawingViewModel.recognizedText
//                if damageType.isEmpty { currentField = .damageType }
//            case .damageType:
//                damageType = drawingViewModel.recognizedText
//            }
//            drawingViewModel.recognizedText = ""
//        }
//    }
    func addRow() {
        room.details.append(RoomDetailRowData())
    }
    
    func deleteRow(at offsets: IndexSet) {
        room.details.remove(atOffsets: offsets)
    }
}

//#Preview {
//    RoomDetailView()
//}
