//
//  Request.swift
//  ios-alamofire-swifttask-demo
//
//  Created by OkuderaYuki on 2018/05/03.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Alamofire
import SwiftTask

protocol Request {

    associatedtype Response
    associatedtype ErrorType

    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any] { get }
    var httpHeaderFields: [String: String] { get }

    func sendAPIRequest() -> Task<Float, Response, ErrorType>
    func responseFromData(data: Data, urlResponse: HTTPURLResponse) -> Response?
    func errorFromObject(object: Any, urlResponse: HTTPURLResponse) -> Error?
}

extension Request {

    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }

    var httpHeaderFields: [String: String] {
        return [:]
    }

    func errorFromObject(object: Any, urlResponse: HTTPURLResponse) -> Error? {
        return nil
    }
}

extension Request where Response: Codable {

    func responseFromData(data: Data, urlResponse: HTTPURLResponse) -> Response? {

        Logger.debug(message: "\(urlResponse)")

        let model = try? JSONDecoder().decode(Response.self, from: data)
        return model
    }
}
