import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack(spacing: 10) {
                        // Current Weather
                        SectionView(state: viewModel.currentWeatherState) {
                            ZStack(alignment: .bottomTrailing) {
                                CurrentWeatherView(data: viewModel.currentWeather!)
                                    .padding()
                                    .background(Color.white.opacity(0.7), in: RoundedRectangle(cornerRadius: 20))
                                    .shadow(radius: 10)
                                    .padding(.top)
                                    .frame(maxWidth: .infinity)
                                
                                // Refresh button in the bottom-right corner of CurrentWeatherView
                                Button(action: {
                                    viewModel.refresh()
                                }) {
                                    Image(systemName: "arrow.clockwise.circle.fill") // Updated icon
                                        .font(.title)
                                        .padding(10)
                                        .background(Circle().fill(Color.white).shadow(radius: 5))
                                }
                                .padding([.bottom, .trailing], 10) // Add some padding
                            }
                        }

                        // Forecast
                        SectionView(state: viewModel.forecastState) {
                            ForecastView(data: viewModel.forecast!)
                                .padding()
                                .background(Color.white.opacity(0.7), in: RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 10)
                                .padding(.top)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding([.bottom, .horizontal])
                }
                .navigationTitle("Weather")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    viewModel.fetchWeatherData()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
