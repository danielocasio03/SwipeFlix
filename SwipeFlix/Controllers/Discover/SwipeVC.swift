//
//  SwipeViewController.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/12/23.
//

import Foundation
import UIKit
import Combine

class SwipeViewController: UIViewController {
	
	
	//MARK: - Declarations ---
	let colorManager = ColorManager()
	let storageService = DatabaseService.shared
	let discoverManager = DiscoverManager()
	var subscriptions: AnyCancellable?
	var movieDataArray: [Results] = []
	var currentContainer: SwipeContainer?

	
	var containerTopConstant: CGFloat = 70
	var containerBottomConstant: CGFloat = -140
	var containerTrailConstant: CGFloat = -20
	var containerLeadConstant: CGFloat = 20
	
	
	lazy var dislikeButton: DislikeButton = {
		let button = DislikeButton()
		button.tag = 1
		button.addTarget(self, action: #selector(buttonTapped(sender: )), for: .touchUpInside)
		return button
	}()
	
	lazy var likeButton: LikeButton = {
		let button = LikeButton()
		button.tag = 2
		button.addTarget(self, action: #selector(buttonTapped(sender: )), for: .touchUpInside)
		return button
	}()
	
	lazy var screenTitle: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Discover"
		label.textColor = .white
		label.font = UIFont(name: "Comfortaa-Light", size: 25)
		return label
	}()
	
	 var genreTitle: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Testing"
		label.textColor = .white
		label.font = UIFont(name: "Comfortaa-Light", size: 14)
		return label
	}()
	
	lazy var dismissButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.tintColor = colorManager.faintWhite
		button.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
		
		let symbolconfig = UIImage.SymbolConfiguration(pointSize: 37, weight: .light)
		button.setImage(UIImage(systemName: "chevron.compact.down", withConfiguration: symbolconfig), for: .normal)
		return button
	}()
	
	
	
	//MARK: - View Did Load ---
	override func viewDidLoad() {
		super.viewDidLoad()
		viewGradientSetup()
		setupViewAttributes()
		
	}
	
	
	//MARK: - Movie Fetch Functions ---
	func fetchMovies(selectedRow: Int) {
		var usedRow = Int()
		if selectedRow == 18 {
			usedRow = Int(arc4random_uniform(UInt32(selectedRow)))
		} else {
			usedRow = selectedRow
		}
		genreTitle.text = colorManager.genresDictionary[colorManager.indexToGenreID[usedRow]!]
		discoverManager.fetchSwipeMovies(selectedGenreID: colorManager.indexToGenreID[usedRow]!)
		discoverManager.passMovies = {data in
			DispatchQueue.main.async {
				self.handleScreenUpdate(movieData: data)
			}
		}
		
	}
	
	func handleScreenUpdate (movieData: [Results]) {
		
		let container = SwipeContainer()
		currentContainer = container
		setupContainerView(containerView: currentContainer!)
		
		movieDataArray = movieData
		print(movieDataArray.count)
		var subscription: AnyCancellable?
		guard let selectedMovie = movieDataArray.first else {return}
		
		if let posterImage = selectedMovie.posterImage {
			subscription = posterImage
				.receive(on: DispatchQueue.main)
				.sink(receiveCompletion: {completion in print(completion)}, receiveValue: {image in
					container.movieInfoPoster.image = image
				})
			subscriptions = subscription
		} else {
			container.movieInfoPoster.image = UIImage(named: "NoImageAvailable")
		}
		
			container.movieTitle.text = selectedMovie.title
			
			container.movieDescription.text = selectedMovie.overview
			
			let genreLabel = ChipsLabel()
			let audienceScoreLabel = ChipsLabel()
			let releaseLabel = ChipsLabel()
			
			//STACKVIEW CHIPS
			container.chipsStack.arrangedSubviews[0].addSubview(genreLabel)
			genreLabel.text = genreTitle.text
			genreLabel.centerXAnchor.constraint(equalTo: container.chipsStack.arrangedSubviews[0].centerXAnchor).isActive = true
			genreLabel.centerYAnchor.constraint(equalTo: container.chipsStack.arrangedSubviews[0].centerYAnchor).isActive = true
			
			container.chipsStack.arrangedSubviews[1].addSubview(audienceScoreLabel)
			audienceScoreLabel.text = "Audience Score: \(Int((selectedMovie.vote_average) * 10))%"
			audienceScoreLabel.centerXAnchor.constraint(equalTo: container.chipsStack.arrangedSubviews[1].centerXAnchor).isActive = true
			audienceScoreLabel.centerYAnchor.constraint(equalTo: container.chipsStack.arrangedSubviews[1].centerYAnchor).isActive = true
			
			container.chipsStack.arrangedSubviews[2].addSubview(releaseLabel)
			releaseLabel.text = "Release: \(selectedMovie.release_date.prefix(7))"
			releaseLabel.centerXAnchor.constraint(equalTo: container.chipsStack.arrangedSubviews[2].centerXAnchor).isActive = true
			releaseLabel.centerYAnchor.constraint(equalTo: container.chipsStack.arrangedSubviews[2].centerYAnchor).isActive = true
		
	}
	

	
	
	//MARK: - View Setup Functions ---
	
	func viewGradientSetup() {
		//View Gradient
		view.backgroundColor = .black
		let gradient = CAGradientLayer()
		gradient.colors = [colorManager.gradientPink.cgColor, colorManager.gradientPurple.cgColor]
		gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
		gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
		gradient.frame = view.bounds
		view.layer.insertSublayer(gradient, at: 0)
	}
	
	func setupContainerView(containerView: UIView) {
		
		view.addSubview(containerView)
		
		
		containerView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
		UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0 ,options: [], animations: {
			containerView.transform = .identity
		}, completion: nil)
		
		containerView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(swipeCard(sender:))))

		
		NSLayoutConstraint.activate([
			
			containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: containerTopConstant),
			containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: containerBottomConstant),
			containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: containerLeadConstant),
			containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: containerTrailConstant),
		])
	}
	
	@objc func swipeCard(sender: UIPanGestureRecognizer) {
		sender.swipeView(sender.view!)
		
		switch sender.state {
		case .ended:
			let translation = sender.translation(in: sender.view)
			if translation.x < -100 {
				print(translation.x)
				
				// Left swiped
				movieDataArray.removeFirst()
				handleScreenUpdate(movieData: self.movieDataArray)
				flingOffScreenAnimation(view: sender.view!, toLeft: true)
				
			} else if translation.x > 100{
//				let movie = movieDataArray.first!
				// Right swiped
//				storageService.saveMovie(originalLanguage: movie.original_language, title: movie.title, overview: movie.overview, posterPath: movie.poster_path!, releaseDate: movie.release_date, voteAverage: movie.vote_average, genreIds: movie.genre_ids, isSaved: true)
				handleMovieDataSave()
				movieDataArray.removeFirst()
				flingOffScreenAnimation(view: sender.view!, toLeft: false)
				handleScreenUpdate(movieData: self.movieDataArray)
				
				
			}
		default:
			break
		}
	}
	
	
	
	
	@objc func buttonTapped(sender: UIButton) {
		if sender.tag == 1 {
			print("Dislike Tapped")
			movieDataArray.removeFirst()
			flingOffScreenAnimation(view: currentContainer!, toLeft: true)
			handleScreenUpdate(movieData: self.movieDataArray)

			
		} else if sender.tag == 2 {
//			let movie = movieDataArray.first!
			print("Like Tapped")
			handleMovieDataSave()
			movieDataArray.removeFirst()
			flingOffScreenAnimation(view: currentContainer!, toLeft: false)
			handleScreenUpdate(movieData: self.movieDataArray)
//			storageService.saveMovie(originalLanguage: movie.original_language, title: movie.title, overview: movie.overview, posterPath: movie.poster_path!, releaseDate: movie.release_date, voteAverage: movie.vote_average, genreIds: movie.genre_ids, isSaved: true)
		}
	}
	
	
	
	
	func handleMovieDataSave() {
			
		if let movie = movieDataArray.first {
				if !storageService.isMovieSaved(movieTitle: movie.title) {
					// Movie is not saved, so save it
					print("THIS WAS SAVED: \(movie.title)")
					
					storageService.saveMovie (
						originalLanguage: movie.original_language,
						title: movie.title,
						overview: movie.overview,
						posterPath: movie.poster_path!,
						releaseDate: movie.release_date,
						voteAverage: movie.vote_average,
						genreIds: movie.genre_ids,
						isSaved: true
					)
					
				} else {
					// Movie is already saved
					print("Movie is already saved")
					
				}
			}
	}
	
	// Update the existing animateOffScreen method to handle both left and right flings
	private func flingOffScreenAnimation(view: UIView, toLeft: Bool) {
		UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut],  animations: {
			let translationX = toLeft ? -view.frame.width : view.frame.width
			view.transform = CGAffineTransform(translationX: translationX, y: 50)
		}) { _ in
			
			view.removeFromSuperview()


		}
	}
	
	func setupViewAttributes() {
		//DISLIKE BUTTON
		view.addSubview(dislikeButton)
		//LIKE BUTTON
		view.addSubview(likeButton)
		//SCREEN TITLE
		view.addSubview(screenTitle)
		//GENRE LABEL
		view.addSubview(genreTitle)
		//DISMISS BUTTON
		view.addSubview(dismissButton)
		
		NSLayoutConstraint.activate([
			//DISLIKE BUTTON
			dislikeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
			dislikeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
			//LIKE BUTTON
			likeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
			likeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
			//SCREEN TITLE
			screenTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
			screenTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
			//GENRE LABEL
			genreTitle.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 3),
			genreTitle.leadingAnchor.constraint(equalTo: screenTitle.leadingAnchor, constant: 3),
			//DISMISS BUTTON
			dismissButton.topAnchor.constraint(equalTo: screenTitle.topAnchor, constant: 0),
			dismissButton.leadingAnchor.constraint(equalTo: screenTitle.trailingAnchor, constant: 10)
			
		
		])
	}
	
	
	
	//MARK: - User Action Handlers ---
	@objc func dismissTapped() {
		self.dismiss(animated: true)
	}
	
}

