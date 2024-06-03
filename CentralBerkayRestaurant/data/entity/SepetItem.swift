//
//  SepetItem.swift
//  CentralBerkayRestaurant
//
//  Created by Berkay Özbaba on 23.05.2024.
//

import Foundation


struct SepetItem: Codable {
    let yemek_adi: String
    let yemek_resim_adi: String
    let yemek_fiyat: Int
    let yemek_siparis_adet: Int
    let kullanici_adi: String
}
