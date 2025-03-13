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
                if viewModel.isLoading && viewModel.filteredVenues.isEmpty{
                    VenueLoadingView()
                } else if viewModel.filteredVenues.isEmpty {
                    EmptyVenueView(viewModel: viewModel)
                } else {
                    VenueListView(viewModel: viewModel)
                }
            }
            
            .onAppear {
                Task {
                    await viewModel.refresh()
                }
            }
            .navigationTitle("Coffee Shops")
            .alert("Error Loading Shops", isPresented: .constant(viewModel.error != nil)) {
                Button("OK") { viewModel.error = nil }
            } message: {
                Text(viewModel.error?.localizedDescription ?? "")
            }
            .searchable(text: $viewModel.searchText, prompt: "Search")
        }
    }
}

#Preview {
    VenueView(viewModel: VenueViewModel())
}


struct EmptyVenueView: View {
    var viewModel: VenueViewModel
    var body: some View {
        VStack {
            ContentUnavailableView("No Shops Available",
                                   systemImage: "building.2",
                                   description: Text("Check your internet connection and try again.")
            )
            Button("Retry") {
                Task {
                    await viewModel.refresh()
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
    @Bindable var viewModel: VenueViewModel
    var body: some View {
        
        HStack {
            Spacer()
            Picker("Categories", selection: $viewModel.selectedCategory) {
                Text("All Categories")
                    .tag(nil as Category?)
                ForEach(viewModel.categories, id: \.self) {
                    Text($0.name)
                        .tag($0 as Category?)
                }
            }
            .padding(.horizontal)
        }
        
        
        List {
            ForEach(viewModel.filteredVenues) { venue in
                Button {
                    viewModel.openMap(for: venue)
                } label: {
                    VenueCardView(venue: venue)
                        .onAppear {
                            checkIfLastItem(venue)
                        }
                }
                
            }
            
            if viewModel.isLoadingMore {
                loadingMoreIndicator
            }
        }
        .environment(viewModel)
        .refreshable {
            Task {
                await viewModel.refresh()
            }
        }
    }
    
    private var loadingMoreIndicator: some View {
        HStack {
            Spacer()
            ProgressView()
                .frame(height: 50)
            Spacer()
        }
    }
    
    private func checkIfLastItem(_ venue: Venue) {
        // If this is one of the last two items, start loading more
        let thresholdIndex = max(0, viewModel.venues.count - 2)
        if let currentIndex = viewModel.venues.firstIndex(where: { $0.id == venue.id }),
           currentIndex >= thresholdIndex && viewModel.hasMoreResults && !viewModel.isLoadingMore {
            Task {
                await viewModel.loadMoreVenues()
            }
        }
    }
}
