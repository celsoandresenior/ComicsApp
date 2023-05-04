//
//  ComicsCollectionViewCell.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//


import UIKit

class ComicsCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: ComicsCollectionViewCell.self)
    var activityIndicator = ActivityIndicator()
    private var isFavorite: Bool = false
    var delegate: ComicsCollectionCellDelegate?
    var id: Int = 0
    
    
    private(set) lazy var comicImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 15
        return image
    }()
    
    private(set) lazy var comicHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var comicName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: heroFontName, size: 40)
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImageView(image: UIImage(named: "favorito")?.withRenderingMode(.alwaysTemplate))
        button.setImage(image.image, for: .normal)
        button.tintColor = .green
        button.addTarget(self, action: #selector(setFavorite), for: .touchUpInside)
        return button
    }()
    
    // MARK: layoutSubviews
    override func layoutSubviews() {
        self.applyShadow(shadowColour: .black)
        contentView.addSubview(comicImage)
        comicImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        comicImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        comicImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        comicImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        comicImage.addSubview(comicHolderView)
        comicHolderView.leadingAnchor.constraint(equalTo: comicImage.leadingAnchor).isActive = true
        comicHolderView.trailingAnchor.constraint(equalTo: comicImage.trailingAnchor).isActive = true
        comicHolderView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        comicHolderView.bottomAnchor.constraint(equalTo: comicImage.bottomAnchor).isActive = true
        
        comicImage.addSubview(comicName)
        comicName.leadingAnchor.constraint(equalTo: comicHolderView.leadingAnchor, constant: 20).isActive = true
        comicName.trailingAnchor.constraint(equalTo: comicHolderView.trailingAnchor, constant: -20).isActive = true
        comicName.centerYAnchor.constraint(equalTo: comicHolderView.centerYAnchor).isActive = true
        
        comicImage.addSubview(favoriteButton)
        favoriteButton.topAnchor.constraint(equalTo: comicImage.topAnchor, constant: 0).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: comicImage.trailingAnchor, constant: 0).isActive = true
        
    }
    
    // MARK: prepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        let image =  UIImageView(image: UIImage(named: "favorito")?.withRenderingMode(.alwaysTemplate))
        self.favoriteButton.setImage(image.image, for: .normal)
        self.favoriteButton.tintColor = .green
    }
    
    // MARK: setData
    func setData(comic: Comic?, isFavorite: Bool){
        self.id = comic?.id ?? 0
        self.isFavorite = isFavorite
        self.setIconFavorite(isFavorite)
        comicName.text = comic?.title
        activityIndicator.displayActivity(view: contentView)
        activityIndicator.startAanimating()
        guard let path = comic?.fallbackCover?.first?.path, let ext = comic?.fallbackCover?.first?.fileExtension else {
            comicImage.image = UIImage(named: "PlaceHolder".lowercased())
            activityIndicator.stopAnimating()
            return
        }
        let url = path + "." + ext
        comicImage.sd_setImage(with: URL(string: url), placeholderImage: nil, options: .continueInBackground) { (image, error, cache, url) in
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: setFavorite
    @objc func setFavorite() {
        isFavorite.toggle()
        self.setIconFavorite(isFavorite)
        self.delegate?.saveFavorite(id: id)
    }
    
    // MARK: setIconFavorite
    private func setIconFavorite(_ value: Bool) {
        let keyImage: String = value ? "favorito-clicked" : "favorito"
        let image =  UIImageView(image: UIImage(named: keyImage)?.withRenderingMode(.alwaysTemplate))
        self.favoriteButton.setImage(image.image, for: .normal)
        self.favoriteButton.tintColor = value ? .red : .green
    }
}
