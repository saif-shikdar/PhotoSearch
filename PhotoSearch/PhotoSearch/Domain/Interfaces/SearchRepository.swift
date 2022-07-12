//
//  SearchRepository.swift
//  PhotoSearch
//
//  Created by Saif on 02/07/22.
//

import Foundation

protocol SearchRepository {
    func getImages(for keyWord: String) async throws -> [PhotoRecord]
}
