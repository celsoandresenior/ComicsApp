//
//  ComicPriceTableViewCell.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import UIKit

class ComicPriceTableViewCell: UITableViewCell {
    static let identifier = "ComicPriceTableViewCell"
    
    private(set) lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        displayLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK:- displayLayout
    fileprivate func displayLayout(){
        
        contentView.addSubview(priceLabel)
        priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        contentView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        
    }
}
