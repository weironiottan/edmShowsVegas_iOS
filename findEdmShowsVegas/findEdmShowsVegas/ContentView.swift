//
//  ContentView.swift
//  findEdmShowsVegas
//
//  Created by Christian Gabrielsson on 2/1/25.
//

import SwiftUI

enum EventScope {
    case artist
    case venue
    case date
}



struct ContentView: View {
    // State property to hold our events
    // This is similar to state management in modern web frameworks
    // Think of it like a Python list that automatically triggers UI updates when modified
    @State private var events: [Event] = []
    @State private var searchText: String = ""
    @State private var scope: EventScope = .artist
    
    var body: some View {
        NavigationView {
            EventListView(searchText: $searchText, scope: $scope)
                .searchable(text: $searchText, prompt: "Search for Venues, Artists, or Dates")
                .searchScopes($scope){
                    Text("Artist").tag(EventScope.artist)
                    Text("Venue").tag(EventScope.venue)
                    Text("Date").tag(EventScope.date)
                }
                .navigationTitle("Events")
        }
    }
    
    // Helper function to format our date
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    ContentView()
}
