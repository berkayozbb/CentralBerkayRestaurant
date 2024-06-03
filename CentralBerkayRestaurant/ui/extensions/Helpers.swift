//
//  Helpers.swift
//  CentralBerkayRestaurant
//
//  Created by Berkay Özbaba on 22.05.2024.
//

import Foundation
import UIKit

extension MainPageVC{
    
    
    override func viewWillAppear(_ animated: Bool) {
        //Tabbar arkaplan rengi ayarlama
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.backgroundColor = UIColor.tintColor
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let destinationVC = segue.destination as? ProductDetailVC,
               let indexPath = sender as? IndexPath {
                destinationVC.food = viewModel.foods[indexPath.row]
            }
        }
    }

}



extension ProductDetailVC{
    
     func updateUI() {
            guard let food = food else { return }
        nameLabel.text = food.yemek_adi
        priceLabel.text = "\(food.yemek_fiyat) ₺"
            if let imageUrl = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi)") {
                imageView.kf.setImage(with: imageUrl)
            }
            quantityLabel.text = "1"
            stepper.value = 1
        }
}



extension MyCartVC{
    
    override func viewWillAppear(_ animated: Bool) {
        //Tabbar arkaplan rengi ayarlama
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.backgroundColor = UIColor.orange
        }
        loadCartItems()
        tableView.reloadData()
    }
   
}



extension MyProfileVC{
    
    override func viewWillAppear(_ animated: Bool) {
        //Tabbar arkaplan rengi ayarlama
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.backgroundColor = UIColor.darkGray
        }
    }
}


extension UIViewController{
    
    func setupHeaderBackground(headerTitle: String, titleColor: UIColor) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        imageView.image = UIImage(named: "header")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        //Header gradient
        let gradient = CAGradientLayer()
        gradient.frame = imageView.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.4)

        imageView.layer.mask = gradient
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        titleLabel.text = headerTitle
        titleLabel.backgroundColor = .lightText
        titleLabel.textAlignment = .center
        titleLabel.textColor = titleColor
        titleLabel.font = UIFont.monospacedSystemFont(ofSize: 24, weight: .black)
        view.addSubview(titleLabel)
        titleLabel.center = CGPoint(x: imageView.center.x, y: imageView.center.y)
    }
}


