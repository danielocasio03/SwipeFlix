//
//  Database Storage.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/1/23.
//

import Foundation
import SwiftData

class DatabaseService {
	
	static var shared = DatabaseService()
	var container: ModelContainer?
	var context:  ModelContext?
	
	init() {
		
		do {
			let schema = Schema([
				HomeViewStorageModel.self
			])
			let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
			container = try ModelContainer(for: schema, configurations: [modelConfiguration])
			if let container {
				
				context = ModelContext(container)
			}
			
		}
		
		catch {
			print(error)
		}
		
	}
	
	func saveMovie(originalLanguage: String, title: String, overview: String, posterPath: String, releaseDate: String, voteAverage: Double, genreIds: [Int], isSaved: Bool) {
		
		let movieTobeSaved = HomeViewStorageModel(original_language: originalLanguage, title: title, overview: overview, poster_path: posterPath, release_date: releaseDate, vote_average: voteAverage, genre_ids: genreIds, isSaved: isSaved )
		context?.insert(movieTobeSaved)
	}
	
	func fetchStoredMovies(onCompletion: @escaping([HomeViewStorageModel]?, Error?)-> (Void)){
		let descriptor = FetchDescriptor<HomeViewStorageModel>(sortBy: [SortDescriptor<HomeViewStorageModel>(\.title)])
		
		do {
			let data = try context?.fetch(descriptor)
			onCompletion(data, nil)
		}
		catch {
			onCompletion(nil,error)
		}
	}
	
	
	func deleteMovie(movie: HomeViewStorageModel) {
		context?.delete(movie)
		
	}
	
	
}
