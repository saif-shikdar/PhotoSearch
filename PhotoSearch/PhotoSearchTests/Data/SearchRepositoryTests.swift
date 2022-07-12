//
//  SearchRepositoryTests.swift
//  PhotoSearchTests
//
//  Created by Saif on 04/07/22.
//

import XCTest
@testable import PhotoSearch

class SearchRepositoryTests: XCTestCase {

    var searchRespository: SearchRepository!
    
    override func setUp() {
        
        let networkManager = MockNetworkManager()
        searchRespository = DefaultSearchRepository(networkManager: networkManager)
    }
    
    // Valid Response
    func testGetImages_ForValidKeyword() async{
    
       let photoRecords =  try? await searchRespository.getImages(for:"valid_keyword_search_response")
        
        XCTAssertEqual(photoRecords?.count, 20)

        XCTAssertEqual(photoRecords!.first!.previewURL, "https://cdn.pixabay.com/photo/2017/06/20/22/14/man-2425121_150.jpg")
        
    }
    
    // Cached Response
    func testGetImages_fromCachedResponse() async{
    
        // GIVEN
       let _ =  try? await searchRespository.getImages(for:"valid_keyword_search_response")
        
        // When
        
        let photoRecords =  try? await searchRespository.getImages(for:"valid_keyword_search_response")
        
        XCTAssertEqual(photoRecords?.count, 20)

        XCTAssertEqual(photoRecords!.first!.previewURL, "https://cdn.pixabay.com/photo/2017/06/20/22/14/man-2425121_150.jpg")
        
    }
    
    
    // Empty Response
    func testGetImages_ForEmptyResonse() async{
        
        do  {
            _ =  try await searchRespository.getImages(for:"empty_search_response")
            
        }catch {
            XCTAssertEqual(error as! APIError, APIError.emptyRecords)
        }
        
    }
    
    // InValid Response
    func testGetImages_ForInvalidResonse() async{
        
        do  {
            _ =  try await searchRespository.getImages(for:"invalid_search_response")
            
        }catch {
            XCTAssertEqual(error as! APIError, APIError.jsonParsingFailed)
        }
        
    }
    
    
}
