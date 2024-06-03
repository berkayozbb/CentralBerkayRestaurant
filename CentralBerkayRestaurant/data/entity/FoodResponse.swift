//
//  FoodResponse.swift
//  CentralBerkayRestaurant
//
//  Created by Berkay Özbaba on 22.05.2024.
//

import Foundation


struct FoodResponse: Codable {
    let yemekler: [Food]
    let success: Int
}
