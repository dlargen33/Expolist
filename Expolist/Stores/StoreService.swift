//
//  StoreService.swift
//  Expolist
//
//  Created by Donald Largen on 5/1/24.
//

import Foundation
import CoreLocation
import MapKit
import Combine

class StoreService: NSObject {
    struct FetchResult {
        var currentRegion: MKCoordinateRegion
        var storeLocations: [MKMapItem]
    }
    
    private var locationManager = CLLocationManager()
    
    enum StoreServiceError: Error {
        case missingResponse
        case missingLocation
        case noLocationsFound
        case serviceFailure
    }
    
    var fetchSubject = PassthroughSubject<FetchResult, Error> ()
    
    func fetchStoresNearBy() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension StoreService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        if let userLocation = locations.last {
            let viewRegion = MKCoordinateRegion(center: userLocation.coordinate,
                                                latitudinalMeters: 8046.72,
                                                longitudinalMeters: 8046.72)
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = "Grocery Stores"
            request.region = viewRegion

            let search = MKLocalSearch(request: request)
                search.start(completionHandler: {[weak self] (response, error) in
                    guard let self else { return }
                    
                    guard let response else {
                        self.fetchSubject.send(completion: .failure(StoreServiceError.missingResponse))
                        return
                    }
                    
                    if let error {
                        print("Error occured in search:\(error.localizedDescription)")
                        self.fetchSubject.send(completion: .failure(error))
                        return
                    }
                    
                    guard response.mapItems.count > 0 else {
                        self.fetchSubject.send(completion: .failure(StoreServiceError.noLocationsFound))
                        return
                    }
                  
                    self.fetchSubject.send(FetchResult(currentRegion: viewRegion,
                                                       storeLocations: response.mapItems))
                })
        }
    }
    
}
