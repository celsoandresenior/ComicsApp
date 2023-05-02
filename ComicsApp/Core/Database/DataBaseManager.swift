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
    
    func saveToShoppingCart(comic: Comic) {
        if let element = realm.objects(DTOComic.self).filter("comicId == '\(comic.id?.toString() ?? "")' ").first {
            try! realm.write {
                element.quantity += 1
            }
        } else {
            let dto = DTOComic(comicId: comic.id!, title: comic.title ?? "")
            dto.quantity = 1
            
            dto.imagePath =  "\(comic.cover?.path ?? "").\(comic.cover?.fileExtension ?? "")"
            dto.price = comic.prices?.first?.price?.toString() ?? ""
            try! realm.write {
                realm.add(dto)
            }
        }
        
    }
    
    func saveFavoriteComic(comic: Comic) {
        guard let element = realm.objects(DTOFavoriteComic.self).filter("comicId == '\(comic.id?.toString() ?? "")' ").first else {
            let dto = DTOFavoriteComic(comicId: comic.id ?? 0, title: comic.title ?? "")
            dto.imagePath =  "\(comic.cover?.path ?? "").\(comic.cover?.fileExtension ?? "")"
            dto.price = comic.prices?.first?.price?.toString() ?? ""
            try! realm.write {
                realm.add(dto)
            }
            return
        }
        
        try! realm.write {
            realm.delete(element)
        }
    }
    
    func getComics() -> [DTOComic] {
        let dtos = realm.objects(DTOComic.self)
        return Array(dtos)
    }
    
    func getFavoriteComics() -> [DTOFavoriteComic] {
        let dtos = realm.objects(DTOFavoriteComic.self)
        return Array(dtos)
    }
    
    func validFavoriteComic(comic: Comic) -> Bool {

        if let element = realm.objects(DTOFavoriteComic.self).filter("comicId == '\(comic.id?.toString() ?? "")' ").first {
            return true
        } else {
            return false
        }
    }
    
    func cleanDatabase() {
        try? realm.write {
            realm.deleteAll()
        }
    }
}
