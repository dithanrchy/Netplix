//
//  MovieDetailHeaderView.swift
//  Netplix
//
//  Created by Ditha Nurcahya Avianty on 02/03/23.
//

import UIKit
import WebKit
import SDWebImage

class MovieDetailHeaderView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading..."
        return label
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading..."
        return label
    }()

    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: MovieDetail) {
        DispatchQueue.main.async {
            self.titleLabel.text = model.title
            self.overviewLabel.text = model.titleOverview

            guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeTrailer.id.videoId)") else {return}
            self.webView.load(URLRequest(url: url))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

extension MovieDetailHeaderView {
    private func setupLayout() {
        addSubview(webView)
        webView.setTopAnchorConstraint(equalTo: safeAreaLayoutGuide.topAnchor)
        webView.setLeadingAnchorConstraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        webView.setTrailingAnchorConstraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        webView.setHeightAnchorConstraint(equalToConstant: 200)

        addSubview(titleLabel)
        titleLabel.setTopAnchorConstraint(equalTo: webView.bottomAnchor, constant: 15)
        titleLabel.setLeadingAnchorConstraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        titleLabel.setTrailingAnchorConstraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)

        addSubview(overviewLabel)
        overviewLabel.setTopAnchorConstraint(equalTo: titleLabel.bottomAnchor, constant: 15)
        overviewLabel.setLeadingAnchorConstraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        overviewLabel.setTrailingAnchorConstraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
    }
}
