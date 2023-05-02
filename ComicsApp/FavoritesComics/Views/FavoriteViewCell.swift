//
//  FavoriteViewCell.swift
//  ComicsApp
//
//  Created by Celso Lima on 02/05/23.
//

import UIKit

class FavoriteViewCell : UITableViewCell {
    static let identifier = "FavoriteViewCell"
    
    private(set) lazy var profileHolderView: UIView = {
        let holder = UIView()
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.clipsToBounds = true
        holder.applyShadow(shadowColour: .black)
        return holder
    }()
    
    private(set) lazy var comicImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.clipsToBounds = true
        return profileImage
    }()
    
    private(set) lazy var comicTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont(name: heroFontName, size: 30)
        return label
    }()
    
    private(set) lazy var comicPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private(set) lazy var comicQuantity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        layoutTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    fileprivate func layoutTableViewCell(){
        
        contentView.addSubview(comicTitle)
        contentView.addSubview(profileHolderView)
        profileHolderView.addSubview(comicImage)
        profileHolderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        profileHolderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        profileHolderView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        profileHolderView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        comicImage.leadingAnchor.constraint(equalTo: profileHolderView.leadingAnchor).isActive = true
        comicImage.topAnchor.constraint(equalTo: profileHolderView.topAnchor).isActive = true
        comicImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        comicImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        var height = comicTitle.constraints.filter{$0.firstAttribute == .height}.first?.constant ?? 60
        height = height / 2
        comicTitle.leadingAnchor.constraint(equalTo: profileHolderView.trailingAnchor, constant: 10).isActive = true
        comicTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        comicTitle.centerYAnchor.constraint(equalTo: profileHolderView.centerYAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: comicTitle.bottomAnchor, constant: height + 20).isActive = true
        
    }
    
}
