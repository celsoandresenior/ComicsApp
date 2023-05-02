//
//  FavoritesController.swift
//  ComicsApp
//
//  Created by Celso Lima on 01/05/23.
//

import UIKit

class FavoritesController: UIViewController {
    var presenter = FavoritesPresenter()
    var interactor = FavoritesInteractor()
    
    var comic: Comic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    // MARK: setup
    fileprivate func setup(){
        view.backgroundColor = .white
        presenter.controller = self
        presenter.displayLayout()
        interactor.controller = self
    }
    
    // MARK: setupNavBar
    fileprivate func setupNavBar(){
        let baseNavigationController = navigationController as? BaseNavigationViewController
        baseNavigationController?.applyStyling(navTitle: "Favoritos", shouldAddBackButton: true, viewController: self)
    }
}
