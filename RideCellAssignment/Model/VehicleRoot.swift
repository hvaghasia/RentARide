//
//  VehicleRoot.swift
//  RideCellAssignment
//
//  Created by Hardik on 22/03/18.
//  Copyright © 2018 Ugam. All rights reserved.
//

import Foundation

typealias ResponseDictionary = [String: Any]


protocol JSONDecodable {
    init?(json: ResponseDictionary)
}


public struct VehicleRoot: JSONDecodable {
    var vehicleDict: [String: Vehicle]
    
    init(json: ResponseDictionary) {
        
        var parsedVehicleDict = [String: Vehicle]()
        for vehicleObject in json {
            let vehicle = Vehicle(json: vehicleObject.value as! ResponseDictionary)
            parsedVehicleDict[vehicleObject.key] = vehicle
        }
        self.vehicleDict = parsedVehicleDict
    }
    
    var sanFranciscoVehicle: Vehicle? {
        return vehicleDict.first { $0.value.shortDisplayAddress.contains("San Francisco") }?.value
    }
}
