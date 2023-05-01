//
//  Comic.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import Foundation

struct Comic: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let variantDescription: String?
    let issueNumber: Int?
    let pageCount: Int?
    let cover: Thumbnail?
    let fallbackCover: [Thumbnail]?
    let prices: [Price]?
    var isPriceValid: Bool = false
    
    enum CodingKeys: String, CodingKey{
        case cover = "thumbnail", fallbackCover = "images", id
        case issueNumber, pageCount, title, description, variantDescription, prices
    }

    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cover = try values.decodeIfPresent(Thumbnail.self, forKey: .cover)
        fallbackCover = try values.decodeIfPresent([Thumbnail].self, forKey: .fallbackCover)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        issueNumber = try values.decodeIfPresent(Int.self, forKey: .issueNumber)
        pageCount = try values.decodeIfPresent(Int.self, forKey: .pageCount)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        variantDescription = try values.decodeIfPresent(String.self, forKey: .variantDescription)
        prices = try values.decodeIfPresent([Price].self, forKey: .prices)
        if let price = prices?.first?.price  {
            self.isPriceValid = !price.isZero
        }
        
    }
    
}
