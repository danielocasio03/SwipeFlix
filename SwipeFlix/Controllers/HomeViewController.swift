//
//  ViewController.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 7/24/23.
//
import Foundation
import UIKit

class HomeViewController: UIViewController {
	let colorManager = ColorManager()
	let homeViewManager = HomeViewManager()
	let homeView = HomeView()
	let collectionView = UICollectionView(frame: .zero, collectionViewLayout: HomeViewController.layoutSetup())
	
	var popularMovies: [Results] = []
	var popularPosters: [UIImage] = []
	var nowPlayingMovies: [Results] = []
	var nowPlayingPosters: [UIImage] = []
	var topRatedMovies: [Results] = []
	var topRatedPosters: [UIImage] = []
	var horrorMovies: [Results] = []
	var horrorPosters: [UIImage] = []

	
	//View did load
	override func viewDidLoad() {
		super.viewDidLoad()
		DispatchQueue.main.async {
			self.recieveMovieData()
		}
		setupView()
		setupCollectionView()
		
		
	}
	
	//General setup of the View
	func setupView() {
		view.addSubview(homeView)
		
		NSLayoutConstraint.activate([
			homeView.topAnchor.constraint(equalTo: view.topAnchor),
			homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	
	func recieveMovieData() {
		homeViewManager.fetchMovies()
		homeViewManager.passMovies = { popularMovies, popularPosters, nowPlayingMovies, nowPlayingPosters, topRatedMovies, topRatedPosters, horrorMovies, horrorPosters, actionMovies, actionPosters, comedyMovies, comedyPosters, dramaMovies, dramaPosters, familyMovies, familyPosters in

			self.updateView(popularMovies: popularMovies, popularPosters: popularPosters, nowPlayingMovies: nowPlayingMovies, nowPlayingPosters: nowPlayingPosters, topRatedMovies: topRatedMovies, topRatedPosters: topRatedPosters, horrorMovies: horrorMovies, horrorPosters: horrorPosters)
		}
		
	}
	
	func updateView(popularMovies: [Results], popularPosters: [UIImage], nowPlayingMovies: [Results], nowPlayingPosters: [UIImage], topRatedMovies: [Results], topRatedPosters: [UIImage], horrorMovies: [Results], horrorPosters: [UIImage]  ) {
		self.popularMovies = popularMovies
		self.popularPosters = popularPosters
		self.nowPlayingMovies = nowPlayingMovies
		self.nowPlayingPosters = nowPlayingPosters
		self.topRatedMovies = topRatedMovies
		self.topRatedPosters = topRatedPosters
		self.horrorMovies = horrorMovies
		self.horrorPosters = horrorPosters
		
		DispatchQueue.main.async {
			
			self.collectionView.reloadData()
		}
		
	}
	
}



//MARK: - ----Collection View ----

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
		cell.moviePoster.image = UIImage(named: "Oppenheimer")
		
		
		switch indexPath.section {
		case 0:
			cell.moviePoster.image = UIImage(named: "Oppenheimer")
		case 1:
			if popularPosters.isEmpty {
				cell.moviePoster.image = UIImage(named: "")
			} else {
				cell.moviePoster.image = popularPosters[indexPath.item]
			}
		case 2:
			if nowPlayingPosters.isEmpty {
				cell.moviePoster.image = UIImage(named: "")
			} else {
				cell.moviePoster.image = nowPlayingPosters[indexPath.item]
			}
		case 3:
			if topRatedPosters.isEmpty {
				cell.moviePoster.image = UIImage(named: "")
			} else {
				cell.moviePoster.image = topRatedPosters[indexPath.item]
			}
		case 4:
			if horrorMovies.isEmpty {
				cell.moviePoster.image = UIImage(named: "")
			} else {
				cell.moviePoster.image = horrorPosters[indexPath.item]
			}
		default:
			cell.moviePoster.image = UIImage(named: "Oppenheimer")
		}
		
		
		return cell
	}
	
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if kind == UICollectionView.elementKindSectionHeader {
			let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! HomeViewHeader
			
			switch indexPath.section {
			case 0:
				headerView.label.text = "Your Watchlist"
			case 1:
				headerView.label.text = "Popular Films"
			case 2:
				headerView.label.text = "Now in Theaters"
			case 3:
				headerView.label.text = "All-Time Top Rated"
			case 4:
				headerView.label.text = "Horror"
			 default:
				headerView.label.text = "Other"
			}
			
			return headerView
		}
		return UICollectionReusableView()
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 20
	}
	
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 5
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


