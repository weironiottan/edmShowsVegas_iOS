//
//  Event+SampleData.swift
//  findEdmShowsVegas
//
//  Created by Christian Gabrielsson on 2/2/25.
//

import Foundation

extension Event {
    
    // Static property to hold sample data
    // This is similar to how you might create class methods in Python
    static var sampleEvents: [Event] = [
        Event(
            id: "4ec49bd0-1889-46fa-893b-f05eed73be85",
            clubName: "Zouk Nightclub",
            artistName: "Cash Cash Lunar New Year",
            eventDate: ISO8601DateFormatter().date(from: "2025-02-01T00:00:00Z")!,
            ticketUrl: "https://zoukgrouplv.com/event/EVE50511500020250201/cash-cash-lunar-new-year/"
        ),
        Event(
            id: "ae7ff18a-b780-4288-88bd-6d8651b4a636",
            clubName: "XS Nightclub",
            artistName: "Diplo",
            eventDate: ISO8601DateFormatter().date(from: "2025-02-01T00:00:00Z")!,
            ticketUrl: "https://www.wynnsocial.com/event/EVE111500020250201/diplo/"
        ),
        Event(
            id: "87e59d15-15ac-431c-8cbe-7e5ca949732e",
            clubName: "Marquee Dayclub",
            artistName: "Cedric Gervais",
            eventDate: ISO8601DateFormatter().date(from: "2025-02-01T00:00:00Z")!,
            ticketUrl: "https://taogroup.com/event/2-1-2025-marquee-dome-saturday-marquee-dayclub/"
        )
    ]
}
