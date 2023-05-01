//
//  ComicsCollectionViewCell.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//


import UIKit

class ComicsCollectionViewCell: UICollectionViewCell {
    static let identification: String = "ComicsCollectionViewCell"
    var activityIndicator = ActivityIndicator()
    
    var heroImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 15
        return image
    }()
    
    fileprivate var nameHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var name: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: heroFontName, size: 40)
        label.textColor = .white
        return label
    }()
    
    override func layoutSubviews() {
        self.applyShadow(shadowColour: .black)
        contentView.addSubview(heroImage)
        heroImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        heroImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        heroImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        heroImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        heroImage.addSubview(nameHolderView)
        nameHolderView.leadingAnchor.constraint(equalTo: heroImage.leadingAnchor).isActive = true
        nameHolderView.trailingAnchor.constraint(equalTo: heroImage.trailingAnchor).isActive = true
        nameHolderView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        nameHolderView.bottomAnchor.constraint(equalTo: heroImage.bottomAnchor).isActive = true
        
        nameHolderView.addSubview(name)
        name.leadingAnchor.constraint(equalTo: nameHolderView.leadingAnchor, constant: 20).isActive = true
        name.trailingAnchor.constraint(equalTo: nameHolderView.trailingAnchor, constant: -20).isActive = true
        name.centerYAnchor.constraint(equalTo: nameHolderView.centerYAnchor).isActive = true
        
    }
    
    func setData(comic: Comic?){
        name.text = comic?.title
        activityIndicator.displayActivity(view: contentView)
        activityIndicator.startAanimating()
        guard let path = comic?.fallbackCover?.first?.path, let ext = comic?.fallbackCover?.first?.fileExtension else {
            heroImage.image = UIImage(named: "PlaceHolder".lowercased())
            activityIndicator.stopAnimating()
            return
        }
        let url = path + "." + ext
        heroImage.sd_setImage(with: URL(string: url), placeholderImage: nil, options: .continueInBackground) { (image, error, cache, url) in
            self.activityIndicator.stopAnimating()
        }
    }
}
