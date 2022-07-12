//
//  UrlRequestTest.swift
//  PhotoSearch
//
//  Created by Saif on 04/07/22.
//

import XCTest
@testable import PhotoSearch

class UrlRequestTest: XCTestCase {
    
    // rigth URL
    func testRequest_whenUrlIsCorrect() {
        
        // GIVEN
        let apiRequest = ApiRequest(baseUrl: EndPoint.baseUrl, path:"", params:["q":"test"])
        // When
        let requeast = URLRequest.getURLRequest(for: apiRequest)
        // Then
        
        XCTAssertEqual(requeast!.url!.absoluteString, "https://pixabay.com/api/?q=test&key=13197033-03eec42c293d2323112b4cca6&image_type=photo")
    }
    
    // wrong URL
    func testRequest_whenUrlIsInCorrect() {
        
        // GIVEN
        let apiRequest = ApiRequest(baseUrl: "", path:"", params:["q":"test"])
        // When
        let requeast = URLRequest.getURLRequest(for: apiRequest)
        // Then
        
        XCTAssertNil(requeast?.url)
    }
}
