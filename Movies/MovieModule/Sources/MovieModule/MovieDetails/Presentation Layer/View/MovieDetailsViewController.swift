//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by mohamed salah on 18/01/2024.
//

import UIKit
import CoreUIComponent
import Combine

public class MovieDetailsViewController: UIViewController {

    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .darkGray
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor.black
        label.textAlignment = .justified
        return label
    }()
    
    lazy var overViewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = .justified
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .justified
        return label
    }()
    
    lazy var moviePosterImageView: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    let movieId: Int?
    
    public  init(with viewModel: MovieDetailsViewModel, movieId: Int) {
        self.viewModel = viewModel
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: MovieDetailsViewModel

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        bindUI()
        getDetials()
        observeLoader()
    }
    
    private func getDetials() {
        Task{await  self.viewModel.fetchMovieDetails(movieId: self.movieId ?? 0)}
       
    }
    
    private func buildUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(titleLabel)
        self.view.addSubview(moviePosterImageView)
        self.view.addSubview(dateLabel)
        self.view.addSubview(overViewLabel)
        self.view.addSubview(indicatorView)

        self.indicatorView.setConstraints( centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        moviePosterImageView.setConstraints(top: view.safeAreaLayoutGuide.topAnchor, centerX: view.centerXAnchor, paddingTop: 100,  width: 150, height: 150)
        titleLabel.setConstraints(top: moviePosterImageView.bottomAnchor,leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 50, paddingLeading: 10, paddingTrailing: 10)
        dateLabel.setConstraints(top: titleLabel.bottomAnchor,  leading: view.leadingAnchor,  paddingTop: 10, paddingLeading: 10)
        overViewLabel.setConstraints(top: dateLabel.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingLeading: 10, paddingTrailing: 10)
        
    }
    
    private func observeLoader() {
        viewModel.isLoading
            .receive(on: DispatchQueue.main).sink { state in
                self.indicatorView.isHidden = !state
            }.store(in: &cancellables)
    }
    
    private func bindUI() {
        self.viewModel.movieDetailsObserver.receive(on: DispatchQueue.main).sink { movieModel in
            self.titleLabel.text = movieModel.title
            self.dateLabel.text = movieModel.releaseDate
            self.overViewLabel.text = movieModel.overview
            if let photo = movieModel.poster , let url =  URL(string: "https://image.tmdb.org/t/p/original" + photo ){
                self.moviePosterImageView.sd_setImage(with: url) { [weak self] image, error, type, url in
                    guard let self = self else {  return}
                    if (error != nil) {
                        print("errrrror")
                    }
                }
            }
        }.store(in: &cancellables)
    }

}
