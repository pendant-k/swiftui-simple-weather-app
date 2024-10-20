import SwiftUI

struct ContentView: View {
    @State private var city: String = ""
    @State private var weather: Weather?
    @State private var isFetching: Bool = false

    let geocodingClient = GeocodingClient()
    let weatherClient = WeatherClient()

    private func fetchWeather() async {
        do {
            guard let location = try await geocodingClient.coordinateByCityName(city) else { return }
            weather = try await weatherClient.fetchWeather(location: location)

        } catch {
            print(error)
        }
    }

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)

            TextField("Enter City", text: $city)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    isFetching = true
                }.task(id: isFetching) {
                    if isFetching {
                        await fetchWeather()
                        // reset states
                        isFetching = false
                        city = ""
                    }
                }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
