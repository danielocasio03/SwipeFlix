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
	
	let total_results: Int

}

struct Results: Decodable {
	
	var posterImage: AnyPublisher<UIImage, Error>? {
		
		guard let posterPath = poster_path else {
			// Handle the case where poster_path is nil (optional)
			return nil
		}
		return MoviePosterFetch.fetchMoviePoster(posterURL: posterPath)
	}
				
	let original_language: String
	
	let title: String
	
	let overview: String
	
	let poster_path: String?
	
	let release_date: String
	
	let vote_average: Double
	
	let genre_ids: [Int]
	
}




