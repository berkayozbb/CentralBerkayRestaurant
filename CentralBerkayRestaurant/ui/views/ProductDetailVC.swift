//
//  ProductDetailVC.swift
//  CentralBerkayRestaurant
//
//  Created by Berkay Özbaba on 19.05.2024.
//

import UIKit

class ProductDetailVC: UIViewController {
    var food: Food?
    var quantity: Int = 1
    var viewModel = ProductDetailViewModel()
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var stepper: UIStepper!
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var totalPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(food!.yemek_adi)
        setupHeaderBackground(headerTitle: "Ürün Detayı", titleColor: .purple)
        updateUI()
        let number = Int(stepper.value)
        if let price = Int(food!.yemek_fiyat){
            totalPriceLabel.text = "\(number * (price)) ₺"
        }
    }
    
    @IBAction func stepperClicked(_ sender: Any) {
        quantityLabel.text = "\(Int(stepper.value))"
        let number = Int(stepper.value)
        if let price = Int(food!.yemek_fiyat){
            totalPriceLabel.text = "\(number * (price)) ₺"
        }
    }
    
    @IBAction func addCartButtonClicked(_ sender: Any) {guard let food = food else { return }
        let sepetItem = SepetItem(yemek_adi: food.yemek_adi, yemek_resim_adi: food.yemek_resim_adi, yemek_fiyat: Int(food.yemek_fiyat)!, yemek_siparis_adet: Int(stepper.value), kullanici_adi: "berkayozbb")
        self.viewModel.addFoodToCart(sepetItem: sepetItem) { success, message in
            if success {
                print("Successfully added to cart")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Failed to add to cart: \(message)")
            }
        }
    }
}
