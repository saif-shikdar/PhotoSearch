//
//  SearchViewModelTests.swift
//  PhotoSearch
//
//  Created by Saif on 04/07/22.
//

import XCTest
@testable import PhotoSearch

class SearchViewModelTests: XCTestCase {

    var viewModel:SearchViewModel!
    
    override func setUpWithError() throws {
       
        let coordinator = MainCoordinator(navBarController: UINavigationController())
        
        let searchUseCase = MokcSearchUseCase()
        
        viewModel = SearchViewModel(searchUseCase:searchUseCase , coordinator: coordinator)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    // Valid keyword search
    func testSearch_MultipleTimesWithSameKeyWord() async {
    
        //GIVEN : Valid Search
        let keyword = "valid_keyword_search_response"
        
        // When
        await viewModel.getGalleryImages(keyword: keyword)

        await viewModel.getGalleryImages(keyword: keyword)

        // Then
        XCTAssertEqual(viewModel.state, .showPhotosView)

    }
    
    // InValid keyword search
    func testSearch_InvalidKeyWord() async {
    
        //GIVEN : invalid Search keyword
        let keyword = "empty_search_response"
        
        // When
        await viewModel.getGalleryImages(keyword: keyword)
        
        // Then
        XCTAssertEqual(viewModel.state, .showError(APIError.emptyRecords.localizedDescription))

    }

    // When response is not as per expected Models
    func testSearch_WhenResponseIsNotValid() async {

        //GIVEN : invalid search response with any valid keyword
        let keyword = "invalid_search_response"
        
        // When
        await viewModel.getGalleryImages(keyword: keyword)
        
        // Then
        XCTAssertEqual(viewModel.state, .showError(APIError.jsonParsingFailed.localizedDescription))

    }
    // Empty Keyword Testing
    func testSearch_WhenKeyWordIsEmpty() async {

        //GIVEN : Empty Keyword
        let keyword = ""
        
        // When
        await viewModel.getGalleryImages(keyword: keyword)
        
        // Then
        XCTAssertEqual(viewModel.state, .showError(APIError.invalidSearch.localizedDescription))
    }
    
    // Nil Keyword Testing
    func testSearch_WhenKeyWordIsNil() async {

        //GIVEN : Nil Keyword
        
        // When
        await viewModel.getGalleryImages(keyword: nil)
        
        // Then
        XCTAssertEqual(viewModel.state, .showError(APIError.invalidSearch.localizedDescription))
    }
    
    // Valid keyword search
    func testSearch_WhenKeyWordIsValid() async {
        
        //GIVEN : Valid Search
        let keyword = "valid_keyword_search_response"
        
        // When
        await viewModel.getGalleryImages(keyword: keyword)

        // Then
        XCTAssertEqual(viewModel.state, .showPhotosView)
        
    }
}
