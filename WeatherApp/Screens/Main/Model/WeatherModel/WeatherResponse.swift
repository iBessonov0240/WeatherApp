import Foundation

struct WeatherResponse: Decodable {
    let city: City?
    let list: [Weather]?

    struct City: Decodable {
        let name: String?
    }

    struct Weather: Decodable {
        let main: Main?
        let wind: Wind?
        let weather: [WeatherCondition]?
        let dt_txt: String?

        struct Main: Decodable {
            let temp: Double?
            let humidity: Int?
        }

        struct Wind: Decodable {
            let speed: Double?
        }

        struct WeatherCondition: Decodable {
            let main: String?
            let description: String?
        }
    }
}
