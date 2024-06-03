//
//  MyChartVC.swift
//  CentralBerkayRestaurant
//
//  Created by Berkay Özbaba on 19.05.2024.
//

import UIKit
import Hero

class MyCartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var emptyCartLabel: UILabel!
    var viewModel: MyCartViewModel!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MyCartViewModel()
        setupHeaderBackground(headerTitle: "Sepetim", titleColor: .orange)
        tableView.dataSource = self
        tableView.delegate = self
        loadCartItems()
    }
    
    
    func loadCartItems() {
         viewModel.loadCartItems(forUser: "berkayozbb") { 
             DispatchQueue.main.async {
             if self.viewModel.cartItems.isEmpty {
                 self.tableView.isHidden = true
                 self.emptyCartLabel.isHidden = false
                 self.emptyCartLabel.text = "Sepetiniz boş"
             } else {
                 self.tableView.isHidden = false
                 self.emptyCartLabel.isHidden = true
                 self.tableView.reloadData()
             }
         }
         }
     }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? MyCartTableViewCell else{
            fatalError("Unable to dequeue MyCartTableViewCell")
        }
        let cartItem = viewModel.cartItems[indexPath.row]
        cell.configure(with: cartItem)
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteProduct(_:)), for: .touchUpInside)
              return cell
    }
    
    @objc func deleteProduct(_ sender: UIButton) {
        let item = viewModel.cartItems[sender.tag]
            let alert = UIAlertController(title: "Ürünü Sil", message: "Sepetten bu ürünü silmek istediğinize emin misiniz?", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Evet", style: .destructive) { action in
                self.viewModel.removeItemFromCart(sepetYemekId: Int(item.sepet_yemek_id)!, kullaniciAdi: item.kullanici_adi) { success, message in
                    if success {
                        print("Successfully removed from cart")
                        DispatchQueue.main.async {
                            self.loadCartItems()  
                        }
                    } else {
                        print("Failed to remove from cart: \(message)")
                    }
                }
            }
            
            let cancelAction = UIAlertAction(title: "Hayır", style: .cancel, handler: nil)
            
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }


    
    
}
