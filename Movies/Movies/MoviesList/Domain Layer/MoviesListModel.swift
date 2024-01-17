//
//  MailResponse.swift
//  BanqueMisr-UAE
//
//  Created by mohamed salah on 16/04/2023.
//

import Foundation

struct Movie: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let releaseDate: String?
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case title = "original_title"
        case releaseDate = "release_date"
    }
}

struct MoviesListModel: Codable {
    let page: Int?
    let results: [Movie]?
}
