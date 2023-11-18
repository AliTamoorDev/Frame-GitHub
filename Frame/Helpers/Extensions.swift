//
//  Extensions.swift
//  Frame
//
//  Created by Ali Tamoor on 28/10/2023.
//

import Foundation
import SwiftUI


//MARK: Convert to CSV
extension ProjectDetailView {
    func toCSV() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: detail.project.dateOfVisit)

        var csvString = "Date of Visit,Project Name,Project Type,Project Location,Damage Type\n"
        csvString += "\(formattedDate),\(detail.project.name),\(detail.project.type),\(detail.project.location),\(detail.project.damage)\n\n"

        var endResult = csvString + concatenateDivisionNames(detail.division, depth: 0)
        print(endResult)
        return endResult
    }

    // Recursive function for concatenating room details
    func roomDetails(room: Room, depth: Int) -> String {
        var result = ""
        result += "\n" + String(repeating: ",", count: depth) + room.name
        result += "\n" + String(repeating: ",", count: depth + 1) + "Category,Category Description,Selector,Action,Quantity,Description"
        for detail in room.details {
            let comp = detail.category.components(separatedBy: ":")
            var catAbr = ""
            var catDesc = detail.category
            if comp.indices.contains(0) {
                catAbr = comp[0]
            }
            if comp.indices.contains(1) {
                catDesc = comp[1]
            } else {
                catAbr = ""
            }
            result += "\n" + String(repeating: ",", count: depth + 1) + "\(catAbr.replacingOccurrences(of: ",", with: "")),\(catDesc.replacingOccurrences(of: ",", with: "")),\(detail.selector),\(detail.action),\(detail.quantity),\(detail.desc)"
        }
        return result
    }

    // Recursive function for concatenating division names
    func concatenateDivisionNames(_ div: Division, depth: Int) -> String {
        var result = String(repeating: ",", count: depth) + div.name
//        var result = div.name

        for subDivision in div.subDivisions {
            result += "\n" + concatenateDivisionNames(subDivision, depth: depth + 1)
        }
        for room in div.rooms {
            
            result += roomDetails(room: room, depth: depth + 1)
        }
        return result
    }

    
//        func toCSV() -> String {
//    
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            let formattedDate = dateFormatter.string(from: project.dateOfVisit)
//            let emptyTxt = ""
//    
//            var csvString = "Date of Visit,Project Name,Project Type,Project Location,Damage Type\n"
//            csvString += "\(formattedDate),\(project.name),\(project.type),\(project.location),\(project.damage)\n\n"
//    
//            for room in project.rooms {
//                csvString += " \n"
//                csvString += "Room,Category,Category Description,Selector,Action,Quantity & Description\n"
//                for detail in room.details {
//    
//                   // For Splitting Category into Abrv & Desc
//                    let comp = detail.category.components(separatedBy: ":")
//                    var catAbr = ""
//                    var catDesc = detail.category
//                    if comp.indices.contains(0) {
//                         catAbr = comp[0]
//                    }
//                    if comp.indices.contains(1) {
//                         catDesc = comp[1]
//                    } else {
//                        catAbr = ""
//                    }
//                    // Main String
//                    csvString += "\(room.name),\(catAbr.replacingOccurrences(of: ",", with: "")),\(catDesc.replacingOccurrences(of: ",", with: "")),\(detail.selector),\(detail.action),\(detail.quantityAndDescription)\n"
//                }
//                csvString += "\n"
//            }
//            return csvString
//        }
}

extension ProjectDetailView2 {    
    func toCSV() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: project.dateOfVisit)

        var csvString = "Date of Visit,Project Name,Project Type,Project Location,Damage Type\n"
        csvString += "\(formattedDate),\(project.name),\(project.type),\(project.location),\(project.damage)\n\n"

        var endResult = csvString + concatenateDivisionNames(parent, depth: 0)
        print(endResult)
        return endResult
    }

    // Recursive function for concatenating room details
    func roomDetails(room: Room, depth: Int) -> String {
        var result = ""
        result += "\n" + String(repeating: ",", count: depth) + room.name
        result += "\n" + String(repeating: ",", count: depth + 1) + "Category,Category Description,Selector,Action,Quantity,Description"
        for detail in room.details {
            let comp = detail.category.components(separatedBy: ":")
            var catAbr = ""
            var catDesc = detail.category
            if comp.indices.contains(0) {
                catAbr = comp[0]
            }
            if comp.indices.contains(1) {
                catDesc = comp[1]
            } else {
                catAbr = ""
            }
            result += "\n" + String(repeating: ",", count: depth + 1) + "\(catAbr.replacingOccurrences(of: ",", with: "")),\(catDesc.replacingOccurrences(of: ",", with: "")),\(detail.selector),\(detail.action),\(detail.quantity),\(detail.desc)"
        }
        return result
    }

    // Recursive function for concatenating division names
    func concatenateDivisionNames(_ div: Division, depth: Int) -> String {
        var result = String(repeating: ",", count: depth) + div.name
//        var result = div.name

        for subDivision in div.subDivisions {
            result += "\n" + concatenateDivisionNames(subDivision, depth: depth + 1)
        }
        for room in div.rooms {
            
            result += roomDetails(room: room, depth: depth + 1)
        }
        return result
    }

}

extension Alert {
    init(_ textAlert: TextAlert) {
        self.init(title: Text(textAlert.title), message: nil, primaryButton: .default(Text("OK"), action: {
            textAlert.action(textAlert.placeholder)
        }), secondaryButton: .cancel())
    }
}

extension DateFormatter {
    static var shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}

