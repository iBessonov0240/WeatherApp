import SwiftUI

struct WeatherDescription: View {

    // MARK: - Property

    @StateObject var viewModel = WeatherDescriptionViewModel()
    let forecast: [DescriptionModel]

    // MARK: - View

    var body: some View {
        ZStack {
            Image("cloud2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            VStack {
                Text(viewModel.title)
                    .font(.system(size: 34, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()

                List(forecast) { day in
                    DayOfWeekCell(
                        dayTitle: viewModel.getDayOfWeek(from: day.date),
                        condition: viewModel.iconName(for: day.condition),
                        windSpeed: day.windSpeed,
                        humidity: day.humidity,
                        temperature: day.temperature
                    )
                    .listRowInsets(EdgeInsets())
                }
                .scrollContentBackground(.hidden)
                .padding(.top, 5)
                .padding(.horizontal)
                .scrollIndicators(.hidden)
                .listStyle(.insetGrouped)
            }
            .padding(.bottom, 25)
        }
    }
}

#Preview {
    WeatherDescription(forecast: [])
}
