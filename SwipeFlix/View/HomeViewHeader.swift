//
//  homeViewHeader.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 8/1/23.
//

import Foundation
import UIKit

class HomeViewHeader: UICollectionReusableView {
	let colorManager = ColorManager()
	
	var label: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont(name: "Comfortaa", size: 25)
		label.text = "Test"
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupHeaderView()
	}
	
	
	func setupHeaderView() {
		addSubview(label)
		translatesAutoresizingMaskIntoConstraints = false
		
		label.textColor = colorManager.faintWhite
		NSLayoutConstraint.activate([
			label.centerXAnchor.constraint(equalTo: centerXAnchor),
			label.topAnchor.constraint(equalTo: topAnchor),
		
		])
		
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
