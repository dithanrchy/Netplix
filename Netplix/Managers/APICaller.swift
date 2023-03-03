//
//  APICaller.swift
//  Netplix
//
//  Created by Ditha Nurcahya Avianty on 02/03/23.
//

import Foundation
import Alamofire

struct Constants {
    static let baseURL: String = "https://api.themoviedb.org"
    static let API_KEY: String = "bc82420486812909498ed747e9c4d36f"
    static let imageURL = "https://image.tmdb.org/t/p/w500"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    static let youtubeAPI_KEY: String = "AIzaSyB5YrjNANveiOIIFn4X3m-VdApoO7pcJT4"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()

    func getMoviesByTitle(title: String, completion: @escaping (Result<[Movie], AFError>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(title)") else { return }

        AF.request(url)
            .validate()
            .responseDecodable(of: MoviesResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)") else {return}

        AF.request(url)
            .validate()
            .responseDecodable(of: MoviesResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func getNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/now_playing?api_key=\(Constants.API_KEY)") else {return}

        AF.request(url)
            .validate()
            .responseDecodable(of: MoviesResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func getActionsMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string:"\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&with_genres=28") else {return}

        AF.request(url)
            .validate()
            .responseDecodable(of: MoviesResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    func getMovie(with query: String, completion: @escaping (Result<VideoTrailer, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.youtubeBaseURL)q=\(query)&key=\(Constants.youtubeAPI_KEY)") else {return}

        AF.request(url)
            .validate()
            .responseDecodable(of: YoutubeSearchResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data.items?[0] ?? VideoTrailer(id: IdElement(kind: "bla", videoId: "s"))))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

