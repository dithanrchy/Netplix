//
//  HomeScreen.swift
//  Netplix
//
//  Created by Ditha Nurcahya Avianty on 02/03/23.
//

import UIKit

enum Sections: Int {
    case Latest = 0
    case Action = 1
}

class HomeScreen: UIViewController {

    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect.zero)

    private var headerView: HomeHeaderView?
    private let viewModel = HomeViewModel()

    let sectionTitles: [String] = ["Latest", "Action"]

    private let homeTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.register(SmallMovieCollectionView.self, forCellReuseIdentifier: SmallMovieCollectionView.id)
        table.register(LargeMovieCollectionView.self, forCellReuseIdentifier: LargeMovieCollectionView.id)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(homeTable)
        homeTable.delegate = self
        homeTable.dataSource = self

        configureNavbar()

        headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 250))
        headerView?.delegate = self
        homeTable.tableHeaderView = headerView

        viewModel.nowPlayingMovies.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.homeTable.reloadData()
            }
        }
        viewModel.actionMovies.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.homeTable.reloadData()
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTable.frame = view.bounds
    }

    private func configureNavbar() {
        navigationItem.title = "Netplix"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonClicked))
    }

    @objc func searchButtonClicked() {
        navigationController?.pushViewController(SearchScreen(), animated: false)
    }

}

extension HomeScreen: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Sections.Latest.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SmallMovieCollectionView.id, for: indexPath) as? SmallMovieCollectionView else { return UITableViewCell() }
            cell.delegate = self
            cell.configure(with: viewModel.nowPlayingMovies.value)
            return cell
        case Sections.Action.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LargeMovieCollectionView.id, for: indexPath) as? LargeMovieCollectionView else { return UITableViewCell() }
            cell.configure(with: viewModel.actionMovies.value)
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }

//        cell.delegate = self
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 100 : 200
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalizeWords()
    }
}

extension HomeScreen: CollectionViewTableViewCellDelegate {
    func CollectionViewTableViewCellDidTapCell(movie: Movie) {
        DispatchQueue.main.async {
            let vc = MovieDetailScreen()
            vc.movie = movie
            self.present(vc, animated: true)
        }
    }
}
