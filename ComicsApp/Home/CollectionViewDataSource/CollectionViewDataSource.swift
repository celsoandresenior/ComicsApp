//
//  CollectionViewDataSource.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import UIKit
import SDWebImage



class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var updateUIWithData: ((Error?) -> Void)?
    var comics = [Comic]()
    var searchComics = [Comic]()
    var searching = false
    let dataManager = DataBaseManager()
    
    func fetchData(pageNumber: Int){
        let request = RequestHandler().getComics(pageNumber: pageNumber)
        JSONDecoder().decoderWithRequest(ComicBaseData.self, fromURLRequest: request) { [weak self] (result, error) in
            if let weakSelf = self{
                let comicsResult = result?.apiDataSource?.comics
                if let comics = comicsResult{
                    weakSelf.comics.append(contentsOf: comics)
                }
                
                weakSelf.updateUIWithData?(error)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searching ? searchComics.count : comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        let comic = searching ? searchComics[index] : comics[index]
        let isFavorite = dataManager.validFavoriteComic(comic: comic)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicsCollectionViewCell.identifier, for: indexPath) as! ComicsCollectionViewCell
        cell.setData(comic: comic, isFavorite: isFavorite)
        cell.delegate = self
        return cell
    }
}

// MARK: metodos do filtro
extension CollectionViewDataSource {
    func searchingComics(text: String?) {
        guard let text = text else { return }
        if !text.isEmpty {
            self.searchComics.removeAll()
            self.searching = true
            for comic in comics {
                if let title = comic.title, title.lowercased().contains(text.lowercased()) {
                    searchComics.append(comic)
                }
            }
        } else {
            self.searching = false
            self.searchComics.removeAll()
            self.searchComics = comics
        }
        
        self.updateUIWithData?(nil)
        
    }
}

extension CollectionViewDataSource: ComicsCollectionCellDelegate {
    func saveFavorite(id: Int) {
        let comics = searching ? searchComics: comics
        guard let comic = comics.filter({ $0.id == id }).first else { return }
        dataManager.saveFavoriteComic(comic: comic)
    }
}
