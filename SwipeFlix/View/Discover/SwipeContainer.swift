//
//  Container.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/18/23.
//

import Foundation
import UIKit

class SwipeContainer: UIView {
	
	let colorManager = ColorManager()
	var descExpanded = false

	
	lazy var movieInfoPoster: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		image.clipsToBounds = true
		image.layer.cornerRadius = 25
		return image
	}()
	
	lazy var movieTitle : UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = colorManager.faintWhite
		label.font = UIFont(name: "Comfortaa-Bold", size: 16)
		label.numberOfLines = 2
		return label
	}()
	
	lazy var movieDescription: UITextView = {
		let textView  = UITextView()
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.font = UIFont(name: "Comfortaa-Light", size: 13)
		textView.textContainer.maximumNumberOfLines = 4
		textView.textColor = colorManager.faintWhite
		textView.backgroundColor = .clear
		textView.isEditable = false
		textView.textContainer.lineBreakMode = .byTruncatingTail
		return textView
	}()
	
	lazy var viewMoreButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("View More", for: .normal )
		button.titleLabel?.font = UIFont(name: "Comfortaa-Light", size: 9)
		button.setTitleColor(.gray, for: .normal)
		return button
	}()
	
	lazy var chipsStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .equalSpacing
		stack.alignment = .leading
		
		let genreChip = ChipView()
		genreChip.widthAnchor.constraint(equalToConstant: 70).isActive = true
		genreChip.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		let audienceScoreChip = ChipView()
		audienceScoreChip.widthAnchor.constraint(equalToConstant: 105).isActive = true
		audienceScoreChip.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		let releaseChip = ChipView()
		releaseChip.widthAnchor.constraint(equalToConstant: 90).isActive = true
		releaseChip.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		stack.addArrangedSubview(genreChip)
		stack.addArrangedSubview(audienceScoreChip)
		stack.addArrangedSubview(releaseChip)
		return stack
	}()
	
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupContainerView()
		setupMovieDescription()
		
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		containerGradientSetup()
	}

	
	
	
	func setupContainerView() {
		//CONTAINER VIEW
		translatesAutoresizingMaskIntoConstraints = false
		layer.borderWidth = 0.25
		layer.borderColor = colorManager.black10.cgColor
		layer.cornerRadius = 30
		//MOVIE POSTER
		addSubview(movieInfoPoster)
		//MOVIE TITLE
		addSubview(movieTitle)
		//CHIPS STACK
		addSubview(chipsStack)
				
		NSLayoutConstraint.activate([
			//MOVIE POSTER
			movieInfoPoster.topAnchor.constraint(equalTo: topAnchor, constant: 13),
			movieInfoPoster.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -160),
			movieInfoPoster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
			movieInfoPoster.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
			//MOVIE TITLE
			movieTitle.topAnchor.constraint(equalTo: movieInfoPoster.bottomAnchor, constant: 10),
			movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			//CHIPS STACK
			chipsStack.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 7),
			chipsStack.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor, constant: 0),
			chipsStack.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor, constant: -20),
		])
	}
	
	
	
	func containerGradientSetup() {
		//ContainerView Gradient
		let containerGradient = CAGradientLayer()
		containerGradient.colors = [colorManager.black30.cgColor, colorManager.black10.cgColor]
		containerGradient.startPoint = CGPoint(x: 0, y: 0.0)
		containerGradient.endPoint = CGPoint(x: 0, y: 1.0)
		containerGradient.frame = bounds
		clipsToBounds = true
		layer.insertSublayer(containerGradient, at: 0)
		
	}
	
	func setupMovieDescription() {
		//MOVIE DESCRIPTION
		addSubview(movieDescription)
		//VIEW MORE
		addSubview(viewMoreButton)
		viewMoreButton.addTarget(self, action: #selector(viewMoreTapped(_:)), for: .touchUpInside)
		NSLayoutConstraint.activate([
			//MOVIE DESCRIPTION
			movieDescription.topAnchor.constraint(equalTo: chipsStack.bottomAnchor, constant: 5),
			movieDescription.leadingAnchor.constraint(equalTo: movieInfoPoster.leadingAnchor),
			movieDescription.trailingAnchor.constraint(equalTo: movieInfoPoster.trailingAnchor),
			movieDescription.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20),
			//VIEW MORE
			viewMoreButton.trailingAnchor.constraint(equalTo: movieDescription.trailingAnchor, constant: -5),
			viewMoreButton.topAnchor.constraint(equalTo: movieDescription.bottomAnchor),
			
		])
	}
	
	func updateDescription(containerView: UIView) {
		if descExpanded == true {
			movieDescription.textContainer.maximumNumberOfLines = 0
			viewMoreButton.setTitle("Hide", for: .normal)
			movieDescription.removeFromSuperview()
			viewMoreButton.removeFromSuperview()
			setupMovieDescription()
		} else {
			movieDescription.textContainer.maximumNumberOfLines = 4
			viewMoreButton.setTitle("View More", for: .normal)
			movieDescription.removeFromSuperview()
			viewMoreButton.removeFromSuperview()
			setupMovieDescription()
		}
	}
	
	@objc func viewMoreTapped(_ containerView: UIView) {
		descExpanded.toggle()
		updateDescription(containerView: containerView)
		
	}
	
	
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
