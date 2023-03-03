//
//  ItemMovieCollectionViewCell.swift
//  Netplix
//
//  Created by Ditha Nurcahya Avianty on 02/03/23.
//

import SDWebImage
import UIKit

class ItemMovieCollectionViewCell: UICollectionViewCell {

    static let id = "ItemMovieCollectionViewCell"

    var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.setWidthAnchorConstraint(equalToConstant: 120)
        imageView.setHeightAnchorConstraint(equalToConstant: 200)
        imageView.backgroundColor = .blue
        return imageView
    }()

    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var descLabel: UILabel = {
        let label = UILabel()
        label.text =
        """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Arcu non sodales neque sodales ut etiam sit amet nisl.
        """
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 30
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        descLabel.text = model.overview
    }
}

extension ItemMovieCollectionViewCell {
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        setupStackView()
    }

    private func setupStackView() {
        let stackVertical = UIStackView(arrangedSubviews: [titleLabel, descLabel])
        stackVertical.axis = .vertical
        stackVertical.distribution = .equalSpacing
        stackVertical.alignment = .fill
        stackVertical.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackVertical)
        stackVertical.setTopAnchorConstraint(equalTo: topAnchor, constant: 20)
        stackVertical.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackVertical.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackVertical.setCenterYAnchorConstraint(equalTo: centerYAnchor)

        let stackHorizontal = UIStackView(arrangedSubviews: [posterImageView, stackVertical])
        stackHorizontal.axis = .horizontal
        stackHorizontal.distribution = .fill
        stackHorizontal.alignment = .top
        stackHorizontal.spacing = 10
        stackHorizontal.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackHorizontal)
        stackHorizontal.setTopAnchorConstraint(equalTo: topAnchor, constant: 20)
        stackHorizontal.setLeadingAnchorConstraint(equalTo: leadingAnchor, constant: 20)
        stackHorizontal.setTrailingAnchorConstraint(equalTo: trailingAnchor, constant: -20)
        stackHorizontal.setCenterYAnchorConstraint(equalTo: centerYAnchor)
    }
}
