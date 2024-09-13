//
//  Review.swift
//  MoviesApp
//
//  Created by Mudassir Asghar on 13/09/2024.
//  Copyright © 2024 Mohammad Azam. All rights reserved.
//

import Foundation

struct Review: Codable {
    var id: UUID?
    var title: String
    var body: String
    var movie: Movie?
}
