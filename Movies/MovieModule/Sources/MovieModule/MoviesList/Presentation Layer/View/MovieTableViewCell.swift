//
//  PhotoTableViewCell.swift
//  VOISTask
//
//  Created by concarsadmin on 12/22/21.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {
    static let idenetifier = "MovieTableViewCell"

    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
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
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .justified
        return label
    }()
    
    lazy var moviePosterImageView: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    func buildUI(){
        self.backgroundColor  = UIColor.white
        self.selectionStyle = .none
        let stack = UIStackView()
        stack.spacing = 5
        stack.distribution = .fill
        stack.axis = .vertical
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(dateLabel)
        self.addSubview(moviePosterImageView)
        moviePosterImageView.setConstraints(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, paddingTop: 8, paddingBottom: 8, paddingLeading: 8, width: 100, height: 200)
        moviePosterImageView.addSubview(indicatorView)
        indicatorView.setConstraints( centerX: moviePosterImageView.centerXAnchor, centerY: moviePosterImageView.centerYAnchor)
        self.addSubview(stack)
        stack.setConstraints(top: self.topAnchor, leading: self.moviePosterImageView.trailingAnchor, trailing: self.trailingAnchor,paddingTop: 10,paddingLeading: 10,paddingTrailing: 10)
    }
    
    func setupData(model: Movie){
        titleLabel.text = model.title
        dateLabel.text = model.releaseDate
        if let photo = model.poster , let url =  URL(string: "https://image.tmdb.org/t/p/original" + photo ){
            self.indicatorView.startAnimating()
            self.indicatorView.isHidden = false
            self.moviePosterImageView.sd_setImage(with: url) { [weak self] image, error, type, url in
                guard let self = self else {  return}
                if (error != nil) {
                    print("errrrror")
                }
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
            }
        }
    }
}
