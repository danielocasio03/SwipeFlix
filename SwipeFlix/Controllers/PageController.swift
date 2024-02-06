//
//  PageViewController.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/4/23.
//

import Foundation
import UIKit

class PageController: UIPageViewController, UIPageViewControllerDataSource {
	
	// Array to hold your child view controllers (pages)
	var controllers: [UIViewController] = []
	
	var homeButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.contentMode = .scaleAspectFill
		button.tintColor = .white.withAlphaComponent(0.9)
		let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
		let largeHouse = UIImage(systemName: "house", withConfiguration: largeConfig)
		button.setImage(largeHouse, for: .normal)
		button.isSelected = true
		button.addTarget(self, action: #selector(homeTapped), for: .touchUpInside)
		return button
	}()
	
	var swipeButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.contentMode = .scaleAspectFill
		button.tintColor = .white.withAlphaComponent(0.9)
		let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
		let largeFilms = UIImage(systemName: "film.stack", withConfiguration: largeConfig)
		button.setImage(largeFilms, for: .normal)
		button.isSelected = false
		button.addTarget(self, action: #selector(swipeTapped), for: .touchUpInside)
		return button
	}()
	
	var searchButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.contentMode = .scaleAspectFill
		button.tintColor = .white.withAlphaComponent(0.9)
		let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
		let largeSearch = UIImage(systemName: "magnifyingglass", withConfiguration: largeConfig)
		button.setImage(largeSearch, for: .normal)
		button.isSelected = false
		button.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
		return button
	}()
	
	var homeUnderline: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white.withAlphaComponent(0.85)
		view.layer.cornerRadius = 0.75
		view.widthAnchor.constraint(equalToConstant: 30).isActive = true
		view.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
		return view
	}()
	
	var swipeUnderline: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white.withAlphaComponent(0.85)
		view.layer.cornerRadius = 0.75
		view.widthAnchor.constraint(equalToConstant: 30).isActive = true
		view.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
		view.isHidden = true
		return view
	}()
	
	var searchUnderline: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white.withAlphaComponent(0.85)
		view.layer.cornerRadius = 0.75
		view.widthAnchor.constraint(equalToConstant: 30).isActive = true
		view.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
		view.isHidden = true
		return view
	}()
	
	//MARK: - ViewDidLoad
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .blue
		// Initialize your view controllers
		let HomeViewController = HomeViewController()
		// Add view controllers to the array
		controllers = [HomeViewController]
		
		// Set the data source to self
		dataSource = self
		
		// Set the initial view controller
		setViewControllers([HomeViewController], direction: .forward, animated: true, completion: nil)
		
		setupView()
	}
	
	//MARK: - View Setup Function
	
	func setupView() {
		view.addSubview(homeButton)
		view.addSubview(swipeButton)
		view.addSubview(searchButton)
		view.addSubview(homeUnderline)
		view.addSubview(swipeUnderline)
		view.addSubview(searchUnderline)

		NSLayoutConstraint.activate([
			//Home Button Constraints
			homeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
			homeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
			homeButton.widthAnchor.constraint(equalToConstant: 35),
			homeButton.heightAnchor.constraint(equalToConstant: 35),
			//Swipe Button Constraints
			swipeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
			swipeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			swipeButton.widthAnchor.constraint(equalToConstant: 35),
			swipeButton.heightAnchor.constraint(equalToConstant: 35),
			//Search Button Constraints
			searchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
			searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
			searchButton.heightAnchor.constraint(equalToConstant: 35),
			searchButton.widthAnchor.constraint(equalToConstant: 35),
			//Home Underline View Constraints
			homeUnderline.topAnchor.constraint(equalTo: homeButton.bottomAnchor, constant: 6),
			homeUnderline.centerXAnchor.constraint(equalTo: homeButton.centerXAnchor),
			//Swipe Underline View Constraints
			swipeUnderline.topAnchor.constraint(equalTo: swipeButton.bottomAnchor, constant: 6),
			swipeUnderline.centerXAnchor.constraint(equalTo: swipeButton.centerXAnchor),
			//Search Underline View Constraints
			searchUnderline.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 6),
			searchUnderline.centerXAnchor.constraint(equalTo: searchButton.centerXAnchor, constant: 1.5),
		])
		
	}
	
	//MARK: - Button Action Handling
	
	@objc func homeTapped() {
		print("Home Tapped")
		homeButton.isSelected = true
		swipeButton.isSelected = false
		searchButton.isSelected = false
		handleButtonTap()
	}
	
	@objc func swipeTapped() {
		print("Swipe Tapped")
		swipeButton.isSelected = true
		homeButton.isSelected = false
		searchButton.isSelected = false
		handleButtonTap()
	}
	
	@objc func searchTapped() {
		print("searchTapped")
		searchButton.isSelected = true
		homeButton.isSelected = false
		swipeButton.isSelected = false
		handleButtonTap()
	}
	
	func handleButtonTap() {
		homeUnderline.isHidden = true
		swipeUnderline.isHidden = true
		searchUnderline.isHidden = true
		
		if homeButton.isSelected {
			homeUnderline.isHidden = false
		} else if swipeButton.isSelected {
			swipeUnderline.isHidden = false
		} else if searchButton.isSelected {
			searchUnderline.isHidden = false
		}
		
		
	}
	
	// MARK: - UIPageViewControllerDataSource
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		guard let currentIndex = controllers.firstIndex(of: viewController) else {
			return nil
		}
		
		let previousIndex = currentIndex - 1
		guard previousIndex >= 0 else {
			return nil
		}
		
		return controllers[previousIndex]
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		guard let currentIndex = controllers.firstIndex(of: viewController) else {
			return nil
		}
		
		let nextIndex = currentIndex + 1
		guard nextIndex < controllers.count else {
			return nil
		}
		
		return controllers[nextIndex]
	}
}
