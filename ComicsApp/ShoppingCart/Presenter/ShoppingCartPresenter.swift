//
//  ShoppingCartPresenter.swift
//  ComicsApp
//
//  Created by Celso Lima on 29/04/23.
//

import UIKit
import SPAlert

class ShoppingCartPresenter {
    
    weak var controller: ShoppingCartViewController?
    var shoppingCartDataSource = ShoppingCartDataSource()
    var shoppingCartTableViewDelegate = ShoppingCartTableViewDelegate()
    
    var shoppingCartTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    var viewFinishBuy: UIView = {
        let uiview = UIView(frame: .zero)
        uiview.translatesAutoresizingMaskIntoConstraints = false
        uiview.backgroundColor = .red
        return uiview
    }()
    
    var buttonFinishBuy: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("finalizar compra", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.white, for: .normal)
        return button
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
        //backButton.addTarget(controller?.interactor, action: #selector(controller?.interactor.popViewController), for: .touchUpInside)
        backButton.applyShadow(shadowColour: .black)
        
        let item1 = UIBarButtonItem(customView: backButton)
        
        let fixedSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        fixedSpace.width = 10.0
        let item2 = UIBarButtonItem(customView: label)
        controller?.navigationItem.leftBarButtonItems = [item1, fixedSpace, item2]
    }
    
    func displayLayout(){
        
        guard let controller = controller else {return}
        controller.view.addSubview(shoppingCartTableView)
        controller.view.addSubview(viewFinishBuy)
        viewFinishBuy.addSubview(buttonFinishBuy)
        
        //register cells
        registerTableViewCells()
        
        shoppingCartTableView.dataSource = shoppingCartDataSource
        shoppingCartTableView.delegate = shoppingCartTableViewDelegate
        shoppingCartTableView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        shoppingCartTableView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        shoppingCartTableView.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        self.fetchData()
        
        
        viewFinishBuy.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        viewFinishBuy.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        viewFinishBuy.topAnchor.constraint(equalTo: shoppingCartTableView.bottomAnchor, constant: 10).isActive = true
        viewFinishBuy.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
        viewFinishBuy.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        buttonFinishBuy.leadingAnchor.constraint(equalTo: viewFinishBuy.leadingAnchor).isActive = true
        buttonFinishBuy.trailingAnchor.constraint(equalTo: viewFinishBuy.trailingAnchor).isActive = true
        buttonFinishBuy.centerYAnchor.constraint(equalTo: viewFinishBuy.centerYAnchor).isActive = true
        buttonFinishBuy.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonFinishBuy.addTarget(self, action: #selector(finishPayment), for: .touchUpInside)
        
    }
    
    fileprivate func fetchData() {
        
        shoppingCartDataSource.updateUIWithData = { [weak self] (error) in
            if let weakSelf = self, error == nil{
                DispatchQueue.main.async {
                    //weakSelf.activityIndicator.stopAnimating()
                    weakSelf.shoppingCartTableView.reloadData()
                    let value = weakSelf.shoppingCartDataSource.total.toCurrent()
                    weakSelf.buttonFinishBuy.setTitle("finalizar compra $ \(value)", for: .normal)
                }
            }
        }
        
        shoppingCartDataSource.fetchData()
    }
    
    
    fileprivate func registerTableViewCells(){
        shoppingCartTableView.register(ShoppingCartViewCell.self, forCellReuseIdentifier: ShoppingCartViewCell.identifier)
        
    }
    
    @objc fileprivate func finishPayment() {
        if let dtoComics = shoppingCartDataSource.dtoComics, !dtoComics.isEmpty {
            shoppingCartDataSource.updateUIWithData = { [weak self] (error) in
                if let weakSelf = self, error == nil{
                    DispatchQueue.main.async {
                        SPAlert.present(message: "Pedido finalizado com sucesso!", haptic: .success)
                        weakSelf.shoppingCartTableView.reloadData()
                        let value = ""
                        weakSelf.buttonFinishBuy.setTitle("Não existem itens no carrinho", for: .normal)
                    }
                }
            }
            
            shoppingCartDataSource.cleanDatabase()
            
        } else {
            controller?.interactor.popViewController()
        }
    }
}


