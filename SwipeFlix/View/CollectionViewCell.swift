//
//  HomeCollectionViewCell.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 7/24/23.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
	
	lazy var moviePoster: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		translatesAutoresizingMaskIntoConstraints = false
		
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		setupPoster()
	}
	
	func setupPoster() {
		addSubview(moviePoster)
		
		moviePoster.frame = self.bounds
		
		NSLayoutConstraint.activate([
			moviePoster.topAnchor.constraint(equalTo: topAnchor),
			moviePoster.leadingAnchor.constraint(equalTo: leadingAnchor),
			moviePoster.trailingAnchor.constraint(equalTo: trailingAnchor),
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
