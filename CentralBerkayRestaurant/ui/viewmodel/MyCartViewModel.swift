//
//  MyCartViewModel.swift
//  CentralBerkayRestaurant
//
//  Created by Berkay Özbaba on 24.05.2024.
//

import Foundation


class MyCartViewModel {
    var cartItems: [CartItem] = []
    var repository = FoodRepository()

    func loadCartItems(forUser username: String, completion: @escaping () -> Void) {
        repository.fetchCartItems(forUser: username) { cartResponse in
            if let cartItems = cartResponse?.sepet_yemekler, cartResponse?.success == 1 {
                self.cartItems = cartItems
            } else {
                self.cartItems = []
            }
        completion()
        }
    }
    
    
    func removeItemFromCart(sepetYemekId: Int, kullaniciAdi: String, completion: @escaping (Bool, String) -> Void) {
           repository.removeFromCart(sepetYemekId: sepetYemekId, kullaniciAdi: kullaniciAdi, completion: completion)
       }
}
