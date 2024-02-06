//
//  Cacher.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 11/6/23.
//

import Foundation

class Cacher {
	static var session: URLSession = {
		
		let MB = 1024 * 1024
		
		let
		cache = URLCache (memoryCapacity: 100 * MB, diskCapacity: 100 * MB, diskPath: "images")
		let config = URLSessionConfiguration.default
		
		config.urlCache = cache
		
		return URLSession(configuration: config)
		
	}()
	}
