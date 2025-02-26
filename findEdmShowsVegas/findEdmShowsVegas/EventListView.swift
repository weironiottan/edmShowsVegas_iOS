//
//  EventListView.swift
//  findEdmShowsVegas
//
//  Created by Christian Gabrielsson on 2/2/25.
//

import SwiftUI



struct EventListView: View {
    // Create our service
    private let eventService = EventService()
    // Debugging purposes
    @State private var events: [Event] = Event.sampleEvents
    
    // State to hold our events and loading state
//    uncomment for an empty list for live events data
//    @State private var events: [Event] = []
    @State private var isLoading = false
    @State private var error: Error?
    @Binding var searchText: String
    @Binding var scope: EventScope
    var filteredEvents: [Event] {
        guard !searchText.isEmpty else {
            return events
        }
        
        return events.filter { event in
            let searchQuery = searchText.lowercased()
            switch scope {
                case .artist:
                return event.artistName.lowercased().contains(searchQuery)
            case .venue:
                return event.clubName.lowercased().contains(searchQuery)
            case .date:
                let dateFormatter = DateFormatter()
                let calendar = Calendar.current
                
                let weekday = calendar.component(.weekday, from: event.eventDate)
                let isWeekend = weekday == 1 || weekday == 6 || weekday == 7
                
                // Format 1: Full month name
                dateFormatter.dateFormat = "MMMM"
                let monthName = dateFormatter.string(from: event.eventDate).lowercased()
                
                // Format 2: Short month name
                dateFormatter.dateFormat = "MMM"
                let shortMonthName = dateFormatter.string(from: event.eventDate).lowercased()
                
                // Format 3: Day/Month
                dateFormatter.dateFormat = "M/d"
                let dayMonth = dateFormatter.string(from: event.eventDate).lowercased()
                
                // Format 4: Day name
                dateFormatter.dateFormat = "EEEE"
                let dayName = dateFormatter.string(from: event.eventDate).lowercased()
                
                // Check if searching for weekend
                if searchQuery == "weekend" {
                    return isWeekend
                }
                
                
                return monthName.contains(searchQuery) ||
                       shortMonthName.contains(searchQuery) ||
                       dayMonth.contains(searchQuery) ||
                       dayName.contains(searchQuery)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if isLoading {
                    ProgressView("Loading events...")
                } else if let error = error {
                    // Error view
                    VStack {
                        Text("Error loading events")
                        Text(error.localizedDescription)
                            .font(.caption)
                            .foregroundColor(.red)
                        Button("Try Again") {
                            Task {
                                await loadEvents()
                            }
                        }
                    }
                } else {
                    // Our existing list view
                    List(filteredEvents) { event in
                        EventRowView(event: event)
                    }
                    
                }
            }
            // Load events when the view appears
            .task {
//                uncomment the line below to load all events from the api
//                                await loadEvents()
            }
        }
    }
    
    
    // Function to load our events
    func loadEvents() async {
        isLoading = true
        error = nil
        
        do {
            // Fetch and update our events
            events = try await eventService.fetchEvents()
        } catch {
            // Handle any errors
            self.error = error
        }
        
        isLoading = false
    }
}

// Create a separate view for our event row
// This is similar to creating a reusable component in web development
struct EventRowView: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(event.artistName)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(event.clubName)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.blue)
                Text(formatDate(event.eventDate))
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 4)
    }
    
    // Helper function to format our date
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// Preview provider for SwiftUI
#Preview {
    EventListView(searchText: .constant(""), scope: .constant(.artist))
}
