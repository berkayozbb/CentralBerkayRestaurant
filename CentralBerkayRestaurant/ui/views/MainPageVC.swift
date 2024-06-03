//
//  ViewController.swift
//  CentralBerkayRestaurant
//
//  Created by Berkay Özbaba on 19.05.2024.
//

import UIKit
import Hero

class MainPageVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    
    var viewModel: MenuViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MenuViewModel()
        viewModel.loadFoods {
            self.collectionView.reloadData()
        }
            
        //Header
        setupHeaderBackground(headerTitle: "Menü", titleColor: .tintColor)
        
        //Tabbar
        if let tabBarController = self.tabBarController {
            
            //Tabbar başlıklarının rengini ayarlama
            let normalAppearance = UITabBarItemAppearance()
            normalAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
            
            let selectedAppearance = UITabBarItemAppearance()
            selectedAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
            let appearance = UITabBarAppearance()
            appearance.stackedLayoutAppearance = normalAppearance
            appearance.stackedLayoutAppearance = selectedAppearance
            
            tabBarController.tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tabBarController.tabBar.scrollEdgeAppearance = appearance
            }
            
            //Tabbar gölgelendirme
            tabBarController.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            tabBarController.tabBar.layer.shadowRadius = 50
            tabBarController.tabBar.layer.shadowColor = UIColor.black.cgColor
            tabBarController.tabBar.layer.shadowOpacity = 0.75
        }
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 16, right: 8)
        design.minimumInteritemSpacing = 8
        design.minimumLineSpacing = 20
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 72) / 2
        
        design.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.7)
        collectionView.collectionViewLayout = design
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of items: \(viewModel.foods.count)")
        return viewModel.foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainPageCollectionViewCell", for: indexPath) as? MainPageCollectionViewCell else {
                fatalError("Unable to dequeue MainPageCollectionViewCell")
            }
            let food = viewModel.foods[indexPath.row]
            cell.configure(with: food)
        // Çerçeve ayarları
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10.0  // Hücre köşelerini yuvarlak yap

        // Gölgelendirme ayarları
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 1, height: 2) // Gölgelendirmenin yönü ve büyüklüğü
        cell.layer.shadowRadius = 3.0  // Gölgelendirme yayılma yarıçapı
        cell.layer.shadowOpacity = 0.15  // Gölgelendirme yoğunluğu
        cell.layer.masksToBounds = false  // Gölgelendirme için gerekli
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.layer.cornerRadius).cgPath
        
        cell.backgroundColor = UIColor.white
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 1) {
                cell.transform = CGAffineTransform.identity
            }

         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    
    
}

