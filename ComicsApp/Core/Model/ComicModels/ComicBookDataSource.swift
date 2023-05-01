//
//  ComicBookDataSource.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import Foundation

struct ComicBookDataSource : Codable {
    let comics: [Comic]?
    
    enum CodingKeys: String, CodingKey{
        case comics = "results"
    } 
}
