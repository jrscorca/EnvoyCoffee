# Envoy Coffee Shop Finder

The app displays coffee shops near Envoy's SF office and features an infinite scrolling list with seamless loading of additional results.

## Features

- **Browse Nearby Coffee Shops**: Displays coffee shops near Envoy's SF office
- **Infinite Scrolling**: Efficiently loads additional results as users scroll
- **Image Caching**: Smart image loading with disk caching to reduce network requests as well as task deduplication.
- **Location Integration**: Maps integration for directions to coffee shops
- **Modern UI**: Clean, card-based design using SwiftUI

## Architecture

The application follows the MVVM (Model-View-ViewModel) architecture pattern with a clean separation of concerns and a layered approach:

### Core Layers

- **Networking Layer**: Handles API communication with FourSquare
- **Repository Layer**: Manages data access and persistence
- **ViewModel Layer**: Manages UI state and business logic
- **View Layer**: Presents UI to users

### Key Components

#### Networking
- `HTTPClient`: Protocol for making network requests
- `URLSessionHTTPClient`: Concrete implementation of the HTTP client
- `VenueAPIService`: Handles FourSquare API communication
- `ImageService`: Manages image downloading with deduplication

#### Data Models
- `Venue`: Represents a coffee shop with relevant information
- `VenueSearchCriteria`: Encapsulates search parameters
- `Photo`: Handles image information and URLs

#### Repositories
- `VenueRepository`: Manages venue data and pagination
- `DiskImageRepository`: Handles image caching and retrieval

#### ViewModels
- `VenueViewModel`: Manages venue list state and operations
- `ImageViewModel`: Handles image loading and state

#### Views
- `VenueView`: Main view for displaying coffee shops
- `VenueCardView`: Card component for individual venues
- `AsyncImageView`: Handles asynchronous image loading

### Requirements
- iOS 18.2+
- Xcode 16.2+
- Swift 6.0 (supporting Swift 6 enforces safe concurrency policies)
- FourSquare API Key

## Testing

The application includes some unit tests for key components:
- Network client tests
- Repository tests
- ViewModel tests
