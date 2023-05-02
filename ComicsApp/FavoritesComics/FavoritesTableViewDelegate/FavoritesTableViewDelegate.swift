//
//  FavoritesTableViewDelegate.swift
//  ComicsApp
//
//  Created by Celso Lima on 01/05/23.
//

import UIKit

class FavoritesTableViewDelegate  : NSObject, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}
