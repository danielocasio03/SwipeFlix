//
//  ChipsLabel.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 10/18/23.
//

import Foundation
import UIKit
class ChipsLabel: UILabel {
	
	let colorManager = ColorManager()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		translatesAutoresizingMaskIntoConstraints = false
		textColor = colorManager.faintWhite
		font = UIFont(name: "Comfortaa-Bold", size: 8)
		
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
