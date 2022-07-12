//
//  MockGalleryRepository.swift
//  PhotoSearchTests
//
//  Created by Saif on 04/07/22.
//

import Foundation
@testable import PhotoSearch


class MockGalleryRepository: GalleryRepository{
    func getImages(for url: String) async throws -> Data {
        if url == "InvalidUrl" {
            throw APIError.invalidData
        }
        return Data()
    }
}
