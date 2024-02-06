//
//  SwipeController.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/5/23.
//

import Foundation
import UIKit

class DiscoverViewController: UIViewController {
	let discoverView = DiscoverView()
	
	let categoryTable = UITableView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupCategoryTable()
	}
	
	func setupView() {
		view.addSubview(discoverView)
		
		NSLayoutConstraint.activate([
			discoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			discoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			discoverView.topAnchor.constraint(equalTo: view.topAnchor),
			discoverView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		
		])
	}
}


extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
	
	func setupCategoryTable() {
		discoverView.addSubview(categoryTable)
		categoryTable.register(CategoryTableCell.self, forCellReuseIdentifier: "CatCell")
		categoryTable.delegate = self
		categoryTable.dataSource = self
		categoryTable.backgroundColor = .clear
		categoryTable.tintColor = .clear
		categoryTable.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			categoryTable.topAnchor.constraint(equalTo: discoverView.screenTitle.bottomAnchor, constant: 30),
			categoryTable.leadingAnchor.constraint(equalTo: discoverView.leadingAnchor, constant: 15),
			categoryTable.trailingAnchor.constraint(equalTo: discoverView.trailingAnchor, constant: -10),
			categoryTable.bottomAnchor.constraint(equalTo: discoverView.bottomAnchor, constant: -55)
		
		])
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 19
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let swipeVC = SwipeViewController()
		tableView.deselectRow(at: indexPath, animated: true)
		swipeVC.modalPresentationStyle = .overFullScreen


		present(swipeVC, animated: true)
		
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as! CategoryTableCell
		
		
		switch indexPath.row {
		case 0:
			cell.categoryTitle.text = "Action"
			cell.categoryImage.image = UIImage(named: "Action")
			
		case 1:
			cell.categoryTitle.text = "Adventure"
			cell.categoryImage.image = UIImage(named: "Adventure")
			
		case 2:
			cell.categoryTitle.text = "Animation"
			cell.categoryImage.image = UIImage(named: "Animation")
			
		case 3:
			cell.categoryTitle.text = "Comedy"
			cell.categoryImage.image = UIImage(named: "Comedy")
			
		case 4:
			cell.categoryTitle.text = "Crime"
			cell.categoryImage.image = UIImage(named: "Crime")
			
		case 5:
			cell.categoryTitle.text = "Documentary"
			cell.categoryImage.image = UIImage(named: "Documentary")

		case 6:
			cell.categoryTitle.text = "Drama"
			cell.categoryImage.image = UIImage(named: "Drama")

		case 7:
			cell.categoryTitle.text = "Family"
			cell.categoryImage.image = UIImage(named: "Family")

		case 8:
			cell.categoryTitle.text = "Fantasy"
			cell.categoryImage.image = UIImage(named: "Fantasy")
		case 9:
			cell.categoryTitle.text = "History"
			cell.categoryImage.image = UIImage(named: "History")

		case 10:
			cell.categoryTitle.text = "Horror"
			cell.categoryImage.image = UIImage(named: "Horror")

		case 11:
			cell.categoryTitle.text = "Mystery"
			cell.categoryImage.image = UIImage(named: "Mystery")

		case 12:
			cell.categoryTitle.text = "Romance"
			cell.categoryImage.image = UIImage(named: "Romance")

		case 13:
			cell.categoryTitle.text = "Science Fiction"
			cell.categoryImage.image = UIImage(named: "ScienceFiction")

		case 14:
			cell.categoryTitle.text = "TV Movie"
			cell.categoryImage.image = UIImage(named: "Tv")
			
		case 15:
			cell.categoryTitle.text = "Thriller"
			cell.categoryImage.image = UIImage(named: "Thriller")

		case 16:
			cell.categoryTitle.text = "War"
			cell.categoryImage.image = UIImage(named: "War")
			
		case 17:
			cell.categoryTitle.text = "Western"
			cell.categoryImage.image = UIImage(named: "Western")
			
		case 18:
			cell.categoryTitle.text = "Surprise me!"
			cell.categoryImage.image = UIImage(named: "Random")

		default:
			cell.categoryTitle.text = "Extra"

		}
		
		return cell
	}
	
	
	
	
}
