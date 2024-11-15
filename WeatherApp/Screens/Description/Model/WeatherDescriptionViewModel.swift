import Foundation

final class WeatherDescriptionViewModel: ObservableObject {

    // MARK: - Property

    @Published var title: String = ""
    @Published var daysOfWeek = []

    // MARK: - Functions

    func iconName(for condition: String) -> String {
        switch condition.lowercased() {
        case "clouds":
            return "cloud.fill"
        case "clear":
            return "sun.max.fill"
        case "rain":
            return "cloud.rain.fill"
        case "snow":
            return "snow"
        case "thunderstorm":
            return "cloud.bolt.fill"
        case "drizzle":
            return "cloud.drizzle.fill"
        case "mist", "fog":
            return "cloud.fog.fill"
        default:
            return "questionmark.circle"
        }
    }

    func getDayOfWeek(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = dateFormatter.date(from: dateString) else {
            return "Unknown"
        }

        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        }

        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEEE"
        return weekdayFormatter.string(from: date)
    }
}
