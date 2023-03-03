//
//  LargeMovieViewCell.swift
//  Netplix
//
//  Created by Ditha Nurcahya Avianty on 02/03/23.
//

import SDWebImage
import UIKit

class LargeMovieCollectionView: UITableViewCell {
    static let id = "LargeMovieCollectionView"

    weak var delegate: CollectionViewTableViewCellDelegate?

    private var movies: [Movie] = [Movie]()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(LargeMovieCell.self, forCellWithReuseIdentifier: LargeMovieCell.id)
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
        contentView.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }

    public func configure(with movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension LargeMovieCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeMovieCell.id, for: indexPath) as? LargeMovieCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: movies[indexPath.row])

        cell.backgroundColor = .blue

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.CollectionViewTableViewCellDidTapCell(movie: movies[indexPath.row])
    }

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let position = scrollView.contentOffset.x
//        if position >  (collectionView.contentSize.width-100-scrollView.frame.size.width) {
//            self.movies.append(contentsOf: movies)
//            collectionView.reloadData()
//        }
//    }
}
