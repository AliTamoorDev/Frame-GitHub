//
//  ProjectDetailView2.swift
//  Frame
//
//  Created by Ali Tamoor on 29/10/2023.
//

import Foundation
//
//  ProjectDetailView.swift
//  Frame
//
//  Created by Ali Tamoor on 28/10/2023.
//

import SwiftUI

// MARK: - Project Detail
struct ProjectDetailView2: View {
    @State var project: Project
    //    @State var content: Content
    @Binding var parent: Division
    @Binding var division: Division
    @State private var showingAlert = false
    @State private var showingGroupSheet = false
    @State var isExportingCSV = false
    @State var isGroupCreated:Bool = true
    @State var isRoomCreated:Bool = true
    @State var addGroupOrRoom = "Rooms/Area"
    @EnvironmentObject var projectData: ProjectData

    var currentLvlCount: Int
    var path:String = ""
    
    var body: some View {
        VStack {
            Divider()
            Text(path)
                .font(.title)
            Divider()
            
            List {
                Section(header: Text("Project Insights").font(.title3).bold()) {
                    HStack {
                        Text("Date of Visit:")
                            .bold()
                        Spacer()
                        Text("\(project.dateOfVisit, formatter: DateFormatter.shortDate)")
                    }
                    HStack {
                        Text("Project Name:")
                            .bold()
                        Spacer()
                        Text(project.name)
                    }
                    HStack {
                        Text("Type:")
                            .bold()
                        Spacer()
                        Text(project.type)
                    }
                    HStack {
                        Text("Location:")
                            .bold()
                        Spacer()
                        Text(project.location)
                    }
                    HStack {
                        Text("Damage:")
                            .bold()
                        Spacer()
                        Text(project.damage)
                    }
                }
                Section(header: Text(addGroupOrRoom).font(.title3), footer: addButton) {
                    //                if isRoomCreated{
                    ForEach(division.rooms) { room in
                        NavigationLink(destination: RoomDetailsView(room: $division.rooms[division.rooms.firstIndex(where: { $0.id == room.id })!])
                            .environmentObject(projectData)
                        ) {
                            Text(room.name)
                        }
                    }
                    .onDelete(perform: deleteRoom)
                    //                }
                    
                    //                if isGroupCreated{
                    ForEach($division.subDivisions) { $subDivision in
                        NavigationLink {
                            ProjectDetailView2(project: Project(dateOfVisit: project.dateOfVisit, name: project.name, type: project.type, location: project.location, damage: project.damage), parent: $parent, division: $subDivision, currentLvlCount: currentLvlCount + 1, path: "\(path) → \(subDivision.name)")
                                .environmentObject(projectData)
                            
                        } label: {
                            Text(subDivision.name)
                        }
                        .id(subDivision.id)
                        
                    }
                    .onDelete(perform: deleteDivision)
                    //                }
                }
            }
            .onChange(of: division.subDivisions, { oldValue, newValue in
                setText()
            })
            .onChange(of: division.rooms, { oldValue, newValue in
                setText()
            })
            .onAppear{
                setText()
            }
            
            //        .padding(.horizontal)
            .listStyle(GroupedListStyle())
            .textCase(nil)
            .navigationBarTitle("\(division.name) Details", displayMode: .large)
//            .navigationBarItems(trailing: Button(action: saveAndShareCSV) {
//                Text("Save & Share")
//                    .foregroundColor(.white)
//                    .padding(.horizontal, 20)
//                    .padding(.vertical, 10)
//                    .background(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0))) // Adjust
//                    .cornerRadius(8)
//                    .fileExporter(
//                        isPresented: $isExportingCSV,
//                        document: MessageDocument(message: self.toCSV()),
//                        contentType:  .commaSeparatedText,
//                        defaultFilename: "\(project.name).csv"
//                    ) { result in
//                        if case .success = result {
//                            //                        showAlert.toggle()
//                            print("CSV export success!")
//                        } else {
//                            print("CSV export canceled or failed.")
//                        }
//                    }
//                
//            })
            
            //        }
            
            .sheet(isPresented: $showingGroupSheet) {
                NewRoomView { name in
                    self.addDivision(named: name)
                    self.isRoomCreated = false
                    self.showingGroupSheet = false
                    //                addGroupOrRoom = "Group"
                }
                .presentationDetents([.medium, .large])
            }
            .sheet(isPresented: $showingAlert) {
                NewRoomView { name in
                    self.addRoom(named: name)
                    self.isGroupCreated = false
                    self.showingAlert = false
                    //                addGroupOrRoom = "Room"
                }
            }
//            Text("Current Level: \(currentLvlCount)")
//                .frame(maxWidth: .infinity)
//                .font(.title3)
        }
    }
    
    private var addButton: some View {
        HStack {
            if division.rooms.isEmpty {
                Button(action: { self.showingGroupSheet = true }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0)))
                        Text("Add Area")
                            .foregroundColor(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0)))
                        
                    }
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0)), lineWidth: 2))
                }
            }
            if division.subDivisions.isEmpty{
                Button(action: { self.showingAlert = true }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0)))
                        Text("Add Room")
                            .foregroundColor(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0)))
                        
                    }
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0)), lineWidth: 2))
                }
            }
        }
    }
    
    
    // MARK: - Functions
    func setText() {
        if division.subDivisions.isEmpty && division.rooms.isEmpty {
            addGroupOrRoom = "Rooms/Area"
        } else if division.subDivisions.count > 0{
            addGroupOrRoom = "Area"
        } else {
            addGroupOrRoom = "Rooms"
        }
    }
    
    func addRoom(named name: String) {
        division.rooms.append(Room(name: name))
        DataStore.shared.saveProjectData(projectData)
    }
    
    func deleteRoom(at offsets: IndexSet) {
        division.rooms.remove(atOffsets: offsets)
        DataStore.shared.saveProjectData(projectData)
    }
    
    func addDivision(named name: String) {
        division.subDivisions.append(Division(name: name, rooms: [], subDivisions: []))
        DataStore.shared.saveProjectData(projectData)
    }
    
    func deleteDivision(at offsets: IndexSet) {
        division.subDivisions.remove(atOffsets: offsets)
        DataStore.shared.saveProjectData(projectData)
    }
    
    
    func saveAndShareCSV() {
        isExportingCSV.toggle()
    }
}

//#Preview {
//    ProjectDetailsView2()
//}
