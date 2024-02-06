//
//  SearchManager.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/20/23.
//

import Foundation
import Combine

class SearchManager {
	
	private var cancellable = Set<AnyCancellable>()
	
	var passSearch: (([Results]) -> Void)?

	func fetchSearchQuery(keywords: String) {
		
		guard let encodedKeywords = keywords.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
			print("Error encoding keywords")
			return
		}
		
	let urlString = "https://api.themoviedb.org/3/search/movie?query=\(encodedKeywords)&include_adult=false&language=en-US&page=1&api_key=034bb224cdd023987fd7cb952f046fae"
		print(urlString)
		
		URLSession.shared.dataTaskPublisher(for: URL(string: urlString)!)
			.map(\.data)
			.decode(type: HomeViewModel.self, decoder: JSONDecoder())
			.sink(receiveCompletion: {completion in
			print("Search Query came back: \(completion)")},
				  receiveValue: { [self]data in
				passSearch!(data.results)
			})
		
			.store(in: &cancellable)
	}
	
}
