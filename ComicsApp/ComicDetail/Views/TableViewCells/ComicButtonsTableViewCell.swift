//
//  ComicButtonsTableViewCell.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import UIKit

class ComicButtonsTableViewCell: UITableViewCell {
    static let identifier = "ComicButtonsTableViewCell"
    var delegate: ButtonsTableViewDelegate?
    
    var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Adicionar ao carrinho de compras", for: .normal)
        button.titleLabel?.font = UIFont(name: heroFontName, size: 20)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(addComic), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.darkGray.cgColor
        
        return button
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
    
    //MARK:- Layout
    fileprivate func displayLayout(){
        
        contentView.addSubview(buyButton)
        buyButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        buyButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
    
}

extension ComicButtonsTableViewCell {
    
    @objc func addComic() {
        self.delegate?.save()
        self.buyButton.isUserInteractionEnabled = false
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in
            self.buyButton.isUserInteractionEnabled = true
        })
       
    }
}
