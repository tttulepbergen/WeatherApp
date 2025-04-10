import SwiftUI

struct ForecastView: View {
    let data: ForecastResponse

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("5-Day Forecast")
                .font(.headline)
                .padding(.bottom, 4)

            ForEach(data.list.prefix(5), id: \.dt) { item in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.dt_txt ?? "")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text(item.weather.first?.main ?? "")
                            .font(.body)
                    }

                    Spacer()

                    Text("\(Int(item.main.temp))°C")
                        .font(.title3)
                        .bold()
                }
                .padding(.vertical, 6)

                Divider()
            }
        }
    }
}
