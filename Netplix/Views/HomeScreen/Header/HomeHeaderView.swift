//
//  HomeHeaderView.swift
//  Netplix
//
//  Created by Ditha Nurcahya Avianty on 02/03/23.
//

import UIKit

class HomeHeaderView: UIView {

    private var viewModel = HomeHeaderViewModel()
    static let id = "HomeHeaderView"
    weak var delegate: CollectionViewTableViewCellDelegate?

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.screenWidth - 40, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(ItemMovieCollectionViewCell.self, forCellWithReuseIdentifier: ItemMovieCollectionViewCell.id)
        return collectionView
    }()

    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = .systemGray
        pc.pageIndicatorTintColor = .secondarySystemFill
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addSubview(pageControl)
        pageControl.setCenterXAnchorConstraint(equalTo: centerXAnchor)
        pageControl.setBottomAnchorConstraint(equalTo: collectionView.bottomAnchor)

        collectionView.delegate = self
        collectionView.dataSource = self

        viewModel.popularMovies.bind { [weak self] _ in
            self?.collectionView.reloadData()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
}

extension HomeHeaderView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemMovieCollectionViewCell.id, for: indexPath) as? ItemMovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.popularMovies.value[indexPath.row])
        cell.backgroundColor = .secondarySystemFill
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = viewModel.popularMovies.value.count
        return viewModel.popularMovies.value.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.CollectionViewTableViewCellDidTapCell(movie: viewModel.popularMovies.value[indexPath.row])
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        self.pageControl.currentPage = Int(roundedIndex)
    }
}



