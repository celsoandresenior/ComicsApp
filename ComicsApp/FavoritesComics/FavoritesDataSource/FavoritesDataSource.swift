//
//  FavoritesDataSource.swift
//  ComicsApp
//
//  Created by Celso Lima on 01/05/23.
//

import UIKit

class FavoritesDataSource : NSObject, UITableViewDataSource {
    var updateUIWithData: ((Error?) -> Void)?
    var dtoComics: [DTOFavoriteComic]?
    var total: Double = 0
    
    func fetchData(){
        let manager = DataBaseManager()
        self.dtoComics = Array( manager.getFavoriteComics() )
        
        
        
        self.dtoComics?.forEach({ dto in
            total += Double(dto.quantity) * dto.price.toDouble()
        })
        self.updateUIWithData?(nil)
        
    }
    
    func cleanDatabase() {
        let manager = DataBaseManager()
        manager.cleanDatabase()
        dtoComics?.removeAll()
        self.updateUIWithData?(nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dtoComics?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dtoComic = dtoComics?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartViewCell.identifier, for: indexPath) as! ShoppingCartViewCell
        let imagePath = dtoComic.imagePath
        cell.comicImage.sd_setImage(with: URL(string: imagePath), completed: nil)
        cell.comicTitle.text = dtoComic.title
        return cell
    }
}
