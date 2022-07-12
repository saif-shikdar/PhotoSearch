//
//  SearchUseCase.swift
//  PhotoSearch
//
//  Created by Saif on 02/07/22.
//

import Foundation

protocol SearchUseCase {
    func execute(for keyword: String) async throws -> [PhotoRecord]
}

final class DefaultSearchUseCase: SearchUseCase {
    private var searchRepository: SearchRepository

    init(searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
    }
    
    func execute(for keyword: String) async throws -> [PhotoRecord] {
        do {
            return try await searchRepository.getImages(for: keyword)
        }catch {
          throw error
        }
    }
}
