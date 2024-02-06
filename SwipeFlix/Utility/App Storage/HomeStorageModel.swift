//
//  HomeViewStorageModel.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 11/9/23.
//

import Foundation
import Combine
import SwiftData
import UIKit

@Model
class HomeViewStorageModel: Identifiable {
	
		
	let original_language: String
	
	let id: String
	
	let title: String
	
	let overview: String
	
	let poster_path: String
	
	let release_date: String
	
	let vote_average: Double
	
	let genre_ids: [Int]
	
	var isSaved: Bool
	
	init(original_language: String, title: String, overview: String, poster_path: String, release_date: String, vote_average: Double, genre_ids: [Int], isSaved: Bool) {
				
		self.original_language = original_language
		
		self.id = UUID().uuidString
		
		self.title = title
		
		self.overview = overview
		
		self.poster_path = poster_path
		
		self.release_date = release_date
		
		self.vote_average = vote_average
		
		self.genre_ids = genre_ids
		
		self.isSaved = isSaved
		
	}
	
}
