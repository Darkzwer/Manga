//
//  SearchResponce.swift
//  Manga
//
//  Created by Igor on 11.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    //var request_cached: Bool//request_cache_expiry
    //var characters: [track]
    var top: [track]
}

struct track: Decodable {//MangaData or just Manga
    var mal_id: Int
    var rank: Int
    var title: String
    var url: String
    var type: String
    var volumes: Int?
    var start_date: String
    var end_date: String?
    var members: Int
    var score: Float
    var image_url: String
}

//struct track: Decodable {
//    var mal_id: Int
//    var url: String
//    var image_url: String
//    var name: String
//    var role: String
//}
