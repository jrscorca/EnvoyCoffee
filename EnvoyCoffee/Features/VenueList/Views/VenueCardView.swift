//
//  VenueCardView.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/5/25.
//

import SwiftUI

struct VenueCardView: View {
    @Environment(VenueViewModel.self) var viewModel
    let venue: Venue
    
    var body: some View {
        HStack(spacing: 16) {
            // Image section
            if let imageURL = venue.photo?.thumbnailURL {
                AsyncImageView(imageViewModel: ImageViewModel(url: imageURL))
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                ZStack {
                    Color.gray.opacity(0.7)
                    Image(systemName: "cup.and.saucer.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            // Details section
            VStack(alignment: .leading, spacing: 4) {
                Text(venue.name)
                    .tint(.black)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                if let address = venue.location.address ?? venue.location.formattedAddress {
                    Text(address)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "location.circle.fill")
                        .foregroundStyle(.tint)
                    
                    if let distance = venue.distanceInMiles {
                        Text("\(distance)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    } else {
                        Text("Distance unavailable")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    if let category = venue.categories?.first?.name {
                        Text(category)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.accentColor.opacity(0.1))
                            .foregroundColor(.accentColor)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.vertical, 4)
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}

#Preview {
    let mockVenue = Venue(
        id: "123",
        name: "Ritual Coffee Roasters",
        categories: [Category(id: 1, name: "Coffee Shop", icon: nil)],
        distance: 450,
        location: Location(
            address: "432 Octavia St",
            formattedAddress: "432 Octavia St, San Francisco, CA 94102",
            locality: "San Francisco",
            region: "CA",
            country: "US"
        ),
        photo: nil
    )
    
    return VenueCardView(venue: mockVenue)
        .environment(VenueViewModel())
        .padding()
}
