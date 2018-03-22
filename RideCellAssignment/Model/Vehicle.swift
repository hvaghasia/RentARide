//
//  Vehicle.swift
//  RideCellAssignment
//
//  Created by Hardik on 22/03/18.
//  Copyright © 2018 Ugam. All rights reserved.
//

import Foundation

struct Vehicle: JSONDecodable {
    
    var fuelPercentage: Double
    var latitude: Double
    var longitude: Double
    var shortDisplayAddress: String
    var vehiclePicUrl: String
    var vehiclePicAbsUrl: String
    var makerName: String
    
    init?(json: ResponseDictionary) {
        print("json : \(json)")
        guard let fuelPercentage = json[ResponseKeys.fuelPercentage] as? Double else { return nil }
        guard let vehicleType = json[ResponseKeys.vehicleType] as? String else { return nil }
        
        guard let gpsPositionDict = json[ResponseKeys.gpsLocation] as? ResponseDictionary else { return nil }
        guard let locationDictionary = gpsPositionDict[ResponseKeys.location] as? ResponseDictionary else { return nil }
        guard let lat = locationDictionary[ResponseKeys.latitude] as? Double else { return nil }
        guard let long = locationDictionary[ResponseKeys.longitude] as? Double else { return nil }
        guard let shortDisplayAddress = locationDictionary[ResponseKeys.shortDisplayAddress] as? String else { return nil }
        
        self.fuelPercentage = fuelPercentage
        self.vehiclePicUrl = json[ResponseKeys.vehiclePicUrl] as? String ?? ""
        self.vehiclePicAbsUrl = json[ResponseKeys.vehiclePicAbsUrl] as? String ?? ""
        self.makerName = vehicleType
        self.latitude = lat
        self.longitude = long
        self.shortDisplayAddress = shortDisplayAddress
    }
}

extension Vehicle {
    private struct ResponseKeys {
        static let fuelPercentage = "fuel_percentage"
        static let vehiclePicUrl = "vehicle_pic"
        static let vehiclePicAbsUrl = "vehicle_pic_absolute_url"
        static let vehicleType = "vehicle_type"
        static let gpsLocation = "gpsposition"
        static let location = "location"
        static let latitude = "lat"
        static let longitude = "lng"
        static let shortDisplayAddress = "short_display_address"
    }
}



//UNUSED
extension Vehicle: Decodable {
    enum RootKeys: String, CodingKey {
        case fuelPercentage = "fuel_percentage"
        case vehiclePicUrl = "vehicle_pic"
        case vehiclePicAbsUrl = "vehicle_pic_absolute_url"
        case vehicleType = "vehicle_type"
        case gpsLocation = "gpsposition"
    }
    
    enum GPSPositionKeys: String, CodingKey {
        case location = "location"
    }
    
    enum LocationKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
        case shortDisplayAddress = "short_display_address"
    }
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootKeys.self)
        self.fuelPercentage = try rootContainer.decode(Double.self, forKey: .fuelPercentage)
        self.vehiclePicUrl = try rootContainer.decode(String.self, forKey: .vehiclePicUrl)
        self.vehiclePicAbsUrl = try rootContainer.decode(String.self, forKey: .vehiclePicAbsUrl)
        self.makerName = try rootContainer.decode(String.self, forKey: .vehicleType)

        let gpsPositionContainer = try rootContainer.nestedContainer(keyedBy: GPSPositionKeys.self, forKey: .gpsLocation)
        
        let locationContainer = try gpsPositionContainer.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)

        self.latitude = try locationContainer.decode(Double.self, forKey: .latitude)
        self.longitude = try locationContainer.decode(Double.self, forKey: .longitude)
        self.shortDisplayAddress = try locationContainer.decode(String.self, forKey: .shortDisplayAddress)
    }
}

