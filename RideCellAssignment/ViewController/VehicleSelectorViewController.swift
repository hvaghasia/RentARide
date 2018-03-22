//
//  VehicleSelectorViewController.swift
//  RideCellAssignment
//
//  Created by Hardik on 22/03/18.
//  Copyright © 2018 Ugam. All rights reserved.
//

import Foundation
import UIKit

final class VehicleSelectorViewController: UIViewController {
    
    var selectedVehicle: Vehicle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    private func setupUI() {
        guard let vehicle = self.selectedVehicle else { return }
        let selectorView = SelectVehicleView.fromNib()
        selectorView.viewModel = SelectVehicleViewViewModel(vehicle: vehicle)
        self.view.addSubview(selectorView)
        
        selectorView.translatesAutoresizingMaskIntoConstraints = false
        selectorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        selectorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        selectorView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        selectorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
