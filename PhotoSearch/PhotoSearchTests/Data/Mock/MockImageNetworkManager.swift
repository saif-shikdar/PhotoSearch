//
//  MockImageDownloader.swift
//  PhotoSearch
//
//  Created by Saif on 04/07/22.
//

import Foundation
@testable import PhotoSearch

class MockImageNetworkManager: Networkable {
    func get(apiRequest: ApiRequestType) async throws -> Data {
        if apiRequest.baseUrl == "valid" {
           return Data()
        }else {
            throw APIError.invalidData
        }
    }
    
}
