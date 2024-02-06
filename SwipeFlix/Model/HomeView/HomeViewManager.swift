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
	
	var passMovies: (([Results], [Results], [Results], [Results], [Results], [Results], [Results], [Results])-> Void)?
	
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
		
		
		
		
		let zip1 = Publishers.Zip4(popularMoviesPublisher, nowPlayingPublisher, topRatedPublisher, horrorPublisher)
		let zip2 = Publishers.Zip4(actionPublisher, comedyPublisher, dramaPublisher, familyPublisher)
		
		Publishers.CombineLatest(zip1, zip2)
			.sink(receiveCompletion: {completion in
				print("Movie Data Zip Status: \(completion)")},
				  receiveValue: { zip1, zip2 in
				let (popularMoviesPublisher, nowPlayingPublisher, topRatedPublisher, horrorPublisher) = zip1
				let (actionPublisher, comedyPublisher, dramaPublisher, familyPublisher) = zip2
				
				self.passMovies!(popularMoviesPublisher, nowPlayingPublisher,topRatedPublisher,horrorPublisher, actionPublisher, comedyPublisher, dramaPublisher, familyPublisher)
			}) .store(in: &cancellable)
		
	}
}
