//
//  GalleryRepository.swift
//  PhotoSearch
//
//  Created by Saif on 02/07/22.
//

import Foundation

final class DefaultSearchRepository {
    
    private var cachedResult: [String : [PhotoRecord]] = [:]
    
    private let networkManager: Networkable
    
    init(networkManager:Networkable) {
        self.networkManager = networkManager
    }
        
    private func getCachedResponse(for keyword:String)-> [PhotoRecord]? {
        return cachedResult[keyword]
    }
    
    private func getDecodedResopnse(from data: Data)-> PhotosResponseDTO? {
        guard let photosResponseDTO = try? JSONDecoder().decode(PhotosResponseDTO.self, from: data) else {
            return nil
        }
        return photosResponseDTO
    }
}

extension DefaultSearchRepository: SearchRepository {
    
    func getImages(for keyWord: String) async throws -> [PhotoRecord] {
        
        if let cachedRecords = getCachedResponse(for: keyWord) {
            return cachedRecords
        }
        
        let  apiRequest = ApiRequest(baseUrl: EndPoint.baseUrl, path:"", params: ["q": keyWord])
        
        guard let data = try? await  self.networkManager.get(apiRequest: apiRequest) else {
            throw APIError.invalidData
        }
        
        guard let photosResponseDTO = getDecodedResopnse(from: data) else {
            throw APIError.jsonParsingFailed
        }
        
        let photoRecords = photosResponseDTO.toDomain()
        
        if photoRecords.isEmpty {
            throw APIError.emptyRecords
        }
        
        self.cachedResult[keyWord] = photoRecords
        
        return photoRecords
    }
}
