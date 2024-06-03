//
//  MainPageCollectionViewCell.swift
//  CentralBerkayRestaurant
//
//  Created by Berkay Özbaba on 22.05.2024.
//

import UIKit
import Kingfisher

class MainPageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    @IBAction func addCartButtonClicked(_ sender: Any) {
    }
    
    func configure(with food: Food) {
        titleLabel.text = food.yemek_adi
        priceLabel.text = "\(food.yemek_fiyat) ₺"
           
           // Resim URL'sini oluşturma ve yükleme
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi)") {
               imageView.kf.setImage(with: url)
           }
       }
}
