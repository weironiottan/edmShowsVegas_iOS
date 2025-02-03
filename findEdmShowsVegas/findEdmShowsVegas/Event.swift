//
//  File.swift
//  findEdmShowsVegas
//
//  Created by Christian Gabrielsson on 2/2/25.
//

import Foundation


struct Event: Identifiable, Decodable {
    let id: String
    let clubName: String
    let artistName: String
    let eventDate: Date
    let ticketUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case clubName = "ClubName"
        case artistName = "ArtistName"
        case eventDate = "EventDate"
        case ticketUrl = "TicketUrl"
    }
    
    // Add a regular initializer for creating instances directly
    // This is separate from our Decodable initializer
    init(id: String, clubName: String, artistName: String, eventDate: Date, ticketUrl: String) {
        self.id = id
        self.clubName = clubName
        self.artistName = artistName
        self.eventDate = eventDate
        self.ticketUrl = ticketUrl
    }
    
    // Custom initializer from decoder
    // This is similar to UnmarshalJSON in Go or from_json in Python
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode simple string properties
        id = try container.decode(String.self, forKey: .id)
        clubName = try container.decode(String.self, forKey: .clubName)
        artistName = try container.decode(String.self, forKey: .artistName)
        ticketUrl = try container.decode(String.self, forKey: .ticketUrl)
        
        // Handle date decoding
        let dateString = try container.decode(String.self, forKey: .eventDate)
        let dateFormatter = ISO8601DateFormatter()
        
        // Try to convert the string to a Date
        if let date = dateFormatter.date(from: dateString) {
            eventDate = date
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .eventDate,
                in: container,
                debugDescription: "Date string does not match expected format"
            )
        }
    }
}

// Now let's create a function to test our model with a JSON string
func testEventDecoding() {
    // This is our sample JSON string
    let jsonString = """
    {
        "Id": "4ec49bd0-1889-46fa-893b-f05eed73be85",
        "ClubName": "zouk nightclub",
        "ArtistName": "cash cash lunar new year",
        "EventDate": "2025-02-01T00:00:00Z",
        "TicketUrl": "https://zoukgrouplv.com/event/EVE50511500020250201/cash-cash-lunar-new-year/"
    }
    """
    
    // Convert string to Data
    if let jsonData = jsonString.data(using: .utf8) {
        do {
            // Try to decode the JSON into our Event model
            let decodedEvent = try JSONDecoder().decode(Event.self, from: jsonData)
            
            // Print the decoded event details
            print("Event decoded successfully:")
            print("ID: \(decodedEvent.id)")
            print("Club: \(decodedEvent.clubName)")
            print("Artist: \(decodedEvent.artistName)")
            print("Date: \(decodedEvent.eventDate)")
            print("Ticket URL: \(decodedEvent.ticketUrl)")
        } catch {
            print("Failed to decode event: \(error)")
        }
    }
}

