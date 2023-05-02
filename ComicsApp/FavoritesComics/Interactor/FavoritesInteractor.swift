//
//  FavoritesInteractor.swift
//  ComicsApp
//
//  Created by Celso Lima on 01/05/23.
//

import Foundation

class FavoritesInteractor {
    weak var controller: FavoritesController?
    
    @objc func popViewController(){
        controller?.navigationController?.popViewController(animated: true)
    }
}
