//
//  HomeViewModel.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 9/28/23.
//

import Foundation

struct HomeViewModel: Decodable {
	
	let results: [Results]
	
}

struct Results: Decodable {
	
	let adult: Bool
	
	let backdrop_path: String
	
	let original_language: String
	
	let title: String
	
	let overview: String
	
	let poster_path: String
	
	let release_date: String
	
	let vote_average: Double
	
	
}
