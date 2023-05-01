//
//  ComicsListViewController.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import UIKit

class ComicsListViewController: UIViewController {
    
    let presenter = ComicsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        
    }
    
    fileprivate func setup(){
        view.backgroundColor = .white // use systemBackground if you wish to support dark mode in iOS 13
        presenter.controller = self
        presenter.displayLayout()
        presenter.configureSearchController()
    }
    
    fileprivate func setupNavBar(){
        let navigationController = self.navigationController as? BaseNavigationViewController
        navigationController?.applyStyling(navTitle: "Comics", shouldAddBackButton: false, shouldAddBuyButton: true, viewController: self)
    }
    
}
