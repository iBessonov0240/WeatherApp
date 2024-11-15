import SwiftUI

struct Main: View {

    // MARK: - Properties

    @StateObject private var viewModel = MainViewModel()

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CityWeather.timestamp, ascending: true)],
        animation: .default
    )
    private var savedCities: FetchedResults<CityWeather>

    @Environment(\.managedObjectContext) private var viewContext

    // MARK: - View

    var body: some View {
        NavigationStack {
            ZStack {
                Image("cloud")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()

                VStack {
                    Button {
                        viewModel.weatherCityDescription()
                    } label: {
                        Image(systemName: "list.bullet")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                            .padding(.top, 20)
                    }

                    Text(viewModel.cityName.isEmpty ? "City" : viewModel.cityName)
                        .font(.system(size: 40, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.top, 25)

                    Text("\(viewModel.temperature)°C")
                        .font(.system(size: 45, weight: .light))
                        .foregroundColor(.white)

                    TextField("", text: $viewModel.text)
                        .padding(.vertical, 10)
                        .padding(.leading, 40)
                        .background(.gray.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .overlay {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 10)

                                if viewModel.text.isEmpty {
                                    Text("Search for a city")
                                        .foregroundColor(.white.opacity(0.3))
                                        .padding(.leading, 5)
                                }

                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 25)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()

                                Button {
                                    UIApplication.shared.sendAction(
                                        #selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil
                                    )
                                } label: {
                                    Text("Done")
                                        .foregroundStyle(Color.blue)
                                }
                            }
                        }

                    Button {
                        Task {
                            await viewModel.fetchWeather()
                        }
                    } label: {
                        Image(systemName: "goforward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.cyan)
                            .frame(width: 34, height: 34)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(lineWidth: 5)
                                    .foregroundColor(.purple.opacity(0.8))
                            }
                    }
                    .padding(.top, 50)

                    List {
                        ForEach(savedCities) { city in
                            HStack {
                                Text(city.name ?? "Unknown City")
                                    .font(.headline)

                                Spacer()

                                Text("\(city.temperature)°C")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.selectCity(city: city)
                            }
                        }
                        .onDelete { offsets in
                            viewModel.deleteCity(offsets: offsets, cities: savedCities, context: viewContext)
                        }
                    }
                    .listStyle(.plain)
                    .frame(maxHeight: 300)
                    .toolbar {
                        ToolbarItem {
                            Button {
                                Task {
                                    await viewModel.saveWeather(context: viewContext)
                                }
                            } label: {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: UIScreen.main.bounds.width)
            }
            .navigationDestination(
                isPresented: $viewModel.isShowWeatherDescription
            ) {
                WeatherDescription(forecast: viewModel.fiveDayForecast)
            }
        }
    }
}

#Preview {
    Main()
}
