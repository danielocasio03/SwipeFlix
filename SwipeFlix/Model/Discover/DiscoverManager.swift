//
//  DiscoverManager.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/13/23.
//

import Foundation
import Combine

class DiscoverManager {
	
	private var cancellable = Set<AnyCancellable>()
	
	var passMovies: (([Results]) -> Void)?
	
	var movieArray: [Results] = []
	
	
	func fetchSwipeMovies(selectedGenreID: Int) {
		var timesToLoop = Int()
		var moviesNeeded = Int()
		
		if selectedGenreID == 37 || selectedGenreID == 10752 || selectedGenreID == 99 || selectedGenreID == 36 || selectedGenreID == 99  {
			timesToLoop = 12
			moviesNeeded = 240
		} else if selectedGenreID == 10770 {
			timesToLoop = 7
			moviesNeeded = 140
		} else {
			timesToLoop = 37
			moviesNeeded = 740
		}
		
	for num in 1...timesToLoop {
		
		let urlStringFetch = "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=\(num)&sort_by=popularity.desc&vote_count.gte=100&with_genres=\(selectedGenreID)&with_origin_country=US&with_release_type=3&api_key=034bb224cdd023987fd7cb952f046fae"
		
		URLSession.shared.dataTaskPublisher(for: URL(string: urlStringFetch)!)
			.map(\.data)
			.decode(type: HomeViewModel.self, decoder: JSONDecoder())
			.sink(receiveCompletion: {completion in
				print("Swipe Movie Fetch Status Returned: \(completion)")
			},
				  receiveValue: { [self] data in
				movieArray.append(contentsOf: data.results)
				print(data.total_results)
				
				if movieArray.count < moviesNeeded {
					return
				} else {
					passMovies!(movieArray)
				}
				
			})
			.store(in: &cancellable)
		
	}
		
	}
	
}
