//
//  SelectVehicleViewModel.swift
//  RideCellAssignment
//
//  Created by Hardik on 22/03/18.
//  Copyright © 2018 Ugam. All rights reserved.
//

import Foundation

final class SelectVehicleViewViewModel {
    
    var fuelPercentageString: String
    var makerNameString: String
    var vehicleImageUrl: String

    init(vehicle: Vehicle) {
        self.fuelPercentageString = "\(vehicle.fuelPercentage)"
        self.makerNameString = vehicle.makerName
        self.vehicleImageUrl = vehicle.vehiclePicAbsUrl
    }
}
