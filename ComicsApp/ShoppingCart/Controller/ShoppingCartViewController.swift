//
//  ShoppingCartViewController.swift
//  ComicsApp
//
//  Created by Celso Lima on 29/04/23.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    
    var presenter = ShoppingCartPresenter()
    var interactor = ShoppingCartInteractor()
    
    var comic: Comic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    fileprivate func setup(){
        view.backgroundColor = .white
        presenter.controller = self
        presenter.displayLayout()
        interactor.controller = self
        
        let baseNavigationController = navigationController as? BaseNavigationViewController
        baseNavigationController?.applyStyling(navTitle: "Carrinho de Compras", shouldAddBackButton: true, viewController: self)
    }
    
}
