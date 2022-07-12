//
//  SearchUseCaseTests.swift
//  PhotoSearchTests
//
//  Created by Saif on 04/07/22.
//

import XCTest
@testable import PhotoSearch

class SearchUseCaseTests: XCTestCase {

    var searchUseCase: SearchUseCase!
    
    override func setUp() {
        searchUseCase = DefaultSearchUseCase(searchRepository: MockSearchRepository())

    }
    
    // Valid Search
    func testValidSearch() async {
        
        let photoRecords =   try? await searchUseCase.execute(for: "test")
        
        XCTAssertEqual(photoRecords?.count, 1)
        XCTAssertEqual(photoRecords?.first?.id, 1)
        XCTAssertEqual(photoRecords?.first?.previewURL, "testUrl")
    }
    
    // Invalid Search
    func testInValidSearch() async {
        
        let photoRecords =   try? await searchUseCase.execute(for: "invalid")
        
         XCTAssertNil(photoRecords)
    }
}
