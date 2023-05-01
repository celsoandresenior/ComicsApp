//
//  DTOComic.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import Foundation

import Foundation
import RealmSwift

class DTOComic: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String = ""
    @Persisted var comicdescription: String = ""
    @Persisted var comicId: String = ""
    @Persisted var isFavorite: Bool = false
    @Persisted var imagePath: String = ""
    @Persisted var price: String = ""
    @Persisted var quantity: Int = 0
    
    convenience init(comicId: Int, title: String) {
        self.init()
        self.comicId = comicId.toString()
        self.title = title
        
    }
}
