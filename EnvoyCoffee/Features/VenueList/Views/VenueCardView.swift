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
        HStack {
            if let imageURL = venue.photo?.thumbnailURL {
                AsyncImageView(imageViewModel: ImageViewModel(url: imageURL))
                    .frame(width: 128, height: 128)
                    .clipShape(.rect(cornerRadius: 25))
            } else {
                Color.gray
                    .frame(width: 128, height: 128)
                    .clipShape(.rect(cornerRadius: 25))
            }
            Text(venue.name)
                .font(.headline)
        }
    }
}
