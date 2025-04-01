import Foundation

struct Customer: Identifiable, Codable {
    var Id: Int
    var DisplayName: String
    var Locations: [Location]
    var IsActive: Bool
    var LocationErrors: [String]

    var id: Int { Id } // Conforming to Identifiable

    var city: String {
        Locations.first?.City ?? "Unknown"
    }

    var hasLocationErrors: Bool {
        !LocationErrors.isEmpty
    }
}


struct Location: Codable {
    var City: String
}
