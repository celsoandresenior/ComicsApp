//
//  ComicDetailInteractor.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import UIKit

class ComicDetailInteractor{
    weak var controller: ComicDetailViewController?
    
    @objc func popViewController(){
        controller?.navigationController?.popViewController(animated: true)
    }
}
