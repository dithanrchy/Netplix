//
//  HomeHeaderViewModel.swift
//  Netplix
//
//  Created by Ditha Nurcahya Avianty on 03/03/23.
//

import Foundation

class HomeHeaderViewModel {
    var popularMovies = Box([Movie]())

    init() {
        getPopularMovie()
    }

    func getPopularMovie() {
        APICaller.shared.getPopularMovies { [weak self] results in
            guard let self = self else { return }
            switch results {
            case .success(let movies):
                self.popularMovies.value = movies
            case .failure(let error):
                print(error)
            }
        }
    }
}
