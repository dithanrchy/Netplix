//
//  SearchScreen.swift
//  Netplix
//
//  Created by Ditha Nurcahya Avianty on 02/03/23.
//

import UIKit

class SearchScreen: UIViewController {

    let searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 30, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.register(LargeMovieCell.self, forCellWithReuseIdentifier: LargeMovieCell.id)
        return collectionView
    }()

    private let viewModel = SearchViewModel()

    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(searchResultCollectionView)

        configureNavbar()

        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        searchBar.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }

    func configureNavbar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: nil)
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonClicked))
    }

    @objc func cancelButtonClicked() {
        navigationController?.popViewController(animated: false)
    }

}

extension SearchScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeMovieCell.id, for: indexPath) as? LargeMovieCell else { return UICollectionViewCell()}

        cell.configure(with: viewModel.movies[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailScreen()
        vc.movie = viewModel.movies[indexPath.row]
        self.present(vc, animated: true)
    }
}

extension SearchScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.keyword = searchText
        viewModel.search {
            self.searchResultCollectionView.reloadData()
        }.fire()
    }
}
