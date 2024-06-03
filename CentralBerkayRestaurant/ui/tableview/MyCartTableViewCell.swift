//
//  MyCartTableViewCell.swift
//  CentralBerkayRestaurant
//
//  Created by Berkay Özbaba on 24.05.2024.
//

import UIKit

class MyCartTableViewCell: UITableViewCell {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with food: CartItem) {
        productNameLabel.text = food.yemek_adi
        priceLabel.text = "Fiyat: \(food.yemek_fiyat) ₺"
        quantityLabel.text = "Adet: \(food.yemek_siparis_adet)"
        totalPriceLabel.text = "\(Int(food.yemek_fiyat)! * Int(food.yemek_siparis_adet)!) ₺"
           
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi)") {
            productImageView.kf.setImage(with: url)
           }
       }

    @IBAction func deleteButtonClicked(_ sender: Any) {
    }
    
}
