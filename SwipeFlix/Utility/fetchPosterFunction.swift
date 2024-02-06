//
//  fetchPosterFunction.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 11/21/23.
//

import Foundation
import Combine
import UIKit

class MoviePosterFetch {
	
	static func fetchMoviePoster(posterURL: String ) -> AnyPublisher<UIImage, Error> {
		
				let posterURL = "https://image.tmdb.org/t/p/w500\(posterURL)"
		
				return  Cacher.session.dataTaskPublisher(for: URL(string: posterURL)!)
					.map{UIImage(data: $0.data)!}
					.mapError({ error in
						return error as Error
					})
					.receive(on: DispatchQueue.main)
					.eraseToAnyPublisher()
	}
	
}
 
