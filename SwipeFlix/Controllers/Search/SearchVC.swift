//
//  SearchController.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/8/23.
//

import Foundation
import UIKit
import Combine

class SearchViewController: UIViewController {
	let colorManager = ColorManager()
	let resultsTable = UITableView()
	let searchView = SearchView()
	let searchManager = SearchManager()
	var subscriptions = Set<AnyCancellable>()

	
	var resultsArray: [Results] = []
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		tableViewSetup()
		
	}
	
	func setupView() {
		view.addSubview(searchView)
		searchView.searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
		
		//Search Bar
		searchView.searchBar.returnKeyType = .search
		searchView.searchBar.delegate = self
		
		NSLayoutConstraint.activate([
			searchView.topAnchor.constraint(equalTo: view.topAnchor),
			searchView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		
		])
	}
	
	@objc func searchTapped() {
		fetchSearchedQuery(keywords: searchView.searchBar.text!)
		
	}
	
	func fetchSearchedQuery(keywords: String) {
		view.endEditing(true)
		searchManager.fetchSearchQuery(keywords: keywords)
		searchManager.passSearch = { [self]data in
			DispatchQueue.main.async { [self] in
				resultsArray = data
				resultsTable.reloadData()
				
			}
		}
		
	}
	
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
	
	func tableViewSetup() {
		searchView.addSubview(resultsTable)
		resultsTable.dataSource = self
		resultsTable.delegate = self
		resultsTable.register(ResultsCell.self, forCellReuseIdentifier: "cell")
		
		resultsTable.translatesAutoresizingMaskIntoConstraints = false
		resultsTable.backgroundColor = .clear
		resultsTable.separatorStyle = .none
		
		NSLayoutConstraint.activate([
			resultsTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 230),
			resultsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			resultsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			resultsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		
		])
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return resultsArray.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = resultsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultsCell
		let rowMovie = resultsArray[indexPath.row]
		
		//Movie Poster fetch and Assign
		cell.moviePoster.image = UIImage(named: "")
		
		if let posterImage = rowMovie.posterImage {
				posterImage
				.receive(on: DispatchQueue.main)
				.sink(receiveCompletion: {completion in print(completion)}, receiveValue: {image in
					self.setPoster(indexPath: indexPath, tableView: tableView, moviePoster: image)
				})
				.store(in: &subscriptions)
		} else {
			cell.moviePoster.image = colorManager.noImageAvail.randomElement()!
			
		}
		
		//Cell Property Assignments
		cell.movieTitle.text = rowMovie.title
		cell.movieDescription.text = rowMovie.overview
		if let genre = rowMovie.genre_ids.first {
			cell.movieDetailsLabel.text = "\(colorManager.genresDictionary[genre]!) - Audience Score: \(Int(rowMovie.vote_average * 10))% - Release: \(rowMovie.release_date.prefix(7))"
		} else {cell.movieDetailsLabel.text = "Audience Score: \(Int(rowMovie.vote_average * 10))% - Release: \(rowMovie.release_date.prefix(7))"}
		
		//Cell Animation
		cell.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1 ,options: [], animations: {
			cell.transform = .identity
		}, completion: nil)
		
		
		return cell
	}
	
	
	func setPoster(indexPath: IndexPath, tableView: UITableView, moviePoster: UIImage) {
		guard let cellToChange = tableView.cellForRow(at: indexPath) as? ResultsCell else {return}
		
		cellToChange.moviePoster.image = moviePoster
		
	}
	
	
	
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 125
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let movieInfoVC = MovieInfoVC()
		movieInfoVC.modalPresentationStyle = .overCurrentContext
		present(movieInfoVC, animated: true)
		
//		movieInfoVC.dismissButton.addTarget(self, action: #selector(viewDismissed), for: .touchUpInside)
				
		let rowMovie = resultsArray[indexPath.row]
			
		rowMovie.posterImage?
				.receive(on: DispatchQueue.main)
				.sink(receiveCompletion: {completion in print(completion)}, receiveValue: {image in
					movieInfoVC.displayData(selectedMovie: rowMovie, indexPath: indexPath, poster: image)})
				.store(in: &subscriptions)
		
		
		
	}
	
	
	//MARK: - Search Bar
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		fetchSearchedQuery(keywords: searchView.searchBar.text!)
		return true
	}
	
	
}
