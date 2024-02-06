//
//  PageViewController.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/4/23.
//

import Foundation
import UIKit

class PageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
	
	// Array to hold your child view controllers (pages)
	var controllers: [UIViewController] = []
	
	let homeViewController = HomeViewController()
	let discoverViewController = DiscoverViewController()
	let searchViewController = SearchViewController()
	
	var homeButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.contentMode = .scaleAspectFill
		button.tintColor = .white.withAlphaComponent(0.9)
		let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .default)
		let largeHouse = UIImage(systemName: "house", withConfiguration: largeConfig)
		button.setImage(largeHouse, for: .normal)
		button.isSelected = true
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
	
	var discoverUnderline: UIView = {
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
	
	override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
		super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		// Add view controllers to the array
		controllers = [homeViewController, discoverViewController, searchViewController]
		
		
		// Set the data source to self
		dataSource = self
		delegate = self
		
		// Set the initial view controller
		setViewControllers([homeViewController], direction: .forward, animated: true, completion: nil)
		
		setupView()
	}
	
	//MARK: - View Setup Function
	
	func setupView() {
		view.addSubview(homeButton)
		homeButton.addTarget(self, action: #selector(homeTapped), for: .touchUpInside)
		view.addSubview(swipeButton)
		swipeButton.addTarget(self, action: #selector(swipeTapped), for: .touchUpInside)
		view.addSubview(searchButton)
		searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
		
		view.addSubview(homeUnderline)
		view.addSubview(discoverUnderline)
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
			discoverUnderline.topAnchor.constraint(equalTo: swipeButton.bottomAnchor, constant: 6),
			discoverUnderline.centerXAnchor.constraint(equalTo: swipeButton.centerXAnchor),
			//Search Underline View Constraints
			searchUnderline.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 6),
			searchUnderline.centerXAnchor.constraint(equalTo: searchButton.centerXAnchor, constant: 1.5),
		])
		
	}
	
	//MARK: - Button Action Handling
	
	@objc func homeTapped() {
		homeButton.isSelected = true
		swipeButton.isSelected = false
		searchButton.isSelected = false
		handleButtonTap()
	}
	
	@objc func swipeTapped() {
		swipeButton.isSelected = true
		homeButton.isSelected = false
		searchButton.isSelected = false
		handleButtonTap()
	}
	
	@objc func searchTapped() {
		searchButton.isSelected = true
		homeButton.isSelected = false
		swipeButton.isSelected = false
		handleButtonTap()
	}
	
	func handleButtonTap() {
		homeUnderline.isHidden = true
		discoverUnderline.isHidden = true
		searchUnderline.isHidden = true
		
		if homeButton.isSelected {
			homeUnderline.isHidden = false
			if controllers.firstIndex(of: homeViewController) ?? 0 > controllers.firstIndex(of: viewControllers?.first ?? UIViewController()) ?? 0 {
				setViewControllers([homeViewController], direction: .forward, animated: true)
			} else {
				setViewControllers([homeViewController], direction: .reverse, animated: true)
			}
		} else if swipeButton.isSelected {
			discoverUnderline.isHidden = false
			if controllers.firstIndex(of: discoverViewController) ?? 0 > controllers.firstIndex(of: viewControllers?.first ?? UIViewController()) ?? 0 {
				setViewControllers([discoverViewController], direction: .forward, animated: true)
			} else {
				setViewControllers([discoverViewController], direction: .reverse, animated: true)
			}
		} else if searchButton.isSelected {
			searchUnderline.isHidden = false
			if controllers.firstIndex(of: searchViewController) ?? 0 > controllers.firstIndex(of: viewControllers?.first ?? UIViewController()) ?? 0 {
				setViewControllers([searchViewController], direction: .forward, animated: true)
			} else {
				setViewControllers([searchViewController], direction: .reverse, animated: true)
			}
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
	
	
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		if completed,
		   let visibleViewController = pageViewController.viewControllers?.first,
		   let visibleIndex = controllers.firstIndex(of: visibleViewController) {
			updateUIForVisibleIndex(visibleIndex)
		}
	}
	
	
	func updateUIForVisibleIndex(_ visibleIndex: Int) {
		if visibleIndex == 0 {
			homeUnderline.isHidden = false
			discoverUnderline.isHidden = true
			searchUnderline.isHidden = true
		} else if visibleIndex == 1 {
			homeUnderline.isHidden = true
			discoverUnderline.isHidden = false
			searchUnderline.isHidden = true
		} else if visibleIndex == 2 {
			homeUnderline.isHidden = true
			discoverUnderline.isHidden = true
			searchUnderline.isHidden = false
		}
	}
	
	
}
