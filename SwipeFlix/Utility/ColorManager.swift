//
//  ColorManager.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 7/24/23.
//

import Foundation
import UIKit
class ColorManager {
	
	let gradientPink = UIColor(red: 223/255, green: 123/255, blue: 99/255, alpha: 0.1)
	
	let gradientPurple = UIColor(red: 27/255, green: 1/255, blue: 32/255, alpha: 1.0)
	
	let faintWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.82)
	
	let darkergray = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0)
	
	let darkgray = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1.0)
	
	
	
	var genresDictionary: [Int:String] = [
		28 : "Action",
				
		12 : "Adventure",
		
		16 : "Animation",
		
		35 : "Comedy",
		
		80 : "Crime",
			
		99 : "Documentary",
			
		18 : "Drama",
			
		10751 : "Family",
			
		14 : "Fantasy",
		
		36 : "History",
		
		27 : "Horror",
			
		10402 : "Music",
		
		9648 : "Mystery",
		
		10749 : "Romance",
		
		878 : "Science Fiction",

		10770 : "TV Movie",
			
		53 : "Thriller",
		
		10752 : "War",
	
		37 : "Western",
		
		]
	
	
}
