//
//  ProductDetailViewModel.swift
//  CentralBerkayRestaurant
//
//  Created by Berkay Özbaba on 23.05.2024.
//

import Foundation


class ProductDetailViewModel{
    var repository = FoodRepository()
    var cartViewModel = MyCartViewModel()

        func addFoodToCart(sepetItem: SepetItem, completion: @escaping (Bool, String) -> Void) {
            cartViewModel.loadCartItems(forUser: sepetItem.kullanici_adi) {
                if let existingIndex = self.cartViewModel.cartItems.firstIndex(where: { $0.yemek_adi == sepetItem.yemek_adi }) {
                    let existingItem = self.cartViewModel.cartItems[existingIndex]
                    let updatedQuantity = Int(existingItem.yemek_siparis_adet)! + sepetItem.yemek_siparis_adet
                    self.cartViewModel.removeItemFromCart(sepetYemekId: Int(existingItem.sepet_yemek_id)!, kullaniciAdi: sepetItem.kullanici_adi) { success, message in
                        if success {
                            // Eski ürün silindi, yeni miktarla ürünü ekle
                            let updatedItem = SepetItem(yemek_adi: sepetItem.yemek_adi, yemek_resim_adi: sepetItem.yemek_resim_adi, yemek_fiyat: sepetItem.yemek_fiyat, yemek_siparis_adet: updatedQuantity, kullanici_adi: sepetItem.kullanici_adi)
                            self.repository.addFoodToCart(sepetItem: updatedItem, completion: completion)
                        } else {
                            completion(false, "Ürün silinirken hata oluştu: \(message)")
                        }
                    }
                } else {
                    // Ürün sepette yok, doğrudan ekle
                    self.repository.addFoodToCart(sepetItem: sepetItem, completion: completion)
                }
            }
        }

    
}
