//
//  ResultsCell.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/20/23.
//


import Foundation
import UIKit

class ResultsCell: UITableViewCell {
	
	let colorManager = ColorManager()
	let container = UIView()
	
	var moviePoster: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		return image
	}()
	
	var movieTitle: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .white
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 2
		label.font = UIFont(name: "Comfortaa-Light", size: 14)
		return label
	}()
	
	var movieDescription: UITextView = {
		let textView  = UITextView()
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.font = UIFont(name: "Comfortaa-Light", size: 10)
		textView.textContainer.maximumNumberOfLines = 3
		textView.backgroundColor = .clear
		textView.isEditable = false
		textView.textContainer.lineBreakMode = .byTruncatingTail
		return textView
	}()
	
	var movieDetailsLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont(name: "Comfortaa-Light", size: 8)
		label.backgroundColor = .clear
		return label
	}()
	
	
	static let identifiter =  "Cell"
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: reuseIdentifier)
		
		//changes to the actual cells appearance
		backgroundColor = .clear
		selectionStyle = .none
		
		//The setup for all the UIElements
		setupContainerView()
	}
	
	
	//MARK: - Sets up all the UI elements of the cell
	
	// CONTAINER - This will be the container that makes it to where the cell has a rounded appearance and spacing between each bubble
	func setupContainerView() {
		//Container
		addSubview(container)
		container.backgroundColor = colorManager.black0.withAlphaComponent(0.20)
		container.layer.cornerRadius = 25
		container.clipsToBounds = true
		
		//MoviePoster
		container.addSubview(moviePoster)
		moviePoster.layer.cornerRadius = 15
		moviePoster.clipsToBounds = true
		//Movie Title
		container.addSubview(movieTitle)
		movieTitle.textColor = colorManager.faintWhite
		//Movie Details
		container.addSubview(movieDetailsLabel)
		movieDetailsLabel.textColor = .gray
		//Movie Description
		container.addSubview(movieDescription)
		movieDescription.textColor = colorManager.faintWhite

		
		container.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			//Container
			container.centerXAnchor.constraint(equalTo: centerXAnchor),
			container.centerYAnchor.constraint(equalTo: centerYAnchor),
			container.heightAnchor.constraint(equalToConstant: 110),
			container.widthAnchor.constraint(equalToConstant: 357),
			//Movie Poster
			moviePoster.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
			moviePoster.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
			moviePoster.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
			moviePoster.widthAnchor.constraint(equalToConstant: 60),
			//Movie Title
			movieTitle.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
			movieTitle.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 7),
			movieTitle.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
			//Movie Details
			movieDetailsLabel.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 5),
			movieDetailsLabel.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor, constant: 0),
			movieDetailsLabel.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor, constant: 1),
			//Movie Description
			movieDescription.topAnchor.constraint(equalTo: movieDetailsLabel.bottomAnchor, constant: 3),
			movieDescription.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
			movieDescription.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 5),
			movieDescription.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10)
		])
	}
	
	
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
