//
//  SelectVehicleView.swift
//  RideCellAssignment
//
//  Created by Hardik on 22/03/18.
//  Copyright © 2018 Ugam. All rights reserved.
//

import UIKit

class SelectVehicleView: UIView {
    
    @IBOutlet weak var fuelPercentageLabel: UILabel!
    @IBOutlet weak var carMakeLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var reserveCarButton: UIButton!
    
    var viewModel: SelectVehicleViewViewModel? {
        didSet {
            guard let vm = viewModel else { return }
            self.fuelPercentageLabel.text = vm.fuelPercentageString
            self.carMakeLabel.text = vm.makerNameString
            
            carImageView.downloaded(from: vm.vehicleImageUrl)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        reserveCarButton.addBorder()
        reserveCarButton.addRoundedCorners(withRadius: 10)
    }
}
