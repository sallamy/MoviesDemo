//
//  MoviesListViewController.swift
//  Movies
//
//  Created by mohamed salah on 16/01/2024.
//

import UIKit

class MoviesListViewController: UIViewController {

    init(with viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private let viewModel: MoviesListViewModel
}
