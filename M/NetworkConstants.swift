//
//  NetworkConstants.swift
//  Api
//
//  Created by imac-1681 on 2023/8/11.
//

import Foundation

class NetworkConstants {
    static let ApiAdress = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001"

    enum ApiPath: String {
        case path = ""
    }


    enum HTTPMethod:String {
        case options = "OPTIONS"
        case get = "GET"
        case head = "HEAD"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
        case trace = "TRACE"
        case connect = "CONNECT"
    }

    enum HttpHeaderField:String {

        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptTypeE = "Accept"
        case acceptEncoding = "Accept-Encoding"

    }

    enum ContentType: String {

        case json = "application/json"
        case xml = "application/xml"
        case x_www_form_urlencoded = "application/x-www-form- urlencoded"

    }

    enum RequestError : Error {
        case unknownError(Error)
        case connectionError
        case invalidResponse
        case jsonDecodeFailed(Error)
        case badRequest
        case badGateway
        case invalidRequest //400
        case authorizationError // 401
        case notFound// 404
        case internalError //500
        case serverError // 502
        case serverUnavailable // 503
    }
}


