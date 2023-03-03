//
//  MovieDetailViewModel.swift
//  Netplix
//
//  Created by Ditha Nurcahya Avianty on 03/03/23.
//

import Foundation

class MovieDetailViewModel {
    private(set) var nowPlayingMovies = Box([Movie]())

    init() {
        APICaller.shared.getNowPlayingMovies { results in
            switch results {
            case let .success(movies):
                self.nowPlayingMovies.value = movies
            case let .failure(error):
                print(error)
            }
        }
    }

    func getVideoElement(movieTitle: String, completion: @escaping (VideoTrailer) -> Void) {
        APICaller.shared.getMovie(with: movieTitle + " trailer") { result in
            switch result {
            case let .success(videoElement):
                completion(videoElement)
            case let .failure(error):
                print(error)
            }
        }
    }
}
