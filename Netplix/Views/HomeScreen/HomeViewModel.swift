//
//  HomeViewModel.swift
//  Netplix
//
//  Created by Ditha Nurcahya Avianty on 03/03/23.
//

import Foundation

class HomeViewModel {
    var nowPlayingMovies = Box([Movie]())
    var actionMovies = Box([Movie]())

    init() {
        getNowPlayingMovies()
        getActionMoview()
    }

    func getNowPlayingMovies() {
        APICaller.shared.getNowPlayingMovies { [weak self] results in
            guard let self = self else { return }
            switch results {
            case .success(let movies):
                self.nowPlayingMovies.value = movies
            case .failure(let error):
                print(error)
            }
        }
    }

    func getActionMoview() {
        APICaller.shared.getActionsMovies { [weak self] results in
            guard let self = self else { return }
            switch results {
            case .success(let movies):
                self.actionMovies.value = movies
            case .failure(let error):
                print(error)
            }
        }
    }
}
