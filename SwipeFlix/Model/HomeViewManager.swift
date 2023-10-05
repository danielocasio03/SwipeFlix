//
//  HomeViewManager.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 9/28/23.
//

import Foundation
import Combine
import UIKit

class HomeViewManager {
	
	private var cancellable = Set<AnyCancellable>()
	
	var passMovies: (([Results],[UIImage], [Results],[UIImage], [Results],[UIImage], [Results],[UIImage], [Results],[UIImage], [Results],[UIImage], [Results],[UIImage], [Results],[UIImage])-> Void)?
	
	func fetchMovies() {
		// URLS
		let popularURLString = "https://api.themoviedb.org/3/discover/movie?api_key=034bb224cdd023987fd7cb952f046fae&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc#"
		
		let nowPlayingURLString = "https://api.themoviedb.org/3/movie/now_playing?api_key=034bb224cdd023987fd7cb952f046fae"
		
		let topRatedURLString = "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc&vote_count.gte=1500&watch_region=US&with_original_language=en&with_release_type=2%7C3&api_key=034bb224cdd023987fd7cb952f046fae&api_key=034bb224cdd023987fd7cb952f046fae"
		
		let horrorURL = "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&vote_count.gte=50&with_genres=27&with_origin_country=US&with_release_type=3&api_key=034bb224cdd023987fd7cb952f046fae&api_key=034bb224cdd023987fd7cb952f046fae"
		
		let actionURL = "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&vote_count.gte=50&with_genres=28&with_origin_country=US&with_release_type=3&api_key=034bb224cdd023987fd7cb952f046fae&api_key=034bb224cdd023987fd7cb952f046fae"
		
		let comedyURL = "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&vote_count.gte=100&with_genres=35&with_origin_country=US&with_release_type=3&without_genres=16&api_key=034bb224cdd023987fd7cb952f046fae"
		
		let dramaURL = "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&vote_count.gte=100&with_genres=18&with_origin_country=US&with_release_type=3&api_key=034bb224cdd023987fd7cb952f046fae&api_key=034bb224cdd023987fd7cb952f046fae"
		
		let familyURL = "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&vote_count.gte=100&with_genres=10751&with_origin_country=US&with_release_type=3&api_key=034bb224cdd023987fd7cb952f046fae"
		
		//MARK: - PUBLISHERS

		//Popular Movies Fetch
		let popularMoviesPublisher = URLSession.shared.dataTaskPublisher(for: URL(string: popularURLString)!)
			.map(\.data)
			.decode(type: HomeViewModel.self, decoder: JSONDecoder())
			.map {$0.results}
		
		//Now Playing Movies Fetch
		let nowPlayingPublisher = URLSession.shared.dataTaskPublisher(for: URL(string: nowPlayingURLString)!)
			.map(\.data)
			.decode(type: HomeViewModel.self, decoder: JSONDecoder())
			.map {$0.results}
		
		//Top Rated Movied Fetch
		let topRatedPublisher = URLSession.shared.dataTaskPublisher(for: URL(string: topRatedURLString)!)
			.map(\.data)
			.decode(type: HomeViewModel.self, decoder: JSONDecoder())
			.map {$0.results}
		
		// Horror Movie fetch
		let horrorPublisher = URLSession.shared.dataTaskPublisher(for: URL(string: horrorURL)!)
			.map(\.data)
			.decode(type: HomeViewModel.self, decoder: JSONDecoder())
			.map{$0.results}
		
		//Action Movie Fetch
		let actionPublisher = URLSession.shared.dataTaskPublisher(for: URL(string: actionURL)!)
			.map(\.data)
			.decode(type: HomeViewModel.self, decoder: JSONDecoder())
			.map{$0.results}
		
		//Comedy Movie Fetch
		let comedyPublisher = URLSession.shared.dataTaskPublisher(for: URL(string: comedyURL)!)
			.map(\.data)
			.decode(type: HomeViewModel.self, decoder: JSONDecoder())
			.map{$0.results}
		
		//Drama Movie Fetch
		let dramaPublisher = URLSession.shared.dataTaskPublisher(for: URL(string: dramaURL)!)
			.map(\.data)
			.decode(type: HomeViewModel.self, decoder: JSONDecoder())
			.map{$0.results}
		
		//Family Movie Fetch
		let familyPublisher = URLSession.shared.dataTaskPublisher(for: URL(string: familyURL)!)
			.map(\.data)
			.decode(type: HomeViewModel.self, decoder: JSONDecoder())
			.map{$0.results}
		
		
		
		
		Publishers.MergeMany(popularMoviesPublisher, nowPlayingPublisher, topRatedPublisher, horrorPublisher, actionPublisher, comedyPublisher, dramaPublisher, familyPublisher)
			.sink(receiveCompletion: {completion in
				print("Query came back \(completion)")
				
			}, receiveValue: {[weak self] (popularMovies: [Results], nowPlaying: [Results], topRated: [Results], horror: [Results], actionMovies: [Results], comedy: [Results], drama: [Results], family: [Results]) in

				getPosterImages(popularMovies: popularMovies, nowPlayingMovies: nowPlaying, topRatedMovies: topRated, horrorMovies: horror, actionMovies: actionMovies, comedyMovies: comedy, dramaMovies: drama, familyMovies: family)
			})
			.store(in: &cancellable)
		
	}
	
	func getPosterImages(popularMovies: [Results], nowPlayingMovies: [Results], topRatedMovies: [Results], horrorMovies: [Results], actionMovies: [Results], comedyMovies: [Results], dramaMovies: [Results], familyMovies: [Results]) {
		let baseURL = "https://image.tmdb.org/t/p/w500"
		let popularPosterURL = popularMovies.compactMap { URL(string: "\(baseURL)\($0.poster_path)" ) }
		let nowplayingPosterURL = nowPlayingMovies.compactMap { URL(string: "\(baseURL)\($0.poster_path)") }
		let topRatedPosterURL = topRatedMovies.compactMap { URL(string: "\(baseURL)\($0.poster_path)")}
		let horrorPosterURL = horrorMovies.compactMap {URL(string: "\(baseURL)\($0.poster_path)")}
		let actionPosterURL = actionMovies.compactMap {URL(string: "\(baseURL)\($0.poster_path)") }
		let comedyPosterURL = comedyMovies.compactMap {URL(string: "\(baseURL)\($0.poster_path)")}
		let dramaPosterURL = dramaMovies.compactMap {URL(string: "\(baseURL)\($0.poster_path)")}
		let familyPosterURL = familyMovies.compactMap {URL(string: "\(baseURL)\($0.poster_path)")}
		
		let popularPosterPublisher = Publishers.Sequence(sequence: popularPosterURL)
			.flatMap { url in
				URLSession.shared.dataTaskPublisher(for: url)
					.map { UIImage(data: $0.data) }
					.replaceError(with: nil)
			}
			.compactMap { $0 }
			.collect()
			
		
		let nowPlayingPosterPublisher = Publishers.Sequence(sequence: nowplayingPosterURL)
			.flatMap { url in
				URLSession.shared.dataTaskPublisher(for: url)
					.map {UIImage(data: $0.data)}
					.replaceError(with: nil)
			}
			.compactMap { $0 }
			.collect()
		
		let topRatedPosterPublisher = Publishers.Sequence(sequence: topRatedPosterURL)
			.flatMap { url in
				URLSession.shared.dataTaskPublisher(for: url)
					.map {UIImage(data: $0.data)}
					.replaceError(with: nil)
			}
			.compactMap { $0 }
			.collect()
		
		let horrorPosterPublisher = Publishers.Sequence(sequence: horrorPosterURL)
			.flatMap { url in
				URLSession.shared.dataTaskPublisher(for: url)
					.map {UIImage(data: $0.data)}
					.replaceError(with: nil)
			}
			.compactMap {$0}
			.collect()
		
		let actionPosterPublisher = Publishers.Sequence(sequence: actionPosterURL)
			.flatMap { url in
				URLSession.shared.dataTaskPublisher(for: url)
					.map {UIImage(data: $0.data)}
					.replaceError(with: nil)
			}
			.compactMap {$0}
			.collect()
		
		let comedyPosterPublisher = Publishers.Sequence(sequence: comedyPosterURL)
			.flatMap { url in
				URLSession.shared.dataTaskPublisher(for: url)
					.map {UIImage(data: $0.data)}
					.replaceError(with: nil)
			}
			.compactMap {$0}
			.collect()
		
		let dramaPosterPublisher = Publishers.Sequence(sequence: dramaPosterURL)
			.flatMap { url in
				URLSession.shared.dataTaskPublisher(for: url)
					.map {UIImage(data: $0.data)}
					.replaceError(with: nil)
			}
			.compactMap {$0}
			.collect()
		
		let familyPosterPublisher = Publishers.Sequence(sequence: familyPosterURL)
			.flatMap { url in
				URLSession.shared.dataTaskPublisher(for: url)
					.map {UIImage(data: $0.data)}
					.replaceError(with: nil)
			}
			.compactMap {$0}
			.collect()
		
		Publishers.MergeMany(popularPosterPublisher, nowPlayingPosterPublisher, topRatedPosterPublisher, horrorPosterPublisher, actionPosterPublisher, comedyPosterPublisher, dramaPosterPublisher, familyPosterPublisher )
			.sink(receiveValue: { [weak self] (popularPosters, nowPlayingPosters, topRatedPosters, horrorPosters, actionPosters, comedyPosters, dramaPosters, familyPosters) in
				print("Mexicans")
				self?.passMovies!(popularMovies, popularPosters, nowPlayingMovies, nowPlayingPosters, topRatedMovies, topRatedPosters, horrorMovies, horrorPosters, actionMovies, actionPosters, comedyMovies, comedyPosters, dramaMovies, dramaPosters, familyMovies, familyPosters)
			}) .store(in: &cancellable)
	
	}
	
	
	
}
