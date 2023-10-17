//
//  ToDo.swift
//  Lab - List
//
//  Created by Everett Brothers on 10/17/23.
//

import Foundation

struct ToDo: Equatable, Codable {
    var id = UUID()
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static var documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static var archiveURL = documentDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")
    
    static func saveToFile(tasks: [ToDo]) {
        let propertyEncoder = PropertyListEncoder()
        
        if let encoded = try? propertyEncoder.encode(tasks) {
            try? encoded.write(to: archiveURL, options: .noFileProtection)
        }
    }
    
    static func loadFromFile() -> [ToDo] {
        let propertyDecoder = PropertyListDecoder()
        
        if let data = try? Data(contentsOf: archiveURL) {
            let decoded = try? propertyDecoder.decode([ToDo].self, from: data)
            return decoded ?? [ToDo(title: "SampleTask", isComplete: false, dueDate: Date.now)]
        }
        
        return [ToDo(title: "SampleTask", isComplete: false, dueDate: Date.now)]
    }
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
}
