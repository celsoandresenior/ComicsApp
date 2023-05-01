//
//  ComicDetailPresenter.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import UIKit
import SPAlert

class ComicDetailPresenter {
    
    weak var controller: ComicDetailViewController?
    var comicDataSource = ComicDetailTableViewDataSource()
    var comicTableViewDelegate = ComicDetailTableViewDelegate()
    
    var comicDetailTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white // not supporting dark mode currently
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    func configureNavigationBar(){
        
        let label = UILabel()
        label.text = "Comic Information"
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
    
    func displayLayout(){
        
        guard let controller = controller else {return}
        controller.view.addSubview(comicDetailTableView)
        
        //register cells
        registerTableViewCells()
        
        comicDetailTableView.dataSource = comicDataSource
        comicDetailTableView.delegate = comicTableViewDelegate
        comicDataSource.buttonsTableViewDelegate = self
        comicDataSource.fetchDataFromSelectedArray(comic: controller.comic)
        comicDetailTableView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        comicDetailTableView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        comicDetailTableView.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        comicDetailTableView.bottomAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    fileprivate func registerTableViewCells(){
        comicDetailTableView.register(ComicHeaderTableViewCell.self, forCellReuseIdentifier: ComicHeaderTableViewCell.identifier)
        comicDetailTableView.register(ComicDescriptionTableViewCell.self, forCellReuseIdentifier: ComicDescriptionTableViewCell.identifier)
        comicDetailTableView.register(ComicPriceTableViewCell.self, forCellReuseIdentifier: ComicPriceTableViewCell.identifier)
        comicDetailTableView.register(ComicButtonsTableViewCell.self, forCellReuseIdentifier: ComicButtonsTableViewCell.identifier)
    }
}

extension ComicDetailPresenter: ButtonsTableViewDelegate {
    func save() {
        guard let comic = controller?.comic else { return }
        let database = DataBaseManager()
        database.saveToShoppingCart(comic: comic)
        SPAlert.present(title: "HQ salva com sucesso.", preset: .done)
    }
    
    
}
