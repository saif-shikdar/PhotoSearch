//
//  ViewStates.swift
//  PhotoSearch
//
//  Created by Saif on 04/07/22.
//

import Foundation

enum SearchViewStates: Equatable {
    case showActivityIndicator
    case showPhotosView
    case showError(String)
    case none
}
