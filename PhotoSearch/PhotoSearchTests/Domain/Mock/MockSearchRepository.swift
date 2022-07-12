//
//  MockSearchRepository.swift
//  PhotoSearchTests
//
//  Created by Saif on 04/07/22.
//

import Foundation
@testable import PhotoSearch

class MockSearchRepository: SearchRepository {
    func getImages(for keyWord: String) async throws -> [PhotoRecord] {
        if keyWord == "invalid" {
            throw APIError.invalidSearch
        }
        return [PhotoRecord(id:1, previewURL: "testUrl")]
    }
}
