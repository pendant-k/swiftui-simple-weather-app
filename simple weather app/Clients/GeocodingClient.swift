import Foundation

enum NetworkError: Error {
    case invalidResponse
}

struct GeocodingClient {
    func coordinateByCityName(_ city: String) async throws -> Location? {
        // TODO: check api call in Swift using URLSession (before using Alamofire)
        // what is Data, and what is response
        let (data, response) = try await URLSession.shared.data(from: APIEndpoint.endpointURL(for: .coordinatesByLocationName(city)))

        // TODO: check what guard keyword does
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidResponse
        }

        // TODO: What is this?
        // type object using self suffix
        // [Location]: 타입을 나타냄.
        // [Location].self: 타입을 값으로 전달하는 것.
        let locations = try JSONDecoder().decode([Location].self, from: data)

        return locations.first
    }
}
