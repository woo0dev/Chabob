//
//  LocationService.swift
//  Chabob
//
//  Created by woo0 on 2023/08/03.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
	private let manager = CLLocationManager()

	override init() {
		super.init()
		manager.delegate = self
		manager.requestWhenInUseAuthorization()
	}
	
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		switch manager.authorizationStatus {
		case .authorizedAlways, .authorizedWhenInUse:
			manager.startUpdatingLocation()
		case .notDetermined, .denied, .restricted:
			manager.requestWhenInUseAuthorization()
		default:
			print("Error")
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error)
	}
	
	func fetchUserLocation() -> CLLocation {
		if let location = manager.location {
			return location
		} else {
			return CLLocation(latitude: 37.359600825024025, longitude: 127.1050730428666)
		}
	}
}
