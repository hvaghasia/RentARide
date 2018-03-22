//
//  MakersMapViewModel.swift
//  RideCellAssignment
//
//  Created by Hardik on 22/03/18.
//  Copyright © 2018 Ugam. All rights reserved.
//

import Foundation

final class MakersMapViewModel {
    
    var vehicleRootObject: VehicleRoot?
    var parsingCompletionBlock: (VehicleRoot?, Error?) -> Void
    
    init(parsingCompletionBlock: @escaping (VehicleRoot?, Error?) -> Void) {
        self.parsingCompletionBlock = parsingCompletionBlock
        self.parseJSON()
    }
    
    fileprivate func parseJSON() {
        JSONParser<VehicleRoot>.parse(fileName: "vehicles") { [weak self] (vehicleRoot, error) in
            self?.vehicleRootObject = vehicleRoot
            self?.parsingCompletionBlock(vehicleRoot, error)
        }
    }
}

