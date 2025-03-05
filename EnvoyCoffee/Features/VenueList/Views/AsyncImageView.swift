//
//  AsyncImageView.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/5/25.
//

import Foundation

import SwiftUI

struct AsyncImageView: View {
    @State var imageViewModel: ImageViewModel
    var body: some View {
        Group {
            if let image = imageViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ZStack{
                    Color.gray
                        .aspectRatio(contentMode: .fit)
                    Image(systemName: "building.2")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                }
            }
        }
        .onAppear {
            Task {
                await imageViewModel.fetchImage()
            }
        }
        .onDisappear {
            Task {
                await imageViewModel.cancelImageFetch()
            }
        }
    }
}

#Preview {
    AsyncImageView(imageViewModel: ImageViewModel(url: URL(string: "https://placehold.co/200")!))
}
