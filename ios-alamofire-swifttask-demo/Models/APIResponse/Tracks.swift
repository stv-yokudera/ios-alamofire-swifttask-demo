//
//  Tracks.swift
//  ios-alamofire-swifttask-demo
//
//  Created by OkuderaYuki on 2018/05/03.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation

struct Tracks: Codable {

    var resultCount = 0
    var results = [Track]()
}

struct Track: Codable {

    var trackId = 0
    var trackName = ""
    var artistName = ""
    var artworkUrl100 = ""
}
