//
//  chipViews.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 10/18/23.
//

import Foundation
import UIKit

class ChipView: UIView {
	let colorManager = ColorManager()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = colorManager.darkergray
		layer.cornerRadius = 10
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
	
}
