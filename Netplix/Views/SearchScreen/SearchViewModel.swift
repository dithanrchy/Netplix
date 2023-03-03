//
//  SearchViewModel.swift
//  Netplix
//
//  Created by Ditha Nurcahya Avianty on 03/03/23.
//

import Foundation

class SearchViewModel {
    var keyword = ""
//    private var queue = OperationQueue()
    private(set) var movies = [Movie]()
    typealias SearchCompletion = () -> Void

    lazy var search: (@escaping SearchCompletion) -> Debouncer = { [weak self] completion in
        return Debouncer(delay: 0.1) {
            guard let self = self else { return }
    //        self.queue.cancelAllOperations()
    //        var tempMovies = [Movie]()
    //        let query = Blockoperation {
    //
    //        }
            APICaller.shared.getMoviesByTitle(title: self.keyword) { response in
                switch response {
                case .success(let success):
                    self.movies = success
                    completion()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
    }
}
