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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dtoComics = dtoComics else { return 0 }
        if dtoComics.isEmpty {
            self.setEmptyImage(tableView)
            return 0
        } else {
            return dtoComics.count
        }
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

// MARK: FavoritesDataSource
extension FavoritesDataSource {
    
    // MARK: fetchData
    func fetchData(){
        let manager = DataBaseManager()
        self.dtoComics = Array( manager.getFavoriteComics() )
        self.dtoComics?.forEach({ dto in
            total += Double(dto.quantity) * dto.price.toDouble()
        })
        self.updateUIWithData?(nil)
        
    }
    
    // MARK: setEmptyImage
    private func setEmptyImage(_ tableView: UITableView) {
        let image = UIImage(named: "spider-man")?.scale(newWidth: tableView.bounds.width/3)
        let noDataImage = UIImageView(image: image)
        noDataImage.contentMode = UIView.ContentMode.scaleAspectFill
        noDataImage.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.frame.height)
        tableView.backgroundView = noDataImage
        tableView.separatorStyle = .none
    }
}
