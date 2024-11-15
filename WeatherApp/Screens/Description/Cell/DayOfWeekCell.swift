import SwiftUI

struct DayOfWeekCell: View {

    // MARK: - Property

    let dayTitle: String
    let condition: String
    let windSpeed: Int
    let humidity: Int
    let temperature: Int

    // MARK: - View

    var body: some View {
        HStack {
            Text(dayTitle)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: condition)
                .resizable()
                .scaledToFit()
                .frame(width: min(20, 25), height: min(20, 25))
                .foregroundColor(.white)
                .padding(.horizontal)

            VStack {
                Text("Wind")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black.opacity(0.7))
                    .lineLimit(1)
                    .minimumScaleFactor(0.3)

                Text("\(windSpeed)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 1)
            }
            .padding([.vertical, .leading])

            VStack {
                Text("Humidity")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black.opacity(0.7))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)

                Text("\(humidity)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.top, 1)
            }
            .padding(.trailing)

            Text("\(temperature)°")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .padding(.trailing)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .background(.blue.opacity(0.7))
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    DayOfWeekCell(dayTitle: "Today", condition: "sun.max.fill", windSpeed: 5, humidity: 60, temperature: 32)
}
