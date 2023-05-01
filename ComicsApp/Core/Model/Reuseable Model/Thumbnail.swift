//
//  Thumbnail.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import Foundation
struct Thumbnail : Codable {
    let path : String?
    let fileExtension : String?

    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        fileExtension = try values.decodeIfPresent(String.self, forKey: .fileExtension)
    }

}
