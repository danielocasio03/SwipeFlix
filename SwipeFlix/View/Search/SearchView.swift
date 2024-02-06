//
//  SearchView.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/8/23.
//


import Foundation
import UIKit

class SearchView: UIView {
	
	//MARK: - Declarations
	let colorManager = ColorManager()
	
	lazy var screenTitle: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Search"
		label.textColor = .white
		label.font = UIFont(name: "Comfortaa-Light", size: 25)
		return label
	}()
	
	lazy var gradientLayer: CAGradientLayer = {
		let gradient = CAGradientLayer()
		gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
		gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
		return gradient
	}()
	
	lazy var searchBar: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.backgroundColor = UIColor(red: 239/255, green: 116/255, blue: 92/255, alpha: 0.05)
		textField.font = UIFont(name: "Comfortaa-Light", size: 12)
		textField.textColor = .white
		textField.placeholder = "Search for Movies..."
		textField.layer.cornerRadius = 10
		
		let padding = UIView()
		padding.frame = CGRect(x: 0, y: 0, width: 12, height: 0)
		textField.leftView = (padding)
		textField.leftViewMode = .always
		
		return textField
	}()
	
	lazy var searchButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
		button.tintColor = colorManager.faintWhite
		return button
	}()
	
	//MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		//View
		backgroundColor = .black
		translatesAutoresizingMaskIntoConstraints = false
		//Screen Title
		addSubview(screenTitle)
		//Search Bar
		addSubview(searchBar)
		//Search Button
		addSubview(searchButton)
		//Gradient
		gradientLayer.colors = [colorManager.gradientPink.cgColor, colorManager.gradientPurple.cgColor]
		layer.insertSublayer(gradientLayer, at: 0)
		
		NSLayoutConstraint.activate([
			//Screen Title
			screenTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
			screenTitle.topAnchor.constraint(equalTo: topAnchor, constant: 150),
			//Search Bar
			searchBar.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 15),
			searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
			searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
			searchBar.heightAnchor.constraint(equalToConstant: 28),
			//Search Button
			searchButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -5),
			searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor)
		])
		
	}
	
	
	override func layoutSubviews() {
		super.layoutSubviews()
		//Upon subviews being laid out, gradients frame is set to equal views bounds
		gradientLayer.frame = bounds
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
