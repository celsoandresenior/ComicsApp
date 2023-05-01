//
//  RequestHandler.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import Foundation

class RequestHandler{
    private var limit: Int = 30
    private let baseURL = "https://gateway.marvel.com"
    
    func getComics(pageNumber: Int = 0) -> URLRequest{
        let endpoint = "/v1/public/comics"
        let url = baseURL + endpoint + buildQueryString(pageNumber: pageNumber, isComicList: true)
        print(url)
        let request = URLRequest(url: URL(string: url)!)
        return request
        
    }
    
    private func buildQueryString(pageNumber: Int = 0, isComicList: Bool = false) -> String{
        let timeStamp = Date().timeIntervalSince1970
        var queryString = "?ts=\(timeStamp)&apikey=\(publicKey)&hash=\(buildHashToken(timestamp: timeStamp))"
        if isComicList{
            var pageNumber = pageNumber
            pageNumber = limit * pageNumber
            queryString = queryString + "&limit=\(limit)&offset=\(pageNumber)"
        }
        return queryString
    }
    
    private func buildHashToken(timestamp: TimeInterval) -> String{
        let unhashedString = "\(timestamp)" + privateKey + publicKey
        return MD5(str: unhashedString)
    }
}
