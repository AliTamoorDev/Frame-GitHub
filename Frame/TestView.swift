import SwiftUI

struct Area1 {
    var name: String
    var subAreas: [Area1]
    var rooms: [String]
}

struct ContentView1: View {
    @State private var area: Area1 = Area1(name: "Main Area", subAreas: [], rooms: [])

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Rooms")) {
                        ForEach(area.rooms, id: \.self) { room in
                            Text(room)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Area: \(area.name)")

                HStack {
                    Button("Add Room") {
                        self.area.rooms.append("New Room")
                    }
                    Button("Add SubArea") {
                        let newSubArea = Area1(name: "SubArea", subAreas: [], rooms: [])
                        self.area.subAreas.append(newSubArea)
                    }
                }
                .padding()
            }
        }
    }
}

struct AreaView: View {
    var area: Area1

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("SubAreas")) {
                        ForEach(area.subAreas, id: \.name) { subArea in
                            NavigationLink(destination: AreaView(area: subArea)) {
                                Text(subArea.name)
                            }
                        }
                    }
                    Section(header: Text("Rooms")) {
                        ForEach(area.rooms, id: \.self) { room in
                            Text(room)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Area: \(area.name)")

                HStack {
                    Button("Add Room") {
                        // Add room logic here
                    }
                    Button("Add SubArea") {
                        // Add subarea logic here
                    }
                }
                .padding()
            }
        }
    }
}

