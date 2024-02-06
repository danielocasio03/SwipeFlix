//
//  ViewController.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 7/24/23.
//
import Foundation
import UIKit
import Combine

class HomeViewController: UIViewController {
	let colorManager = ColorManager()
	let homeViewManager = HomeViewManager()
	let homeView = HomeView()
	//	let movieInfoVC = MovieInfoVC()
	var subscriptions: [IndexPath:AnyCancellable] = [:]
	var movieDictionary: [Int:[Results]] = [:]
	let storageService = DatabaseService.shared
	
	
	let collectionView = UICollectionView(frame: .zero, collectionViewLayout: HomeViewController.layoutSetup())
	var popularMovies: [Results] = []
	var nowPlayingMovies: [Results] = []
	var topRatedMovies: [Results] = []
	var horrorMovies: [Results] = []
	var actionMovies: [Results] = []
	var comedyMovies: [Results] = []
	var dramaMovies: [Results] = []
	var familyMovies: [Results] = []
	var watchlistMovies: [HomeViewStorageModel] = []
	
	
	
	
	
	
	//View did load
	override func viewDidLoad() {
		super.viewDidLoad()
		
		DispatchQueue.main.async {
			self.recieveMovieData()
		}
		updateWatchlist()
		setupView()
		setupCollectionView()
		
		
		
	}
	
	
	
	//General setup of the View
	func setupView() {
		view.addSubview(homeView)
		view.backgroundColor = .black
		
		NSLayoutConstraint.activate([
			homeView.topAnchor.constraint(equalTo: view.topAnchor),
			homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	
	func recieveMovieData() {
		homeViewManager.fetchMovies()
		homeViewManager.passMovies = { popularMovies, nowPlayingMovies, topRatedMovies, horrorMovies, actionMovies, comedyMovies, dramaMovies, familyMovies in
			
			self.updateView(popularMovies: popularMovies, nowPlayingMovies: nowPlayingMovies, topRatedMovies: topRatedMovies, horrorMovies: horrorMovies, actionMovies: actionMovies, comedyMovies: comedyMovies, dramaMovies: dramaMovies, familyMovies: familyMovies)
		}
		
	}
	
	func updateView(popularMovies: [Results], nowPlayingMovies: [Results], topRatedMovies: [Results], horrorMovies: [Results], actionMovies: [Results], comedyMovies: [Results], dramaMovies:[Results], familyMovies:[Results] ) {
		self.popularMovies = popularMovies
		self.nowPlayingMovies = nowPlayingMovies
		self.topRatedMovies = topRatedMovies
		self.horrorMovies = horrorMovies
		self.actionMovies = actionMovies
		self.comedyMovies = comedyMovies
		self.dramaMovies = dramaMovies
		self.familyMovies = familyMovies
		
		movieDictionary = [
			1 : popularMovies,
			2 : nowPlayingMovies,
			3 : topRatedMovies,
			4 : horrorMovies,
			5 : actionMovies,
			6 : comedyMovies,
			7 : dramaMovies,
			8 : familyMovies,
		]
		
		DispatchQueue.main.async {
			
			self.collectionView.reloadData()
		}
		
	}
	
	func updateWatchlist() {
		
		storageService.fetchStoredMovies { data, error in
			if let error {
				print(error)
			}
			if let data {
				self.watchlistMovies = data
				DispatchQueue.main.async {
					self.collectionView.reloadData()
				}
			}
		}
		
	}
	
}



//MARK: - ----Collection View ----

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
		cell.moviePoster.image = nil
		var subscription: AnyCancellable?
		
		if indexPath.section == 0 {
			
			let movieForCell = watchlistMovies[indexPath.item]
			let moviePoster = MoviePosterFetch.fetchMoviePoster(posterURL: movieForCell.poster_path)
			
			subscription = moviePoster
				.receive(on: DispatchQueue.main)
				.sink(receiveCompletion: {status in
					print("Movie Poster assignment \(status)") },
					  receiveValue: {image in
					cell.moviePoster.image = image})
			subscriptions[indexPath] = subscription
			cell.moviePoster.isHidden = false
			
		} else{
			if movieDictionary[indexPath.section]?[indexPath.item].posterImage == nil {
				cell.moviePoster.image = nil
			} else {
				subscription = movieDictionary[indexPath.section]?[indexPath.item].posterImage
					.receive(on: DispatchQueue.main)
					.sink(receiveCompletion: {status in
						print("Movie Poster assignment \(status)") },
						  receiveValue: {image in
						cell.moviePoster.image = image})
				subscriptions[indexPath] = subscription
				cell.moviePoster.isHidden = false
			}
		}
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let movieInfoVC = MovieInfoVC()
		movieInfoVC.modalPresentationStyle = .overCurrentContext
		present(movieInfoVC, animated: true)
		
		movieInfoVC.dismissButton.addTarget(self, action: #selector(viewDismissed), for: .touchUpInside)
		
		var subscription: AnyCancellable?
		
		if indexPath.section == 0 {
			
			let watchlistSelectedMovie = watchlistMovies[indexPath.item]
			
			let moviePoster = MoviePosterFetch.fetchMoviePoster(posterURL: watchlistSelectedMovie.poster_path)
			print(moviePoster)
			subscription = moviePoster
				.receive(on: DispatchQueue.main)
				.sink(receiveCompletion: {completion in print(completion)}, receiveValue: {image in
					movieInfoVC.displayWatchListData(selectedMovie: watchlistSelectedMovie, poster: image)})
			subscriptions[indexPath] = subscription
			
		} else {
			
			guard let selectedMovie = movieDictionary[indexPath.section]?[indexPath.item] else {return}
			
			subscription = movieDictionary[indexPath.section]?[indexPath.item].posterImage
				.receive(on: DispatchQueue.main)
				.sink(receiveCompletion: {completion in print(completion)}, receiveValue: {image in
					movieInfoVC.displayData(selectedMovie: selectedMovie, indexPath: indexPath, poster: image)})
			subscriptions[indexPath] = subscription
		}

		
	}
	
	@objc func viewDismissed() {
		updateWatchlist()
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if kind == UICollectionView.elementKindSectionHeader {
			let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! HomeViewHeader
			
			switch indexPath.section {
			case 0:
				
				if watchlistMovies.isEmpty {
					headerView.label.text = ""
				} else {
					headerView.label.text = "Your Watchlist"
				}
				
			case 1:
				
				if popularMovies.isEmpty {
					headerView.label.text = ""
				} else {
					headerView.label.text = "Popular Films"
				}
				
			case 2:
				
				if nowPlayingMovies.isEmpty {
					headerView.label.text = ""
				} else {
					headerView.label.text = "Now in Theaters"
				}
				
			case 3:
				
				if topRatedMovies.isEmpty {
					headerView.label.text = ""
				} else {
					headerView.label.text = "All-Time Top Rated"
				}
				
			case 4:
				
				if horrorMovies.isEmpty {
					headerView.label.text = ""
				} else {
					headerView.label.text = "Horror"
				}
					
			case 5:
				
				if actionMovies.isEmpty {
					headerView.label.text = ""
				} else {
					headerView.label.text = "Action"
				}
					
			case 6:
				
				if comedyMovies.isEmpty {
					headerView.label.text = ""
				} else {
					headerView.label.text = "Comedy"
				}
				
			case 7:
				
				if dramaMovies.isEmpty {
					headerView.label.text = ""
				} else {
					headerView.label.text = "Drama"
				}
				
			case 8:
				
				if familyMovies.isEmpty {
					headerView.label.text = ""
				} else {
					headerView.label.text = "Family"
				}
					
			default:
				headerView.label.text = "Other"
			}
			
			return headerView
		}
		return UICollectionReusableView()
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if section == 0 {
			return watchlistMovies.count
			
		} else if movieDictionary[section]?.count == nil{
			return 0
		} else {
			guard let moviesInSection = movieDictionary[section]?.count else {
				return 0
			}
			return moviesInSection
		}
		
	}
	
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 9
	}
	
	
	func setupCollectionView(){
		
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
		collectionView.register(HomeViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeaderView")
		view.addSubview(collectionView)
		
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .clear
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 125),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
			
		])
	}
	
	
	static func layoutSetup() -> UICollectionViewCompositionalLayout {
		//Item
		let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.333), heightDimension: .fractionalHeight(0.84)))
		item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
		//Group
		let group = NSCollectionLayoutGroup.horizontal(
			layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.29)),
			subitems: [item]
		)
		
		//Sections
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .continuous
		let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(49))
		let headerView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
		section.boundarySupplementaryItems = [headerView]
		
		return UICollectionViewCompositionalLayout(section: section)
		
	}
	
	
}


