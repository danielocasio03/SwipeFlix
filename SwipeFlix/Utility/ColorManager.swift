//
//  ColorManager.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 7/24/23.
//

import Foundation
import UIKit
class ColorManager {
	
	var noImageAvail = [UIImage(named: "NoImageAvail1"),UIImage(named: "NoImageAvail2"),UIImage(named: "NoImageAvail3"), UIImage(named: "NoImageAvail4"), UIImage(named: "NoImageAvail5"), UIImage(named: "NoImageAvail6"),UIImage(named: "NoImageAvail7"),]
	
	let gradientPink = UIColor(red: 223/255, green: 123/255, blue: 99/255, alpha: 0.1)
	
	let gradientPurple = UIColor(red: 27/255, green: 1/255, blue: 32/255, alpha: 1.0)
	
	let faintWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.82)
	
	
	let dislikeButtonColor = UIColor(red: 245/255, green: 39/255, blue: 86/255, alpha: 1.0)
	let likeButtonColor = UIColor(red: 45/255, green: 228/255, blue: 152/255, alpha: 1.0)
	
	let black0 = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
	let black10 = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1.0)
	let black20 = UIColor(red: 20/255, green: 20/255, blue: 20/255, alpha: 1.0)
	let black30 = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0)
	let black40 = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1.0)
	let black60 = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1.0)
	let black90 = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1.0)
	
	
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
		
		777 : "Surprise me!"
		
		]
	
	var indexToGenreID: [Int:Int] = [
	//Index Path Row to genre ID
	
	0 : 28,
	
	1 : 12,
	
	2 : 16,
	
	3 : 35,
	
	4 : 80,
	
	5 : 99,
	
	6 : 18,
	
	7 : 10751,
	
	8 : 14,
	
	9 : 36,
	
	10 : 27,
		
	11 : 9648,
	
	12 : 10749,
	
	13 : 878,
	
	14 : 10770,
	
	15 : 53,
	
	16 : 10752,
	
	17 : 37,
	
	18 : 777
	
	]
	
}
