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
	
	let colorManager = ColorManager()
	
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

		swipeVC.fetchMovies(selectedRow: indexPath.row)
		tableView.deselectRow(at: indexPath, animated: true)
		swipeVC.modalPresentationStyle = .overFullScreen

		present(swipeVC, animated: true)
		
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as! CategoryTableCell
		
		cell.categoryTitle.text = colorManager.genresDictionary[colorManager.indexToGenreID[indexPath.row]!]
		cell.categoryImage.image = UIImage(named: colorManager.genresDictionary[colorManager.indexToGenreID[indexPath.row]!]!)
		
		
		return cell
	}
	
	
	
	
}
