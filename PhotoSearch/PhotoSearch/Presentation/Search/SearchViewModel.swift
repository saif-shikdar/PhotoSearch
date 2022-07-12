//
//  SearchViewModel.swift
//  PhotoSearch
//
//  Created by Saif on 04/07/22.
//

import Foundation
import Combine

protocol SearchViewModelAction {
    func navigateToGallery(for keyword: String)
}

protocol SearchViewModelInput {
    func getGalleryImages(keyword: String?) async
}

protocol SearchViewModelOutput {
      var state: SearchViewStates {get}
}

final class SearchViewModel: SearchViewModelOutput {
    
    private var searchUseCase: SearchUseCase

    private var photoRecords: [PhotoRecord] = []
 
    private weak var coordinator: Coordinator?

    @Published  var state: SearchViewStates = .none
    
    private var cancellables:Set<AnyCancellable> = Set()
    
    init(searchUseCase: SearchUseCase,
         coordinator: Coordinator) {
        self.searchUseCase = searchUseCase
        self.coordinator = coordinator
    }
}

extension SearchViewModel: SearchViewModelAction {
    func navigateToGallery(for keyword: String) {
        coordinator?.navigatToGallery(keyword: keyword, imageRecords: photoRecords)
    }
}

extension SearchViewModel: SearchViewModelInput {
    func getGalleryImages(keyword: String?) async {
        guard let keyword = keyword, keyword.count > 0 else {
            self.state = .showError(APIError.invalidSearch.localizedDescription)
            return
        }
        state = .showActivityIndicator
        do {
            photoRecords = try await  searchUseCase.execute(for: keyword)
            
            state = .showPhotosView
        } catch {
            state = .showError((error as! APIError).localizedDescription)
        }
    }
}

