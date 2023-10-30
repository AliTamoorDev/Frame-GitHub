//
//  NewProjectView.swift
//  Frame
//
//  Created by Ali Tamoor on 28/10/2023.
//

import SwiftUI

// MARK: - New Project
struct NewProjectView: View {
    @State private var dateOfVisit = Date()
    @State private var projectName = ""
    @State private var projectType = ""
    @State private var projectLocation = ""
    @State private var damageType = ""
    @State private var drawingImage: UIImage? = nil
    @State private var currentField: FieldToFill = .projectName
    @State private var shouldClearCanvas: Bool = false
    @ObservedObject var drawingViewModel = DrawingViewModel()
    var onSave: (Project) -> Void

    enum FieldToFill {
        case projectName
        case projectType
        case projectLocation
        case damageType
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Form {
                    Section {
                       
                    }
                    Section {
                        DatePicker("Date of Site Visit", selection: $dateOfVisit, displayedComponents: .date).accentColor(.blue)
                        TextField("Project Name", text: $projectName, onEditingChanged: { _ in self.currentField = .projectName })
                            .frame(height: 100)
//                        TextField("Project Name", text: $projectName)
                        TextField("Project Type", text: $projectType, onEditingChanged: { _ in self.currentField = .projectType })
                            .frame(height: 100)

                        TextField("Project Location", text: $projectLocation, onEditingChanged: { _ in self.currentField = .projectLocation })
                            .frame(height: 100)

                        TextField("Damage Type", text: $damageType, onEditingChanged: { _ in
                            
                            self.currentField = .damageType })
                        .frame(height: 100)

                    } header: {
                        Text("New Project Details")
                            .font(.headline)
                            .foregroundColor(Color.white)
//                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0)))
                    }

                }
                .navigationBarTitle("New Project", displayMode: .inline)
                
                Text("Writing For: \(currentFieldTitle)").font(.headline)
                
//                DrawingCanvas(drawingImage: $drawingImage, viewModel: drawingViewModel, shouldClear: $shouldClearCanvas)
//                    .frame(height: 300)
//                    .background(Color(UIColor.systemGray6))
//                    .cornerRadius(8)
                HStack {
                    Spacer()
                    VStack {
                        
                        Button("Done Writing") {
                            updateCurrentField()
                            shouldClearCanvas = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                        Button("Save Project") {
                            let newProject = Project(
                                dateOfVisit: dateOfVisit,
                                name: projectName,
                                type: projectType,
                                location: projectLocation,
                                damage: damageType,
                                rooms: []) // You need to provide the rooms information here
                            
                            onSave(newProject)
                        }
                        .padding()
                        .background(projectName.isEmpty || projectType.isEmpty || projectLocation.isEmpty || damageType.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .disabled(projectName.isEmpty || projectType.isEmpty || projectLocation.isEmpty || damageType.isEmpty)
                    }
                    .padding(.leading, 100)
                    
                    Spacer()
                    
                    Button(action: {
                        self.shouldClearCanvas = true
                    }) {
                        Text("Clear Canvas")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding([.trailing])
                }
            }
            .padding()
            .navigationTitle("Testing")
        }
    }
    
    var currentFieldTitle: String {
        switch currentField {
        case .projectName: return "Project Name"
        case .projectType: return "Project Type"
        case .projectLocation: return "Project Location"
        case .damageType: return "Damage Type"
        }
    }
    
    func updateCurrentField() {
        if !drawingViewModel.recognizedText.isEmpty {
            switch currentField {
            case .projectName:
                projectName = drawingViewModel.recognizedText
                if projectType.isEmpty { currentField = .projectType }
            case .projectType:
                projectType = drawingViewModel.recognizedText
                if projectLocation.isEmpty { currentField = .projectLocation }
            case .projectLocation:
                projectLocation = drawingViewModel.recognizedText
                if damageType.isEmpty { currentField = .damageType }
            case .damageType:
                damageType = drawingViewModel.recognizedText
            }
            drawingViewModel.recognizedText = ""
        }
    }
}

#Preview {
    NewProjectView { newProject in
//        projectData.projects.append(newProject)
//        showingNewProjectView = false
    }
}
