//
//  SearchController.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/8/23.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
	
	let searchView = SearchView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView()
		
	}
	
	func setupView() {
		view.addSubview(searchView)
		
		NSLayoutConstraint.activate([
			searchView.topAnchor.constraint(equalTo: view.topAnchor),
			searchView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		
		])
	}
	
}
