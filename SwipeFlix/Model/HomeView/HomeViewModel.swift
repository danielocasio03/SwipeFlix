//
//  HomeViewModel.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 9/28/23.
//

import Foundation
import UIKit
import Combine

class HomeViewModel: Decodable {
	
	let results: [Results]

}

struct Results: Decodable {
	
	var posterImage: AnyPublisher<UIImage, Error> {
		return MoviePosterFetch.fetchMoviePoster(posterURL: poster_path)
	}
				
	let original_language: String
	
	let title: String
	
	let overview: String
	
	let poster_path: String
	
	let release_date: String
	
	let vote_average: Double
	
	let genre_ids: [Int]
}




