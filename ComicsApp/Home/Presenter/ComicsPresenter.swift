//
//  ComicsPresenter.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//
import UIKit
import SPAlert


class ComicsPresenter: NSObject, UICollectionViewDelegate {
    
    weak var controller: ComicsListViewController?
    var pageCounter = 1
    var activityIndicator = ActivityIndicator()
    private let dataSource = CollectionViewDataSource()
    let searchController = UISearchController()
    var searching: Bool = false
    private var searchComics: [Comic] = []
    private var dataManager: DataBaseManager = DataBaseManager()
    
    private(set) lazy var collectionView: UICollectionView = {
       let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.size.width)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 5.0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    func configureNavigationBar(){
        controller?.navigationController?.navigationBar.barStyle = .black
        let navBar = controller?.navigationController?.navigationBar
        navBar?.shadowImage = UIImage()
        navBar?.isTranslucent = false
        navBar?.barTintColor = .red
        
        let leftTitle = UILabel()
        leftTitle.font = UIFont(name: heroFontName, size: titleFontSize)
        leftTitle.text = "Comic"
        leftTitle.textColor = .white
        leftTitle.applyShadow(shadowColour: .black)
        controller?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftTitle)
    }
    
    func displayLayout(){
        guard let controller = controller else {return}
        controller.view.addSubview(collectionView)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.register(ComicsCollectionViewCell.self, forCellWithReuseIdentifier: ComicsCollectionViewCell.identification)
        collectionView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        collectionView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        activityIndicator.displayActivity(view: collectionView)
        activityIndicator.startAanimating()
        fetchData()
    }
    
    //MARK:- Helper
    fileprivate func fetchData(){
        dataSource.fetchData(pageNumber: 0)
        dataSource.updateUIWithData = { [weak self] (error) in
            if let weakSelf = self, error == nil{
                DispatchQueue.main.async {
                    weakSelf.activityIndicator.stopAnimating()
                    weakSelf.collectionView.reloadData()
                    weakSelf.pageCounter += 1
                }
            }
        }
    }
    
    //MARK:- CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let comic = dataSource.comics[indexPath.item]
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.animateButtonPress()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let detailViewController = ComicDetailViewController()
            detailViewController.comic = comic
        self?.controller?.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    
}

//MARK: config for scroll infinite
extension ComicsPresenter {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height - 160{
            dataSource.fetchData(pageNumber: pageCounter)
        }
    }
}

// MARK: ComicsPresenter - go to screens
extension ComicsPresenter {
    
    func goToShoppingCart() {
        let comics = self.dataManager.getComics()
        if comics.isEmpty {
            SPAlert.present(message: "Não possui itens no carrinho...", haptic: .warning)
        } else {
            let shoppingCartViewController = ShoppingCartViewController()
            self.controller?.navigationController?.pushViewController(shoppingCartViewController, animated: true)
        }
    }
    
    func goToFavorites() {
        let favoritesController = FavoritesController()
        self.controller?.navigationController?.pushViewController(favoritesController, animated: true)
    }
    
}
// MARK: ComicsPresenter - UISearchBar Configs and Methods
extension ComicsPresenter: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        dataSource.searching = true
        dataSource.searchingComics(text: text)
        dataSource.updateUIWithData = { [weak self] (error) in
            if let weakSelf = self, error == nil{
                DispatchQueue.main.async {
                    weakSelf.activityIndicator.stopAnimating()
                    weakSelf.collectionView.reloadData()
                    weakSelf.pageCounter += 1
                }
            }
        }
    }
    
    func configureSearchController(){
        guard let controller = controller else {return}
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = .done
        controller.navigationItem.hidesSearchBarWhenScrolling = false
        controller.navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "informe o nome ou ano da HQ..."
    }
}
