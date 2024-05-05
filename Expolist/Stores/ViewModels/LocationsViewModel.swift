//
//  LocationsViewModel.swift
//  Expolist
//
//  Created by Donald Largen on 5/1/24.
//

import Foundation
import Combine
import MapKit

class LocationsViewModel {
    
    private let storeService = StoreService()
    private var cancellables = Set<AnyCancellable>()
    
    var locationsSubject = PassthroughSubject< (MKCoordinateRegion, [MKAnnotation]), Error>()
    
    init() {
        setup()
    }
    
    func load() {
        storeService.fetchStoresNearBy()
    }
    
    private func setup() {
        storeService.fetchSubject.sink { [weak self] completion in
            guard let self else { return }
            if case .failure(let error) = completion {
                self.locationsSubject.send(completion: .failure(error))
            }
        } receiveValue: { [weak self] fetchResult in
            guard let self else { return }
            let annotations = fetchResult.storeLocations.map { mapItem in
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                return annotation
            }
            self.locationsSubject.send((fetchResult.currentRegion,annotations))
        }.store(in: &cancellables)
    }
}
