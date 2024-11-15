import Foundation

struct DescriptionModel: Identifiable {
    let id = UUID()
    let date: String
    let temperature: Int
    let windSpeed: Int
    let humidity: Int
    let condition: String
}
