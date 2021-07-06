//
//  SearchResponce.swift
//  Manga
//
//  Created by Igor on 11.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

enum MangaType {
    case topRated
    case popular
    case upComing
    case nowPlaying
    var path: String {
        switch self {
        case .topRated:
            return "/top_rated"
        case .popular:
            return "/popular"
        case .upComing:
            return "/upComing"
        case .nowPlaying:
            return "/nowPlaying"
        }
    }
}

struct SearchResponse: Codable {
    var top: [Manga]
}

struct Manga: Codable {
    var malId: Int
    var rank: Int
    var title: String
    var url: String
    var type: String
    var volumes: Int?
    var startDate: String
    var endDate: String?
    var members: Int
    var score: Float
    var imageUrl: String
    enum CodingKeys: String, CodingKey {
        case malId = "mal_id"
        case rank
        case title
        case url
        case type
        case volumes
        case startDate = "start_date"
        case endDate = "end_date"
        case members
        case score
        case imageUrl = "image_url"
    }
}
