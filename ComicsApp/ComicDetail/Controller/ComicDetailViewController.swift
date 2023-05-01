//
//  ComicDetailViewController.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import UIKit

class ComicDetailViewController: UIViewController {
    
    var presenter = ComicDetailPresenter()
    var interactor = ComicDetailInteractor()
    
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
        baseNavigationController?.applyStyling(navTitle: "Detalhes do Comic", shouldAddBackButton: true, viewController: self)
    }
}
