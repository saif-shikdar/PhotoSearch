//
//  MockGalleryUseCase.swift
//  PhotoSearchTests
//
//  Created by Saif on 04/07/22.
//

import Foundation
@testable import PhotoSearch


class MockGalleryUseCase: GalleryUseCase {
    func execute(for url: String) async throws -> Data {
        
        if url == "InvalidUrl" {
            throw APIError.invalidData
        }
        return Data()
    }
}
