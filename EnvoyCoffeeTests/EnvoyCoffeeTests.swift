//
//  EnvoyCoffeeTests.swift
//  EnvoyCoffeeTests
//
//  Created by Joshua Scorca on 3/4/25.
//

import XCTest
@testable import EnvoyCoffee

final class EnvoyCoffeeTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchVenues_success() async throws {
        // Given
        var mockHTTPClient = MockHTTPClient()
        mockHTTPClient.mockData = MockJSONResponse.venueSearchSuccess.data(using: .utf8)
        let mockHttpResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        mockHTTPClient.mockResponse = mockHttpResponse
        
        let sut = FourSquareService(httpClient: mockHTTPClient)

        let mockVenueSearchCriteria = VenueSearchCriteria()
        
        // When
        let venues = try await sut.searchVenues(searchCriteria: mockVenueSearchCriteria)
        
        // Then
        XCTAssert(venues.count == 2)
    }
    
    func testFetchImageData_Success() async throws {
        // Given
        var mockHTTPClient = MockHTTPClient()
        let testURL = URL(string: "https://mock.com")!
        let expectedData = "test image data".data(using: .utf8)!
        let mockResponse = HTTPURLResponse(
            url: testURL,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        mockHTTPClient.mockData = expectedData
        mockHTTPClient.mockResponse = mockResponse
        let sut = ImageService(client: mockHTTPClient)
        
        // When
        let receivedData = try await sut.fetchImageData(url: testURL)
        
        // Then
        XCTAssertEqual(receivedData, expectedData)
    }


}
