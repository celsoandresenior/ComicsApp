//
//  ShoppingCartDataSource.swift
//  ComicsApp
//
//  Created by Celso Lima on 29/04/23.
//

import UIKit

class ShoppingCartDataSource: NSObject, UITableViewDataSource {
    var updateUIWithData: ((Error?) -> Void)?
    var dtoComics: [DTOComic]?
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
        cell.comicQuantity.text = "Qtdade: \(dtoComic.quantity)"
        cell.comicPrice.text = "$ \(dtoComic.price)"
        return cell
    }
}

// MARK: extension ShoppingCartDataSource
extension ShoppingCartDataSource {
    // MARK: setup
    func fetchData(){
        let manager = DataBaseManager()
        self.dtoComics = Array( manager.getComics() )
        self.dtoComics?.forEach({ dto in
            total += Double(dto.quantity) * dto.price.toDouble()
        })
        self.updateUIWithData?(nil)
    }
    
    // MARK: cleanDatabase
    func cleanDatabase() {
        let manager = DataBaseManager()
        manager.cleanDatabase()
        dtoComics?.removeAll()
        self.updateUIWithData?(nil)
    }
    
    // MARK: setEmptyImage
    private func setEmptyImage(_ tableView: UITableView) {
        let image = UIImage(named: "homem de ferro")?.scale(newWidth: tableView.bounds.width/3)
        let noDataImage = UIImageView(image: image)
        noDataImage.contentMode = UIView.ContentMode.scaleAspectFill
        noDataImage.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.frame.height)
        tableView.backgroundView = noDataImage
        tableView.separatorStyle = .none
    }
    
}
