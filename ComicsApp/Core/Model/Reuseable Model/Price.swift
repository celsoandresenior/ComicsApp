//
//  Price.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import Foundation
// MARK: - Price
struct Price: Codable {
    let type: String?
    let price: Double?
    
    enum CodingKeys: String, CodingKey {
        case type, price
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
    }
}
