import Foundation

// MARK: - Caption
struct Caption: Codable {
    let quote: String
    let author: Author
    let id: UUID
}

// Author.swift

enum Author: String, Codable {
    case michaelScott = "Michael Scott"
}
