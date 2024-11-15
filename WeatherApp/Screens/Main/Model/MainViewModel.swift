import Foundation

final class MainViewModel: ObservableObject {

    // MARK: - Properties

    @Published var temperature: Int = 0
    @Published var text: String = ""
    @Published var cityName: String = ""
    @Published var isShowWeatherDescription: Bool = false
    @Published var fiveDayForecast: [DescriptionModel] = []
    private var fetchTask: Task<Void, Never>?

    // MARK: - Functions

    @MainActor
    func fetchWeather() async {
        fetchTask?.cancel()

        fetchTask = Task {
            do {
                let weatherResponse = try await APIManager.shared.fetchWeather(for: text)
                if let firstWeather = weatherResponse.list?.first {
                    self.temperature = Int((firstWeather.main?.temp ?? 273.15) - 273.15)
                    self.cityName = weatherResponse.city?.name ?? ""
                    self.text = ""

                    self.fiveDayForecast = extractFiveDayForecast(from: weatherResponse.list ?? [])
                }
            } catch {
                print("Error fetching weather: \(error)")
            }
        }
    }

    private func extractFiveDayForecast(from list: [WeatherResponse.Weather]) -> [DescriptionModel] {

        var dailyForecast: [DescriptionModel] = []

        for item in list {
            let date = item.dt_txt ?? ""
            if date.contains("12:00:00") {
                let temperature = Int((item.main?.temp ?? 273.15) - 273.15)
                let windSpeed = Int(item.wind?.speed ?? 0)
                let humidity = item.main?.humidity ?? 0
                let condition = item.weather?.first?.main ?? "Unknown"

                dailyForecast.append(
                    DescriptionModel(
                        date: date,
                        temperature: temperature,
                        windSpeed: windSpeed,
                        humidity: humidity,
                        condition: condition
                    )
                )
                if dailyForecast.count == 5 { break }
            }
        }

        return dailyForecast
    }

    func weatherCityDescription() {
        isShowWeatherDescription = true
    }
}