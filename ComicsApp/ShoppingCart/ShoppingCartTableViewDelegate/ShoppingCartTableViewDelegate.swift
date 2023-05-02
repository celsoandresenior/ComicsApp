//
//  ShoppingCartTableViewDelegate.swift
//  ComicsApp
//
//  Created by Celso Lima on 30/04/23.
//

import UIKit


class ShoppingCartTableViewDelegate : NSObject, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
}
