//
//  EventService.swift
//  findEdmShowsVegas
//
//  Created by Christian Gabrielsson on 2/2/25.
//

import Foundation

class EventService {
    // The base URL for our API
    private let baseURL = "https://edmeventsapigo-production.up.railway.app/find-edm/all-events"
    
    // Function to fetch events
    // This is similar to an async function in Python or Go
    func fetchEvents() async throws -> [Event] {
        // Create the URL for our request
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        // Create and start our network request
        // This is similar to using requests in Python or http.Client in Go
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Check if our response is valid HTTP
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        // Check if we got a successful status code (200-299)
        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        // Decode the JSON response into our Event models
        // This uses the Decodable protocol we set up earlier
        let decoder = JSONDecoder()
        let events = try decoder.decode([Event].self, from: data)
        
        return events
    }
}
