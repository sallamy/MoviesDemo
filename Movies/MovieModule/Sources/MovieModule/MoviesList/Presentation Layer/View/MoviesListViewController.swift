//
//  MoviesListViewController.swift
//  Movies
//
//  Created by mohamed salah on 16/01/2024.
//

import UIKit
import CoreUIComponent
import Combine

public class MoviesListViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .darkGray
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: MoviesListViewModel
    
    
    public  init(with viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        buidUI()
        registerTableView()
        observeLoader()
        bindTableView()
        getListData()
    }

    private func getListData() {
            Task {await viewModel.fetchMovies()}
    }
    
    private func buidUI() {
        self.tableView.delegate = self
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.indicatorView)
        self.tableView.setConstraints(top: self.view.safeAreaLayoutGuide.topAnchor, bottom: self.view.bottomAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, paddingTop: 16,paddingLeading: 16, paddingTrailing: 16)
        self.indicatorView.setConstraints( centerX: self.view.centerXAnchor, centerY: self.view.centerYAnchor)
        
    }
    
    func observeLoader() {
        viewModel.isLoading
            .receive(on: DispatchQueue.main).sink { state in
                self.indicatorView.isHidden = !state
            }.store(in: &cancellables)
    }
    
    func registerTableView() {
        self.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.idenetifier)
    }
    
    func bindTableView() {
        viewModel.moviesListObserver
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: tableView
                .items {  (tableView, indexPath, model) in
                    let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.idenetifier, for: indexPath) as? MovieTableViewCell
                    cell?.setupData(model: model)
                    return cell ?? UITableViewCell()
                }).store(in: &cancellables)
    }
}


extension MoviesListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let movieId = self.viewModel.moviesListObserver.value[indexPath.row].id {
            self.navigationController?.pushViewController(ContainerManager.shared.createMoviesDetailsViewController(movieId: movieId ), animated: true)
        }
     
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
