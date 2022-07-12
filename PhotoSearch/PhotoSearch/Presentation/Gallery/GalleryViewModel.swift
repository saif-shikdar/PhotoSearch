//
//  PhotoViewModel.swift
//  PhotoSearch
//
//  Created by Saif on 04/07/22.
//

import Foundation

protocol GalleryViewModelInput {
    func downLoadImage(for index:Int)async -> Data?
}

protocol GalleryViewModelOutput {
    var numberOfRecords:Int {get}
    func getKeyWord()-> String
}

final class GalleryViewModel {

    private let imageRecords:[PhotoRecord]
    private let galleryUseCase: GalleryUseCase
    private let searchedKeyword: String
    init(keyword:String, imageRecodrs:[PhotoRecord], galleryUseCase: GalleryUseCase) {
        self.searchedKeyword = keyword
        self.imageRecords = imageRecodrs
        self.galleryUseCase = galleryUseCase
    }
}

extension GalleryViewModel: GalleryViewModelOutput {
    var numberOfRecords:Int {
        return imageRecords.count
    }
    
    func getKeyWord()-> String {
        return searchedKeyword
    }

}

extension GalleryViewModel: GalleryViewModelInput {
    func downLoadImage(for index:Int)async -> Data? {
        let url = imageRecords[index].previewURL
      
        return  try? await galleryUseCase.execute(for: url)
    }
}
