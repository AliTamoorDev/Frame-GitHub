//
//  ProjectDetailView.swift
//  Frame
//
//  Created by Ali Tamoor on 28/10/2023.
//

import SwiftUI

// MARK: - Project Detail
struct ProjectDetailView: View {
//    @State var tempDiv = Division(name: "", rooms: [], subDivisions: [])
    @State var project: Project
//    @State var content: Content
    @State var division: Division
    @State private var showingAlert = false
    @State private var showingGroupSheet = false
    @State var isExportingCSV = false
    @State var isGroupCreated:Bool = true
    @State var isRoomCreated:Bool = true
    @State var addGroupOrRoom = "Rooms/Group"

    var body: some View {
//        VStack {
        List {
            Section() {
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
                    ForEach(project.rooms) { room in
                        NavigationLink(destination: RoomDetailsView(room: $project.rooms[project.rooms.firstIndex(where: { $0.id == room.id })!])) {
                            Text(room.name)
                        }
                    }
                    .onDelete(perform: deleteRoom)
//                }
                
//                if isGroupCreated{
                ForEach($division.subDivisions) { $subDivision in
                        NavigationLink {
                            ProjectDetailView2(project: Project(dateOfVisit: project.dateOfVisit, name: project.name, type: project.type, location: project.location, damage: project.damage, rooms: []), parent: $division, division: $subDivision)
                        } label: {
                            Text(subDivision.name)
                        }
                        .id(subDivision.id)
                    
                    }
                    .onDelete(perform: deleteRoom)
//                }
            }
        }
        
        .padding(.horizontal)
        .listStyle(GroupedListStyle())
                .textCase(nil)
            .navigationTitle("Project Details")
            .navigationBarItems(trailing: Button(action: saveAndShareCSV) {
                Text("Save & Share")
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0))) // Adjust
                    .cornerRadius(8)
                    .fileExporter(
                    isPresented: $isExportingCSV,
                    document: MessageDocument(message: self.toCSV()),
                    contentType:  .commaSeparatedText,
                    defaultFilename: "\(project.name).csv"
                ) { result in
                    if case .success = result {
//                        showAlert.toggle()
                        print("CSV export success!")
                    } else {
                        print("CSV export canceled or failed.")
                    }
                }
                
            })
        
//        }
        
        .sheet(isPresented: $showingGroupSheet) {
            NewRoomView { name in
                self.addDivision(named: name)
                self.isRoomCreated = false
                self.showingGroupSheet = false
                addGroupOrRoom = "Group"
            }
        }
        .sheet(isPresented: $showingAlert) {
            NewRoomView { name in
                self.addRoom(named: name)
                self.isGroupCreated = false
                self.showingAlert = false
                addGroupOrRoom = "Room"
            }
        }
    }
    
    private var addButton: some View {
        HStack {
            if isGroupCreated {
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
            if isRoomCreated{
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
    
    func addRoom(named name: String) {
        project.rooms.append(Room(name: name))
    }
    
    func deleteRoom(at offsets: IndexSet) {
        project.rooms.remove(atOffsets: offsets)
    }
    
    func addDivision(named name: String) {
        division.subDivisions.append(Division(name: name, rooms: [], subDivisions: []))
    }
    
    func deleteDivision(at offsets: IndexSet) {
        project.rooms.remove(atOffsets: offsets)
    }
    
    
    func saveAndShareCSV() {
//        tempDiv = division
        isExportingCSV.toggle()
    }
}

//#Preview {
//    ProjectDetailsView()
//}
