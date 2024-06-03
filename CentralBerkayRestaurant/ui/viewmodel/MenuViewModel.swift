//
//  MenuViewModel.swift
//  CentralBerkayRestaurant
//
//  Created by Berkay Özbaba on 22.05.2024.
//

import Foundation

class MenuViewModel {
    var foods: [Food] = []
    var repository = FoodRepository()

    func loadFoods(completion: @escaping () -> Void) {
        repository.fetchAllFoods { [weak self] foods in
            DispatchQueue.main.async {
                self?.foods = foods
                completion()
            }
        }
    }
    

}
