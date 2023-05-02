//
//  FavoritesPresenter.swift
//  ComicsApp
//
//  Created by Celso Lima on 01/05/23.
//

import UIKit

class FavoritesPresenter {
    
    weak var controller: FavoritesController?
    var favoritesDataSource = FavoritesDataSource()
    var favoritesTableViewDelegate = FavoritesTableViewDelegate()
    
    private(set) lazy var favoritesTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()

    // MARK: configureNavigationBar
    func configureNavigationBar(){
        
        let label = UILabel()
        label.text = "Favoritos"
        label.textColor = .white
        label.font = UIFont(name: heroFontName, size: titleFontSize)
        label.applyShadow(shadowColour: .black)
        
        let backButton = UIButton(type: .custom)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = .white
        let image = UIImageView(image: UIImage(named: "BackButton")?.withRenderingMode(.alwaysTemplate))
        image.tintColor = .white
        backButton.setImage(image.image, for: .normal)
        backButton.addTarget(controller?.interactor, action: #selector(controller?.interactor.popViewController), for: .touchUpInside)
        backButton.applyShadow(shadowColour: .black)
        
        let item1 = UIBarButtonItem(customView: backButton)
        
        let fixedSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        fixedSpace.width = 10.0
        let item2 = UIBarButtonItem(customView: label)
        controller?.navigationItem.leftBarButtonItems = [item1, fixedSpace, item2]
    }
    
    // MARK: displayLayout
    func displayLayout(){
        guard let controller = controller else {return}
        controller.view.addSubview(favoritesTableView)
        
        //register cells
        registerTableViewCells()
        
        favoritesTableView.dataSource = favoritesDataSource
        favoritesTableView.delegate = favoritesTableViewDelegate
        favoritesTableView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        favoritesTableView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        favoritesTableView.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        favoritesTableView.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
        self.fetchData()
    }
    
    // MARK: fetchData
    fileprivate func fetchData() {
        
        favoritesDataSource.updateUIWithData = { [weak self] (error) in
            if let weakSelf = self, error == nil{
                DispatchQueue.main.async {
                    weakSelf.favoritesTableView.reloadData()
                }
            }
        }
        
        favoritesDataSource.fetchData()
    }
    
    // MARK: registerTableViewCells
    fileprivate func registerTableViewCells(){
        favoritesTableView.register(ShoppingCartViewCell.self, forCellReuseIdentifier: ShoppingCartViewCell.identifier)
        
    }
    
}
