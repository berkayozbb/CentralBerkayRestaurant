//
//  CartItemResponse.swift
//  CentralBerkayRestaurant
//
//  Created by Berkay Özbaba on 24.05.2024.
//

import Foundation


struct CartItemResponse: Codable {
    let sepet_yemekler: [CartItem]
    let success: Int
}
