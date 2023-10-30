//
//  Models.swift
//  Frame
//
//  Created by Ali Tamoor on 28/10/2023.
//

import Foundation

// MARK: - Data Models

struct TextAlert {
    var title: String
    var placeholder: String = ""
    var action: (String?) -> Void
}

// MARK: -
struct Content: Identifiable {
    var id = UUID()
    var project: Division
    var division: Division
}

// MARK: -
struct Project: Identifiable, Equatable {
    
    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.id == rhs.id
            && lhs.dateOfVisit == rhs.dateOfVisit
            && lhs.name == rhs.name
            && lhs.type == rhs.type
            && lhs.location == rhs.location
            && lhs.damage == rhs.damage
            && lhs.rooms == rhs.rooms
    }
    var id = UUID()
    var dateOfVisit: Date
    var name: String
    var type: String
    var location: String
    var damage: String
    var rooms: [Room]
}

// MARK: -
struct Division: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var rooms: [Room]
    var subDivisions: [Division]

    static func == (lhs: Division, rhs: Division) -> Bool {
        return lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.rooms == rhs.rooms
            && lhs.subDivisions == rhs.subDivisions
    }
}

// MARK: -
struct Room: Identifiable,Equatable {
    var id = UUID()
    var name: String
    var details: [RoomDetailRowData] = []
    static func == (lhs: Room, rhs: Room) -> Bool {
            return lhs.id == rhs.id
                && lhs.name == rhs.name
                && lhs.details == rhs.details
        }
}

// MARK: -
struct RoomDetailRowData: Equatable {
    var category: String
    var selector: String
    var action: String
    var quantityAndDescription: String
    
    init(category: String = "", selector: String = "", action: String = "", quantityAndDescription: String = "") {
        self.category = category
        self.selector = selector
        self.action = action
        self.quantityAndDescription = quantityAndDescription
    }
    static func == (lhs: RoomDetailRowData, rhs: RoomDetailRowData) -> Bool {
            return lhs.category == rhs.category
                && lhs.selector == rhs.selector
                && lhs.action == rhs.action
                && lhs.quantityAndDescription == rhs.quantityAndDescription
        }
}
