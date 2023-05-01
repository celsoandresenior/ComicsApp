//
//  ComicDetailTableViewDataSource.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import UIKit


class ComicDetailTableViewDataSource: NSObject, UITableViewDataSource{
    
    var updateUI:(()-> Void)?
    var comic: Comic?
    var buttonsTableViewDelegate: ButtonsTableViewDelegate?
    
    let sections = [
        "CharacterHeader",
        "CharacterDescriptionCell",
        "ComicPriceTableViewCell",
        "CharacterComics"
    ]
    
    
    func fetchDataFromSelectedArray(comic: Comic?){
        self.comic = comic
        updateUI?()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: ComicHeaderTableViewCell.identifier, for: indexPath) as! ComicHeaderTableViewCell
            let imagePath = "\(comic?.cover?.path ?? "").\(comic?.cover?.fileExtension ?? "")"
            cell.profileImage.sd_setImage(with: URL(string: imagePath), completed: nil)
            cell.nameOfHero.text = comic?.title
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: ComicDescriptionTableViewCell.identifier, for: indexPath) as! ComicDescriptionTableViewCell
            if comic?.description == ""{
                cell.descriptionLabel.text = "Sem descrição."
            }else{
                cell.descriptionLabel.text = comic?.description
            }
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: ComicPriceTableViewCell.identifier, for: indexPath) as! ComicPriceTableViewCell
            cell.priceLabel.text = "Valor não esta disponível."
            if let price = comic?.prices?.first?.price, !price.isZero {
                cell.priceLabel.text = "$ \(price)"
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: ComicButtonsTableViewCell.identifier, for: indexPath) as! ComicButtonsTableViewCell
            cell.isHidden = !(comic?.isPriceValid ?? true)
            cell.delegate = buttonsTableViewDelegate
            return cell
        }
    }
}
