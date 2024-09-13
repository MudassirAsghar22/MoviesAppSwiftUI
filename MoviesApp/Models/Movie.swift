//
//  Movie.swift
//  MoviesApp
//
//  Created by Mudassir Asghar on 11/09/2024.
//

import Foundation

struct Movie: Codable {
    var id: UUID?
    var title:  String
    var poster: String

    private enum MovieKeys: String, CodingKey {
        case id
        case title
        case poster
    }
}

extension Movie {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.poster = try container.decode(String.self, forKey: .poster)
    }
}
