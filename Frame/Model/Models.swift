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
struct Project: Identifiable, Equatable, Codable {
    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.id == rhs.id
            && lhs.dateOfVisit == rhs.dateOfVisit
            && lhs.name == rhs.name
            && lhs.type == rhs.type
            && lhs.location == rhs.location
            && lhs.damage == rhs.damage
    }

    var id = UUID()
    var dateOfVisit: Date
    var name: String
    var type: String
    var location: String
    var damage: String

    enum CodingKeys: String, CodingKey {
        case id, dateOfVisit, name, type, location, damage
    }

    init(id: UUID = UUID(), dateOfVisit: Date, name: String, type: String, location: String, damage: String) {
        self.id = id
        self.dateOfVisit = dateOfVisit
        self.name = name
        self.type = type
        self.location = location
        self.damage = damage
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        dateOfVisit = try container.decode(Date.self, forKey: .dateOfVisit)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        location = try container.decode(String.self, forKey: .location)
        damage = try container.decode(String.self, forKey: .damage)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(dateOfVisit, forKey: .dateOfVisit)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(location, forKey: .location)
        try container.encode(damage, forKey: .damage)
    }
}


// MARK: -
struct Division: Identifiable, Equatable, Codable {
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
struct Room: Identifiable, Equatable, Codable {
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
struct RoomDetailRowData: Equatable, Codable {
    var category: String
    var selector: String
    var action: String
    var quantity: String
    var desc: String
    
    init(category: String = "", selector: String = "", action: String = "", quantity: String = "", description: String = "") {
        self.category = category
        self.selector = selector
        self.action = action
        self.quantity = quantity
        self.desc = description
    }
    
    static func == (lhs: RoomDetailRowData, rhs: RoomDetailRowData) -> Bool {
        return lhs.category == rhs.category
        && lhs.selector == rhs.selector
        && lhs.action == rhs.action
        && lhs.quantity == rhs.quantity
        && lhs.desc == rhs.desc
    }
}
