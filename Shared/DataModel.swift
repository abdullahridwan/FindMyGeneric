//
//  DataModel.swift
//  GenericDrugFromBrandName
//
//  Created by Abdullah Ridwan on 6/13/21.
//

import Foundation

struct Meta: Codable{
    var disclaimer: String
    var terms: String
    var license: String
    var last_updated: String
}

struct Post: Codable, Identifiable{
    let id = UUID()
    let term: String
    let count: Int
}



struct CompleteLoad: Codable, Identifiable {
    let id = UUID()
    var meta: Meta
    var results: [Post]
}

class API {
    func getPosts(item: String, completion: @escaping(CompleteLoad) -> ()){
        //will change later
        print("Getting Posts... \(item)")
        let trimmed = item.trimmingCharacters(in: .whitespacesAndNewlines)
        let queryString = "https://api.fda.gov/drug/drugsfda.json?search=openfda.brand_name:\(trimmed)&count=openfda.generic_name.exact"
        let url = URL(string: queryString)
            //URLSession.shared.dataTask(
        if url != nil{
            URLSession.shared.dataTask(with: url!) { jsonData, urlresponse, error in
                
                
                //if status code is 200, proce
                if let httpResponse = urlresponse as? HTTPURLResponse {
                        print("statusCode: \(httpResponse.statusCode)")
                        if(httpResponse.statusCode == 200){
                            print("Getting data...")
                            let completeLoad = try! JSONDecoder().decode(CompleteLoad.self, from: jsonData!)
                            print("[DataModel.swift] Complete Load:  \(completeLoad)")
                            DispatchQueue.main.async{
                                completion(completeLoad)
                            }
                        }
                    }
                
            }
            .resume()
        }
    }
}

