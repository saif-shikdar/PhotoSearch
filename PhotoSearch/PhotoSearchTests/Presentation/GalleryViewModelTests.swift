//
//  GalleryViewModelTests.swift
//  PhotoSearch
//
//  Created by Saif on 04/07/22.

import XCTest
@testable import PhotoSearch

class GalleryViewModelTests: XCTestCase {

    var galleryViewModel: GalleryViewModel!
    
    override func setUpWithError() throws {
       let galleryUseCase = MockGalleryUseCase()
       galleryViewModel = GalleryViewModel(imageRecodrs: getFakeImageRecords(), galleryUseCase: galleryUseCase)
    }

    override func tearDownWithError() throws {
        galleryViewModel = nil
    }
    
    func testDownloadImageWithValidURL() async {
       
        // GIVEN: gallery viewModel with valid photoRecords url
        
        // When
      let data =   await galleryViewModel.downLoadImage(for: 0)
    
        XCTAssertNotNil(data)
        
        XCTAssertEqual(galleryViewModel.numberOfRecords, 1)
    }
    
//    func testDownloadImageWithInValidURL()async {
//
//        // GIVEN: gallery viewModel with some invalid photoRecord url
//
//        // When
//        let data =   await galleryViewModel.downLoadImage(for: 1)
//
//        XCTAssertNil(data)
//
//    }
    
//    // Testing Image Cacher
//    func testReadImageFromCachingWhenSearchedMoreThanOnce()async {
//
//        // GIVEN: gallery viewModel with some photoReoCords
//
//        // When
//        let data =   await galleryViewModel.downLoadImage(for: 0)
//
//
//        let imageCacher = DefaultImageCacher.shared
//
//       let cachedData = imageCacher.getImage(url: "valid")
//
//        // Then
//        XCTAssertNotNil(data)
//        XCTAssertEqual(data, cachedData) // cached data will be equal to retervied data
//    }
//
//    // Checking counts of records
//    func testGetGetNumberOfRecords() {
//        let actualRecords = galleryViewModel.numberOfRecords
//        let expectedRecords = 2
//
//        XCTAssertEqual(expectedRecords, actualRecords)
//    }
//
//
    private func getFakeImageRecords()-> [PhotoRecord] {
        return [PhotoRecord(id: 1, previewURL:"valid")]
    }

}
