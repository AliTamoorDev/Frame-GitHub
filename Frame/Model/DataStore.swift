//
//  DataStore.swift
//  Frame
//
//  Created by Ali Tamoor on 19/11/2023.
//

import Foundation

class DataStore {
    static let shared = DataStore()

    private let projectDataKey = "projectData2"

    func saveProjectData(_ projectData: ProjectData) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(projectData) {
            UserDefaults.standard.set(encodedData, forKey: projectDataKey)
        }
    }

    func loadProjectData() -> ProjectData? {
        if let savedData = UserDefaults.standard.data(forKey: projectDataKey) {
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode(ProjectData.self, from: savedData) {
                return loadedData
            }
        }
        return nil
    }
}
