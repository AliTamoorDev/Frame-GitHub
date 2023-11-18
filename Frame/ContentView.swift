import SwiftUI
import PencilKit
import Vision
import UniformTypeIdentifiers


// MARK: - Observable Object

class ProjectData: ObservableObject, Codable {
    @Published var detailsArr: [Details] = []
    
    enum CodingKeys: String, CodingKey {
        case detailsArr
    }
    
    init(detailsArr: [Details] = []) {
        self.detailsArr = detailsArr
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        detailsArr = try container.decode([Details].self, forKey: .detailsArr)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(detailsArr, forKey: .detailsArr)
    }
}


class Details: Identifiable, ObservableObject, Codable {
    var id = UUID()
    @Published var project: Project
    @Published var division: Division
    init(project: Project, division: Division) {
        self.project = project
        self.division = division
    }
    
    enum CodingKeys: String, CodingKey {
            case id, project, division
        }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(UUID.self, forKey: .id)
            project = try container.decode(Project.self, forKey: .project)
            division = try container.decode(Division.self, forKey: .division)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(project, forKey: .project)
            try container.encode(division, forKey: .division)
        }
}

// MARK: - Content View

struct ContentView: View {
    @StateObject var projectData = ProjectData()
    @State var division = Division(name: "", rooms: [], subDivisions: [])
    @State var proj = Project(dateOfVisit: Date.now, name: "", type: "", location: "", damage: "")
    @State private var showingNewProjectView = false
    @State private var selectedProjectIndex: Int?

//    init() {
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//    }
    
    var body: some View {
        HStack() {
           
            NavigationView {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Projects")
                            .bold()
                            .font(.title)
                            .font(.system(size: 40))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                        
                        Text("Premium Building Consultants")
                            .font(.title3)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                    }

                    .background(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0)))
                    
                    
                    List {
                        ForEach(projectData.detailsArr) {project in
                            NavigationLink(destination: ProjectDetailView(detail: project).environmentObject(projectData)) {
                                Text(project.project.name)
                            }
                            
                        }
                        .onDelete(perform: deleteProject)
                    }
                    .accentColor(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0)))
                    
                    Button {
                        DataStore.shared.saveProjectData(projectData)
                    } label: {
                        Text("Save in App")
                            .padding()
                            .foregroundStyle(.white)
                            .background(Color(UIColor(red: 9/255, green: 41/255, blue: 78/255, alpha: 1.0)))
                            .cornerRadius(10)
                    }
                }
                .onAppear(perform: {
                    if let data =  DataStore.shared.loadProjectData() {
                        projectData.detailsArr = data.detailsArr
                    }
                })
                .navigationBarTitle("", displayMode: .inline)

//                .navigationTitle("Projects")
                .navigationBarItems(trailing: Button(action: { showingNewProjectView.toggle() }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                })
                .sheet(isPresented: $showingNewProjectView) {
                    NewProjectView { newProject in
                        let newProj = Details(project: newProject, division: Division(name: "", rooms: [], subDivisions: []))
                        projectData.detailsArr.append(newProj)
                        DataStore.shared.saveProjectData(projectData)
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
        DataStore.shared.saveProjectData(projectData)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
