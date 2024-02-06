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
		image.contentMode = .scaleAspectFill
		image.clipsToBounds = true
		image.layer.cornerRadius = 5
		image.layer.borderColor = CGColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 0.4)
		image.layer.borderWidth = 0.9
		image.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 0.4)
		image.isHidden = true
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
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
