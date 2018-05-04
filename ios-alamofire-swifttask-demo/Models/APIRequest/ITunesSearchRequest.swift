//
//  ITunesSearchRequest.swift
//  ios-alamofire-swifttask-demo
//
//  Created by OkuderaYuki on 2018/05/03.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Alamofire
import SwiftTask

struct ITunesSearchError: Error {

    enum ErrorKind {
        case empty
        case searchfailed
        case unreachable
    }

    let kind: ErrorKind

    var message: String {
        switch kind {
        case .empty:
            return NSLocalizedString("ITUNES_SEARCH_FAILED", comment: "")
        case .searchfailed:
            return NSLocalizedString("ITUNES_SEARCH_EMPTY", comment: "")
        case .unreachable:
            return NSLocalizedString("ITUNES_SEARCH_UNREACHABLE", comment: "")
        }
    }
}

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
    typealias ErrorType = ITunesSearchError

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

    func sendAPIRequest() -> Task<Float, Response, ITunesSearchError> {

        func determineAPIErrorType(apiError: APIError) -> ITunesSearchError {

            switch apiError {
            case .connectionError(let error):

                if error.isOffline {
                    Logger.debug(message: "isOffline")
                    return ITunesSearchError(kind: .unreachable)
                }
                if error.isTimeout {
                    Logger.debug(message: "isTimeout")
                    return ITunesSearchError(kind: .unreachable)
                }
                return ITunesSearchError(kind: .searchfailed)

            case .invalidResponse:
                return ITunesSearchError(kind: .searchfailed)

            case .parseError(let responseData):

                Logger.debug(message: "responseData: \(String(data: responseData, encoding: .utf8) ?? "")")
                return ITunesSearchError(kind: .searchfailed)
            }
        }

        let task = Task<Float, Response, ITunesSearchError> { progress, fulfill, reject, configure in

            APIClient.request(request: self)
                .success { result in
                    Logger.debug(message: "APIClient.request: success")

                    if result.resultCount == 0 {
                        reject(ITunesSearchError(kind: .empty))
                        return
                    }
                    fulfill(result)

                }.failure { error in
                    Logger.debug(message: "APIClient.request: failure")
                    Logger.debug(message: "error: \(error)")

                    guard let apiError = error.error else {
                        reject(ITunesSearchError(kind: .searchfailed))
                        return
                    }
                    reject(determineAPIErrorType(apiError: apiError))

                }.then { _, _ in
                    Logger.debug(message: "done")
            }
        }
        return task
    }
}
