//
//  VenueView.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import SwiftUI

struct VenueView: View {
    @State var viewModel: VenueViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading && viewModel.venues.isEmpty{
                    VenueLoadingView()
                } else if viewModel.venues.isEmpty {
                    EmptyVenueView()
                } else {
                    VenueListView()
                }
            }
            .environment(viewModel)
            .onAppear {
                Task {
                    await viewModel.fetchVenues(limit: 10)
                }
            }
            .navigationTitle("Coffee Shops")
            .alert("Error Loading Shops", isPresented: .constant(viewModel.error != nil)) {
                Button("OK") { viewModel.error = nil }
            } message: {
                Text(viewModel.error?.localizedDescription ?? "")
            }
        }
    }
}

#Preview {
    VenueView(viewModel: VenueViewModel())
}


struct EmptyVenueView: View {
    @Environment(VenueViewModel.self) private var viewModel
    var body: some View {
        VStack {
            ContentUnavailableView("No Shops Available",
                                   systemImage: "building.2",
                                   description: Text("Check your internet connection and try again.")
            )
            Button("Retry") {
                Task {
                    await viewModel.fetchVenues(limit: 10)
                }
            }
            .offset(y: -50)
        }
    }
}

struct VenueLoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
            Text("Loading Coffee Shops...")
        }
    }
}

struct VenueListView: View {
    @Environment(VenueViewModel.self) private var viewModel
    var body: some View {
        List {
            ForEach(viewModel.venues) { venue in
                VenueCardView(venue: venue)
            }
        }
        .environment(viewModel)
        .refreshable {
            Task {
                await viewModel.fetchVenues(limit: 10)
            }
        }
    }
}
