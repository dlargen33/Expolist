//
//  LocationsViewController.swift
//  Expolist
//
//  Created by Donald Largen on 5/1/24.
//

import UIKit
import MapKit
import CoreLocation
import Combine

class LocationsViewController: UIViewController, Reusable {

    @IBOutlet weak var mapView: MKMapView!
    private let viewModel = LocationsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    class func get() -> LocationsViewController {
        return LocationsViewController.fromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.load()
    }
    
    private func setupUI() {
        self.title = "Nearby Stores"
        self.mapView.showsUserLocation = true
    }
    
    private func bind() {
        viewModel.locationsSubject.sink { [weak self] completion in
            guard let self else { return }
            if case .failure(let error) = completion {
                self.alert(message: "\(error)")
            }
        } receiveValue: { [weak self] (region,annotations) in
            guard let self else { return }
            DispatchQueue.main.async {
                self.mapView.setRegion(region, animated: true)
                self.mapView.addAnnotations(annotations)
            }
        }.store(in: &cancellables)
    }
}

extension LocationsViewController: MKMapViewDelegate {
    
}
