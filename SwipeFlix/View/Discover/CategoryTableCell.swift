//
//  CategoryTableCell.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/7/23.
//

import Foundation
import UIKit

class CategoryTableCell: UITableViewCell {
	
	var categoryImage: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleAspectFit
		return image
	}()
	
	var categoryTitle: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .white
		label.font = UIFont(name: "Comfortaa-Light", size: 12)
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: "CatCell")
		
		backgroundColor = .clear
		
		addSubview(categoryImage)
		addSubview(categoryTitle)
		
		NSLayoutConstraint.activate([
			categoryImage.leadingAnchor.constraint(equalTo: leadingAnchor),
			categoryImage.centerYAnchor.constraint(equalTo: centerYAnchor),
			categoryImage.widthAnchor.constraint(equalToConstant: 25),
			categoryImage.heightAnchor.constraint(equalToConstant: 25),
			
			categoryTitle.leadingAnchor.constraint(equalTo: categoryImage.trailingAnchor, constant: 9),
			categoryTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
			
		])
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
