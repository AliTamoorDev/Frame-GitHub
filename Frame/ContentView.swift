import SwiftUI
import PencilKit
import Vision
import UniformTypeIdentifiers


// MARK: - Observable Object

class ProjectData: ObservableObject {
    @Published var detailsArr: [Details] = []
//    @Published var projects: [Project] = []
//    @Published var division = Division(name: "", rooms: [], subDivisions: [])
}

//class Details: Identifiable,ObservableObject {
//    var id = UUID()
//    @Published var projects = Project(dateOfVisit: Date.now, name: "", type: "", location: "", damage: "", rooms: [])
//    @Published var division = Division(name: "", rooms: [], subDivisions: [])
//}


class Details: Identifiable, ObservableObject {
    var id = UUID()
    @Published var project: Project
    @Published var division: Division
    init(project: Project, division: Division) {
            self.project = project
            self.division = division
        }
}

// MARK: - Content View

struct ContentView: View {
    @ObservedObject var projectData = ProjectData()
    @State var division = Division(name: "", rooms: [], subDivisions: [])
    @State var proj = Project(dateOfVisit: Date.now, name: "", type: "", location: "", damage: "", rooms: [])
    @State private var showingNewProjectView = false
    @State private var selectedProjectIndex: Int?

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        HStack() {
           
            NavigationView {
                VStack {
                    Text("Premium Building Consultants")
                        .font(.title3)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0)))
                    
                    List {
                        ForEach($projectData.detailsArr) {$project in
                            NavigationLink(destination: ProjectDetailView(project: project.project, division: project.division)) {
                                Text(project.project.name)
                            }
                            
                        }
                        .onDelete(perform: deleteProject)
                        
                        
                        //                        ForEach(projectData.detailsArr.indices, id: \.self) { index in
                        //                            let project = projectData.detailsArr[index]
                        //                            NavigationLink(destination: ProjectDetailView(project: project.project, division: project.division)) {
                        //                                Text(project.project.name)
                        //                            }
                        //                            .onTapGesture {
                        //                                print("Index: \(index)")
                        //                                print(projectData.detailsArr[0].division)
                        //                            }
                        //                        }
                        //                        .onDelete(perform: deleteProject)
                    }
                    .accentColor(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0)))
                }
                .navigationTitle("Projects")
                .navigationBarItems(trailing: Button(action: { showingNewProjectView.toggle() }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                })
                .sheet(isPresented: $showingNewProjectView) {
                    NewProjectView { newProject in
                        let newProj = Details(project: newProject, division: Division(name: "", rooms: [], subDivisions: []))
                        projectData.detailsArr.append(newProj)
                        showingNewProjectView = false
                    }
                }
                VStack {
                    
                    Text("Premier Building Consultants")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0)))
                    Text("Building Consultant Scope App")
                        .font(.title)
                        .foregroundColor(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0)))
                    Spacer()
                }
                .padding(40)
            }
        }
    }

    func deleteProject(at offsets: IndexSet) {
        projectData.detailsArr.remove(atOffsets: offsets)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
