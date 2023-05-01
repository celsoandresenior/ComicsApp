//
//  ComicDetailTableViewDelegate.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import UIKit

class ComicDetailTableViewDelegate: NSObject, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 1:
            return setupSectionHeader(title: "Resumo", tableView: tableView)
        case 2:
            return setupSectionHeader(title: "Valor", tableView: tableView)
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 2{
            return 60
        }
        return 0
    }
    
    //AMRK:- Helper
    
    func setupSectionHeader(title: String, tableView: UITableView) -> UIView{
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        headerView.backgroundColor = .red
        
        let titleForHeaderView = UILabel()
        headerView.addSubview(titleForHeaderView)
        titleForHeaderView.font = UIFont(name: heroFontName, size: 30)
        titleForHeaderView.text = title
        titleForHeaderView.textColor = .white
        titleForHeaderView.translatesAutoresizingMaskIntoConstraints = false
        titleForHeaderView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10).isActive = true
        titleForHeaderView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true
        titleForHeaderView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        return headerView
    }
}
