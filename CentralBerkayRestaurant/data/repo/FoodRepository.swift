//
//  FoodRepository.swift
//  CentralBerkayRestaurant
//
//  Created by Berkay Özbaba on 22.05.2024.
//

import Foundation

class FoodRepository {
    let baseUrl = "http://kasimadalan.pe.hu/yemekler/"

    func fetchAllFoods(completion: @escaping ([Food]) -> Void) {
        let url = URL(string: "\(baseUrl)tumYemekleriGetir.php")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("API Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error: Invalid response or data")
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }

            do {
                let jsonResult = try JSONDecoder().decode(FoodResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(jsonResult.yemekler)
                }
            } catch {
                print("Decoding Error: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
    
    
    func addFoodToCart(sepetItem: SepetItem, completion: @escaping (Bool, String) -> Void) {
        let url = URL(string: "\(baseUrl)sepeteYemekEkle.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let body = "yemek_adi=\(sepetItem.yemek_adi)&yemek_resim_adi=\(sepetItem.yemek_resim_adi)&yemek_fiyat=\(sepetItem.yemek_fiyat)&yemek_siparis_adet=\(sepetItem.yemek_siparis_adet)&kullanici_adi=\(sepetItem.kullanici_adi)"

        
            request.httpBody = body.data(using: .utf8)
       

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(false, "Network error: \(error.localizedDescription)")
                }
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(false, "Error: Invalid response or data")
                }
                return
            }

            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let success = jsonResult["success"] as? Int {
                    let message = jsonResult["message"] as? String ?? "No message"
                    DispatchQueue.main.async {
                        completion(success == 1, message)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false, "Error parsing JSON")
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(false, "JSON Decoding Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }

    
    
    func fetchCartItems(forUser username: String, completion: @escaping (CartItemResponse?) -> Void) {
        let url = URL(string: "\(baseUrl)sepettekiYemekleriGetir.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let body = "kullanici_adi=\(username)"
        request.httpBody = body.data(using: .utf8)
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error: Invalid response or no data")
                completion(nil)
                return
            }

            do {
                let cartResponse = try JSONDecoder().decode(CartItemResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(cartResponse)
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }

    
    func removeFromCart(sepetYemekId: Int, kullaniciAdi: String, completion: @escaping (Bool, String) -> Void) {
        let url = URL(string: "\(baseUrl)sepettenYemekSil.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = "sepet_yemek_id=\(sepetYemekId)&kullanici_adi=\(kullaniciAdi)"
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(false, "Network error: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(false, "Error: Invalid response or no data")
                }
                return
            }
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let success = jsonResult["success"] as? Int,
                   let message = jsonResult["message"] as? String {
                    DispatchQueue.main.async {
                        completion(success == 1, message)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false, "Error parsing JSON")
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(false, "JSON Decoding Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }





}

