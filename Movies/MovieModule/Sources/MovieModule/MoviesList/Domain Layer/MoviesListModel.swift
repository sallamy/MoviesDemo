//
//  MailResponse.swift
//  BanqueMisr-UAE
//
//  Created by mohamed salah on 16/04/2023.
//

import Foundation

public struct Movie: Codable {
    let id: Int?
    let title: String?
    let poster: String?
    let overview: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case title = "original_title"
        case releaseDate = "release_date"
        case poster = "poster_path"
    }
}

public struct MoviesListModel: Codable {
    let page: Int?
    let results: [Movie]?
}
