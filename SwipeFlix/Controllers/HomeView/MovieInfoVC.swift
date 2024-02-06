//
//  MovieInfoView.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 10/5/23.
//

import Foundation
import UIKit

class MovieInfoVC: UIViewController {
	let colorManager = ColorManager()
	let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
	let containerView = UIView()
	let storageService = DatabaseService.shared
	
	var containerTopConstant: CGFloat = 60
	var containerBottomConstant: CGFloat = -70
	var containerTrailConstant: CGFloat = -15
	var containerLeadConstant: CGFloat = 15
	
	
	lazy var movieInfoPoster: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFill
		image.clipsToBounds = true
		image.layer.cornerRadius = 10
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
		button.addTarget(self, action: #selector(viewMoreTapped), for: .touchUpInside)
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

	lazy var dismissButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.tintColor = colorManager.darkgray
		button.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)

		let symbolconfig = UIImage.SymbolConfiguration(pointSize: 45, weight: .light)
		button.setImage(UIImage(systemName: "chevron.compact.down", withConfiguration: symbolconfig), for: .normal)
		return button
	}()
	
	lazy var favoriteButton : UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.tintColor = colorManager.faintWhite
		button.setImage(UIImage(systemName: "star"), for: .normal)
		button.setImage(UIImage(systemName: "star.fill"), for: .selected)
		button.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
		return button
	}()
	
	var descExpanded = false
	
	var movieData: Results?
	
	var savedMovie: HomeViewStorageModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .clear
		setupBlur()
		setupContainerView()
		setupMovieDescription()
	}
	
	
	func setupContainerView() {
		//CONTAINER VIEW
		view.addSubview(containerView)
		containerView.translatesAutoresizingMaskIntoConstraints = false
		containerView.backgroundColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 0.8)
		containerView.layer.cornerRadius = 20
		//MOVIE POSTER
		containerView.addSubview(movieInfoPoster)
		//MOVIE TITLE
		containerView.addSubview(movieTitle)
		//CHIPS STACK
		containerView.addSubview(chipsStack)
		//DISMISS BUTTON
		containerView.addSubview(dismissButton)
		//FAVORITE BUTTON
		containerView.addSubview(favoriteButton)
		
		NSLayoutConstraint.activate([
			//CONTAINTER VIEW
			containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: containerTopConstant),
			containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: containerBottomConstant),
			containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: containerLeadConstant),
			containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: containerTrailConstant),
			//MOVIE POSTER
			movieInfoPoster.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 27),
			movieInfoPoster.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -200),
			movieInfoPoster.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
			movieInfoPoster.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25),
			//MOVIE TITLE
			movieTitle.topAnchor.constraint(equalTo: movieInfoPoster.bottomAnchor, constant: 10),
			movieTitle.leadingAnchor.constraint(equalTo: movieInfoPoster.leadingAnchor),
			movieTitle.widthAnchor.constraint(equalTo: movieInfoPoster.widthAnchor),
			//CHIPS STACK
			chipsStack.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 7),
			chipsStack.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor, constant: 0),
			chipsStack.trailingAnchor.constraint(equalTo: movieTitle.trailingAnchor, constant: -20),
			//DISMISS BUTTON
			dismissButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
			dismissButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			//FAVORITE BUTTON
			favoriteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
			favoriteButton.centerYAnchor.constraint(equalTo: movieTitle.centerYAnchor)
		])
		
	}
	
	func setupMovieDescription() {
		//MOVIE DESCRIPTION
		containerView.addSubview(movieDescription)
		//VIEW MORE
		containerView.addSubview(viewMoreButton)
		
		NSLayoutConstraint.activate([
			//MOVIE DESCRIPTION
			movieDescription.topAnchor.constraint(equalTo: chipsStack.bottomAnchor, constant: 5),
			movieDescription.leadingAnchor.constraint(equalTo: chipsStack.leadingAnchor, constant: -5),
			movieDescription.widthAnchor.constraint(equalTo: chipsStack.widthAnchor),
			movieDescription.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -20),
			//VIEW MORE
			viewMoreButton.trailingAnchor.constraint(equalTo: movieDescription.trailingAnchor),
			viewMoreButton.topAnchor.constraint(equalTo: movieDescription.bottomAnchor, constant: -3),
		
		])
	}
	
	
	func setupBlur() {
		view.addSubview(blurEffect)
		blurEffect.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			blurEffect.topAnchor.constraint(equalTo: view.topAnchor),
			blurEffect.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			blurEffect.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			blurEffect.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	
	func handleMovieDataSave() {
		if favoriteButton.isSelected {
			if let movie = movieData {
				print("THIS WAS SAVED: \(movie.title)")
				storageService.saveMovie(originalLanguage: movie.original_language, title: movie.title, overview: movie.overview, posterPath: movie.poster_path, releaseDate: movie.release_date, voteAverage: movie.vote_average, genreIds: movie.genre_ids, isSaved: true)
			}
		}
			else {
				if let movie = savedMovie {
					print("THIS WAS DELETED FROM MEMORY: \(movie.title)")
					storageService.deleteMovie(movie: movie)
				}
			}
	}
	
	@objc func favoriteTapped() {
		favoriteButton.isSelected.toggle()
	}
	
	@objc func dismissTapped() {
		handleMovieDataSave()
		self.dismiss(animated: true)
	}
	
	func displayData(selectedMovie: Results, indexPath: IndexPath, poster: UIImage) {
		movieData = selectedMovie
	
		let genreLabel = ChipsLabel()
		let audienceScoreLabel = ChipsLabel()
		let releaseLabel = ChipsLabel()
		
			movieInfoPoster.image = poster
			movieTitle.text = selectedMovie.title
			movieDescription.text = selectedMovie.overview
			
			//STACKVIEW CHIPS
			chipsStack.arrangedSubviews[0].addSubview(genreLabel)
			genreLabel.text = "\(colorManager.genresDictionary[selectedMovie.genre_ids.first!]!)"
			genreLabel.centerXAnchor.constraint(equalTo: chipsStack.arrangedSubviews[0].centerXAnchor).isActive = true
			genreLabel.centerYAnchor.constraint(equalTo: chipsStack.arrangedSubviews[0].centerYAnchor).isActive = true
			
			chipsStack.arrangedSubviews[1].addSubview(audienceScoreLabel)
			audienceScoreLabel.text = "Audience Score: \(Int((selectedMovie.vote_average) * 10))%"
			audienceScoreLabel.centerXAnchor.constraint(equalTo: chipsStack.arrangedSubviews[1].centerXAnchor).isActive = true
			audienceScoreLabel.centerYAnchor.constraint(equalTo: chipsStack.arrangedSubviews[1].centerYAnchor).isActive = true
			
			chipsStack.arrangedSubviews[2].addSubview(releaseLabel)
			releaseLabel.text = "Release: \(selectedMovie.release_date.prefix(7))"
			releaseLabel.centerXAnchor.constraint(equalTo: chipsStack.arrangedSubviews[2].centerXAnchor).isActive = true
			releaseLabel.centerYAnchor.constraint(equalTo: chipsStack.arrangedSubviews[2].centerYAnchor).isActive = true
	}
	
	func displayWatchListData(selectedMovie: HomeViewStorageModel, poster: UIImage) {
		savedMovie = selectedMovie
		
		let genreLabel = ChipsLabel()
		let audienceScoreLabel = ChipsLabel()
		let releaseLabel = ChipsLabel()
		
		favoriteButton.isSelected = selectedMovie.isSaved
		print(favoriteButton.isSelected)
		movieInfoPoster.image = poster
		movieTitle.text = selectedMovie.title
		movieDescription.text = selectedMovie.overview
		
		//STACKVIEW CHIPS
		chipsStack.arrangedSubviews[0].addSubview(genreLabel)
		genreLabel.text = "\(colorManager.genresDictionary[selectedMovie.genre_ids.first!]!)"
		genreLabel.centerXAnchor.constraint(equalTo: chipsStack.arrangedSubviews[0].centerXAnchor).isActive = true
		genreLabel.centerYAnchor.constraint(equalTo: chipsStack.arrangedSubviews[0].centerYAnchor).isActive = true
		
		chipsStack.arrangedSubviews[1].addSubview(audienceScoreLabel)
		audienceScoreLabel.text = "Audience Score: \(Int((selectedMovie.vote_average) * 10))%"
		audienceScoreLabel.centerXAnchor.constraint(equalTo: chipsStack.arrangedSubviews[1].centerXAnchor).isActive = true
		audienceScoreLabel.centerYAnchor.constraint(equalTo: chipsStack.arrangedSubviews[1].centerYAnchor).isActive = true
		
		chipsStack.arrangedSubviews[2].addSubview(releaseLabel)
		releaseLabel.text = "Release: \(selectedMovie.release_date.prefix(7))"
		releaseLabel.centerXAnchor.constraint(equalTo: chipsStack.arrangedSubviews[2].centerXAnchor).isActive = true
		releaseLabel.centerYAnchor.constraint(equalTo: chipsStack.arrangedSubviews[2].centerYAnchor).isActive = true
		
	}
	
	
	
	func updateDescription() {
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
	
	@objc func viewMoreTapped() {
		descExpanded.toggle()
		updateDescription()
		
	}
	
	
	
	


}
