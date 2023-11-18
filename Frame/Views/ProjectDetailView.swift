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
//    @State var project: Project
//    @State var content: Content
    var currentLvlCount = 0
//    @State var division: Division
    @State private var showingAlert = false
    @State private var showingGroupSheet = false
    @State var isExportingCSV = false
    @State var isGroupCreated:Bool = true
    @State var isRoomCreated:Bool = true
    @State var addGroupOrRoom = "Rooms/Area"
    @ObservedObject var detail: Details
    @EnvironmentObject var projectData: ProjectData

    var body: some View {
        VStack {
            List {
                Section(header: Text("Project Insights").font(.title3).bold()) {
                    HStack {
                        Text("Date of Visit:")
                            .bold()
                        Spacer()
                        Text("\(detail.project.dateOfVisit, formatter: DateFormatter.shortDate)")
                    }
                    HStack {
                        Text("Project Name:")
                            .bold()
                        Spacer()
                        Text(detail.project.name)
                    }
                    HStack {
                        Text("Type:")
                            .bold()
                        Spacer()
                        Text(detail.project.type)
                    }
                    HStack {
                        Text("Location:")
                            .bold()
                        Spacer()
                        Text(detail.project.location)
                    }
                    HStack {
                        Text("Damage:")
                            .bold()
                        Spacer()
                        Text(detail.project.damage)
                    }
                }
                Section(header: Text(addGroupOrRoom).font(.title3), footer: addButton) {
                    //                if isRoomCreated{
                    ForEach(detail.division.rooms) { room in
                        NavigationLink(destination: RoomDetailsView(room: $detail.division.rooms[detail.division.rooms.firstIndex(where: { $0.id == room.id })!])
                            .environmentObject(projectData)
                        ) {
                            Text(room.name)
                        }
                    }
                    .onDelete(perform: deleteRoom)
                    //                }
                    
                    //                if isGroupCreated{
                    ForEach($detail.division.subDivisions) { $subDivision in
                        NavigationLink {
                            ProjectDetailView2(project: detail.project, parent: $detail.division, division: $subDivision, currentLvlCount: currentLvlCount + 1, path: "\(subDivision.name)")
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
            .onChange(of: detail.division.subDivisions, { oldValue, newValue in
                setText()
            })
            .onChange(of: detail.division.rooms, { oldValue, newValue in
                setText()
            })
            .onAppear{
                setText()
            }
            //        .padding(.horizontal)
            .listStyle(GroupedListStyle())
            .textCase(nil)
            .navigationBarTitle("\(detail.division.name)", displayMode: .inline)
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
                        defaultFilename: "\(detail.project.name).csv"
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
                    self.showingGroupSheet = false
                    //                addGroupOrRoom = "Group"
                }
            }
            .sheet(isPresented: $showingAlert) {
                NewRoomView { name in
                    self.addRoom(named: name)
                    self.showingAlert = false
                }
            }
            
//            Text("Current Level: \(currentLvlCount)")
//                .frame(maxWidth: .infinity)
//                .font(.title3)
        }
    }
    
    func setText() {
        if detail.division.subDivisions.isEmpty && detail.division.rooms.isEmpty {
            addGroupOrRoom = "Rooms/Area"
        } else if detail.division.subDivisions.count > 0{
            addGroupOrRoom = "Area"
        } else {
            addGroupOrRoom = "Rooms"
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
        detail.division.rooms.append(Room(name: name))
        DataStore.shared.saveProjectData(projectData)
        self.isGroupCreated = false
    }
    
    func deleteRoom(at offsets: IndexSet) {
        detail.division.rooms.remove(atOffsets: offsets)
        if detail.division.rooms.isEmpty {
            self.isGroupCreated = true
        }
        DataStore.shared.saveProjectData(projectData)
    }
    
    func addDivision(named name: String) {
        detail.division.subDivisions.append(Division(name: name, rooms: [], subDivisions: []))
        self.isRoomCreated = false
        DataStore.shared.saveProjectData(projectData)
    }
    
    func deleteDivision(at offsets: IndexSet) {
        detail.division.subDivisions.remove(atOffsets: offsets)
        if detail.division.rooms.isEmpty {
            self.isRoomCreated = true
        }
        DataStore.shared.saveProjectData(projectData)
    }
    
    
    func saveAndShareCSV() {
//        tempDiv = division
        isExportingCSV.toggle()
    }
}

//#Preview {
//    ProjectDetailsView()
//}
