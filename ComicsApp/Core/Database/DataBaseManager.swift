//
//  DataBaseManager.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import Foundation
import RealmSwift
import Realm

class DataBaseManager {
    
    let realm = try! Realm()
    
    func saveToShoppingCart(comic: Comic, isFavoriteComic: Bool = false) {
        if let element = realm.objects(DTOComic.self).filter("comicId == '\(comic.id?.toString() ?? "")' ").first {
            try! realm.write {
                element.quantity += 1
            }
        } else {
            let dto = DTOComic(comicId: comic.id!, title: comic.title ?? "")
            dto.isFavorite = isFavoriteComic
            dto.quantity = 1
            
            dto.imagePath =  "\(comic.cover?.path ?? "").\(comic.cover?.fileExtension ?? "")"
            dto.price = comic.prices?.first?.price?.toString() ?? ""
            try! realm.write {
                realm.add(dto)
            }
        }
        
    }
    
    func getComics() -> [DTOComic] {
        let dtos = realm.objects(DTOComic.self)
        return Array(dtos)
    }
    
    func cleanDatabase() {
        try? realm.write {
            realm.deleteAll()
        }
    }
}
