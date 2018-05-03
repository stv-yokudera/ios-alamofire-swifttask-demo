//
//  ITunesSearchRequest.swift
//  ios-alamofire-swifttask-demo
//
//  Created by OkuderaYuki on 2018/05/03.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Alamofire

final class ITunesSearchRequest: Request {

    init(term: String) {
        self.term = term
    }

    var term = ""
    var country = "JP"
    var lang = "ja_jp"
    var media = "music"

    typealias ResponseComponent = Track
    typealias Response = Tracks

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return "/search"
    }

    var parameters: [String : Any] {
        return [
            "term": term,
            "country": country,
            "lang": lang,
            "media": media
        ]
    }
}
