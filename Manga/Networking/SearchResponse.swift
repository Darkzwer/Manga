//
//  SearchResponce.swift
//  Manga
//
//  Created by Igor on 11.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    //var resultCount: Int//request_cache_expiry
    
    var characters: [track]
    
    //var results: [Track]//top /MangaData or just Manga need to change this var to top
}

struct track: Decodable {//MangaData or just Manga
    
    //var trackName: String
    //var collectionName: String?
    //var artistName: String
    //var artworkUrl60: String?
    
    var name: String
    var mal_id: Int
    
//    var rank: Int?
    
    var url: String
    var role: String
//    var type: String?
//    var volumes: Int?
//    var start_date: String?
//    var end_date: String?
//    var members: Int?
//    var score: Int?
    
    var image_url: String
}
