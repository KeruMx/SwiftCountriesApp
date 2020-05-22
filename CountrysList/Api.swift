//
//  Api.swift
//  CountrysList
//
//  Created by Emmanuel Anaya on 21/05/20.
//  Copyright © 2020 Emmanuel Anaya. All rights reserved.
//

import Foundation
struct Country: Codable, Identifiable{
    let id = UUID()
    var name: String
    var flag: String
    
}
class Api{
    func getCountry(completion: @escaping ([Country]) -> ()){
        guard let url = URL(string: "https://restcountries.eu/rest/v2/all") else { return }
        URLSession.shared.dataTask(with: url){ (data,_,_) in
            let countries = try! JSONDecoder().decode([Country].self, from: data!)
            DispatchQueue.main.async {
                completion(countries)

            }
        }
    .resume()
    }
}
