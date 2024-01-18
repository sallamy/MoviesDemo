//
//  MoviesListViewControllerProviderProtocol.swift
//  Movies
//
//  Created by mohamed salah on 18/01/2024.
//

import Foundation
import UIKit

public protocol MoviesListViewControllerProviderProtocol {
    func getListViewController() -> UIViewController
    func getDetailsViewController(movieId: Int) -> UIViewController
}
