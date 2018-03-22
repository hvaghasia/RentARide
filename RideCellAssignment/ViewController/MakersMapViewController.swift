//
//  MakersMapViewController.swift
//  RideCellAssignment
//
//  Created by Hardik on 22/03/18.
//  Copyright © 2018 Ugam. All rights reserved.
//

import UIKit
import MapKit

class MakersMapViewController: UIViewController, AlertViewPresentable {

    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    var viewModel: MakersMapViewModel?
    
    var addSearchTransitionManager = TransitionManager()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = MakersMapViewModel(parsingCompletionBlock: { [weak self] (vehicleRoot, error) in
            
            DispatchQueue.main.async {
                if let err = error {
                    let errorOption = ErrorOptions(message: err.localizedDescription)
                    self?.presentError(errorOption: errorOption)
                    return
                }
                self?.setupMapView()
            }
        })
    }

    private func setupMapView() {
        guard let vm = self.viewModel else { return }
        guard let sanfranciscoVehicle = vm.vehicleRootObject?.sanFranciscoVehicle else { return }

        // Get San Francisco vehicle location and zoom on it initially
        let locationCoordinates = CLLocationCoordinate2D(latitude: sanfranciscoVehicle.latitude,
                                              longitude: sanfranciscoVehicle.longitude)
        
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(locationCoordinates,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        // Add other vehicles on map view
        self.addAnnotations()
    }

    
    private func addAnnotations() {
        guard let vm = self.viewModel else { return }
        guard let vehicleDict = vm.vehicleRootObject?.vehicleDict else { return }
        
        for vehicleObject in vehicleDict {
            let vehicle = vehicleObject.value
            print("vehicle : \(vehicle)")
            let location = CLLocationCoordinate2D(latitude: vehicle.latitude,
                                                  longitude: vehicle.longitude)

            let makerAnnotation = VehicleMakerAnnotation(title: vehicle.makerName,
                                                         locationName: "",
                                                         discipline: "",
                                                         coordinate: location,
                                                         vehicle: vehicle)
            mapView.addAnnotation(makerAnnotation)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func select(vehicle: Vehicle) {
        let vehicleSelectorViewController = UIStoryboard.initialize(type: VehicleSelectorViewController.self, fromStoryboard: "Main")
        vehicleSelectorViewController.transitioningDelegate = addSearchTransitionManager
        vehicleSelectorViewController.modalPresentationStyle = .custom
        vehicleSelectorViewController.selectedVehicle = vehicle
        self.present(vehicleSelectorViewController, animated: true, completion: nil)
    }
}

// MARK: - MapView delegate
extension MakersMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? VehicleMakerAnnotation else { return nil }
        let identifier = "makers"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? VehicleMakerAnnotation else { return }

        self.select(vehicle: annotation.vehicle)
    }
}

