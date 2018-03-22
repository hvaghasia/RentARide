//
//  JSONParser.swift
//  RideCellAssignment
//
//  Created by Hardik on 22/03/18.
//  Copyright © 2018 Ugam. All rights reserved.
//

import Foundation

final class JSONParser<T: JSONDecodable> {
    
    static func parse(fileName: String, completion: @escaping (T?, Error?) -> Void)  {
        DispatchQueue.global().async {
            let url = Bundle.main.url(forResource: fileName, withExtension: "json")
            
            do {
                let jsonData = try Data(contentsOf: url!)
                let vehiclesJsonObject = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments)
                
                let vehicleRoot = T(json: vehiclesJsonObject as! [String : Any])
                completion(vehicleRoot, nil)
                
            } catch {
                print("Json parsing Error : \(error)")
                completion(nil, error)
            }
        }
    }
}
