//
//  ShoppingCartInteractor.swift
//  ComicsApp
//
//  Created by Celso Lima on 29/04/23.
//

import Foundation

class ShoppingCartInteractor {
    weak var controller: ShoppingCartViewController?
    
    @objc func popViewController(){
        controller?.navigationController?.popViewController(animated: true)
    }
}
