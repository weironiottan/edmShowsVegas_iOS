//
//  ContentView.swift
//  findEdmShowsVegas
//
//  Created by Christian Gabrielsson on 2/1/25.
//

import SwiftUI

struct ContentView: View {
    // State property to hold our events
    // This is similar to state management in modern web frameworks
    // Think of it like a Python list that automatically triggers UI updates when modified
    @State private var events: [Event] = []
    
    var body: some View {
        NavigationView {
            EventListView()
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
