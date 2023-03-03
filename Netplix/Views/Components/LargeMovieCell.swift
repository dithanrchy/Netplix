//
//  LargeMovieCell.swift
//  Netplix
//
//  Created by Ditha Nurcahya Avianty on 02/03/23.
//

import SDWebImage
import UIKit

class LargeMovieCell: UICollectionViewCell {

    static let id = "LargeMovieCell"

    var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.setWidthAnchorConstraint(equalToConstant: 150)
        imageView.setHeightAnchorConstraint(equalToConstant: 100)
        return imageView
    }()

    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = bounds
    }

    public func configure(with model: Movie) {
        guard let url = URL(string: "\(Constants.imageURL)\(model.posterPath ?? "")") else {return}

        posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        posterImageView.sd_setImage(
            with: url,
            placeholderImage: UIImage(systemName: "system.photo"),
            options: .progressiveLoad,
            completed: nil
        )

        titleLabel.text = model.title
    }
}

extension LargeMovieCell {
    func setupView() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        titleLabel.setTopAnchorConstraint(equalTo: posterImageView.topAnchor, constant: 25)
        titleLabel.setLeadingAnchorConstraint(equalTo: posterImageView.leadingAnchor, constant: 20)
        titleLabel.setTrailingAnchorConstraint(equalTo: posterImageView.trailingAnchor, constant: -20)
    }
}
