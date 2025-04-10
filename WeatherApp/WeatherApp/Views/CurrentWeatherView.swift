import SwiftUI

struct CurrentWeatherView: View {
    let data: CurrentWeather

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Location and Main Weather Info
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(data.name ?? "Current Location")
                        .font(.title2)
                        .bold()

                    Text("\(Int(data.main.temp))°C | \(data.weather.first?.main ?? "")")
                        .font(.title)
                        .bold()
                }

                Spacer()
                
                if let icon = data.weather.first?.icon {
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }

            Divider()

            // Additional Metrics
            VStack(alignment: .leading, spacing: 6) {
                Text("Feels like: \(Int(data.main.feels_like))°C")
                Text("Humidity: \(data.main.humidity)%")
                Text("Wind Speed: \(data.wind.speed, specifier: "%.1f") m/s")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
    }
}

