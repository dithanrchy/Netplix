//
//  MovieDetailScreen.swift
//  Netplix
//
//  Created by Ditha Nurcahya Avianty on 02/03/23.
//

import UIKit

class MovieDetailScreen: UIViewController {

    var movie: Movie?
    private let viewModel = MovieDetailViewModel()

    private let movieInfoTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.register(SmallMovieCollectionView.self, forCellReuseIdentifier: SmallMovieCollectionView.id)
        return table
    }()

    private var headerView: MovieDetailHeaderView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        movieInfoTable.delegate = self
        movieInfoTable.dataSource = self

        headerView = MovieDetailHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        movieInfoTable.tableHeaderView = headerView

        guard let movie = movie else { return }
        viewModel.getVideoElement(movieTitle: movie.title) { videoTrailer in
            let viewModel = MovieDetail(id: movie.id, title: movie.title, youtubeTrailer: videoTrailer, titleOverview: movie.overview ?? "", posterImagePath: movie.posterPath ?? nil, backdropPath: movie.backdropPath ?? nil)
            self.headerView?.configure(with: viewModel)
        }
    }
}

extension MovieDetailScreen: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SmallMovieCollectionView.id, for: indexPath) as? SmallMovieCollectionView else { return UITableViewCell() }

        cell.configure(with: viewModel.nowPlayingMovies.value)
        cell.delegate = self
        cell.backgroundColor = .blue
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Latest"
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalizeWords()
    }
}

extension MovieDetailScreen {
    private func setupTableView() {
        view.addSubview(movieInfoTable)
        movieInfoTable.translatesAutoresizingMaskIntoConstraints = false
        movieInfoTable.setTopAnchorConstraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        movieInfoTable.setLeadingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        movieInfoTable.setTrailingAnchorConstraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        movieInfoTable.setBottomAnchorConstraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    }
}

extension MovieDetailScreen: CollectionViewTableViewCellDelegate {
    func CollectionViewTableViewCellDidTapCell(movie: Movie) {
        DispatchQueue.main.async {
            let vc = MovieDetailScreen()
            vc.movie = movie
            self.present(vc, animated: true)
        }
    }
}
