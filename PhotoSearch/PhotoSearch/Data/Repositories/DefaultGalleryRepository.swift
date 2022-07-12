//
//  DefaultGalleryRepository.swift
//  PhotoSearch
//
//  Created by Saif on 02/07/22.
//

import Foundation

final class DefaultGalleryRepository {
    
    private let networkManager: Networkable
    private var cache = NSCache<NSString, NSData>()
    
    init(networkManager:Networkable) {
        self.networkManager = networkManager
        cache.countLimit = 100
    }
    
}

extension DefaultGalleryRepository: GalleryRepository {
    
    func getImages(for url: String) async throws -> Data {
        if let cachedData = getImage(url: url) {
            return cachedData
        }
        let  apiRequest = ApiRequest(baseUrl: url, path:"", params: [:])
        guard let data = try? await  self.networkManager.get(apiRequest: apiRequest) else {
            throw APIError.invalidData
        }
        saveImage(url: url, data: data)
        return data
    }
}

extension DefaultGalleryRepository: ImageCacher {
    func getImage(url: String) -> Data? {
        return cache.object(forKey: url as NSString) as Data?
    }
    
    func saveImage(url: String, data: Data) {
        cache.setObject(data as NSData, forKey: url as NSString)
    }
}
