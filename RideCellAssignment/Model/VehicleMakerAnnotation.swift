//
//  VehicleMakerAnnotation.swift
//  RideCellAssignment
//
//  Created by Hardik on 22/03/18.
//  Copyright © 2018 Ugam. All rights reserved.
//

import Foundation
import MapKit

class VehicleMakerAnnotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    let vehicle: Vehicle
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D, vehicle: Vehicle) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        self.vehicle = vehicle
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
