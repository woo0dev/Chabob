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
	private var userLat = Double()
	private var userLng = Double()

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
	
	func fetchUserLocation() -> CLLocationCoordinate2D {
		if let location = manager.location {
			self.userLat = Double(location.coordinate.latitude)
			self.userLng = Double(location.coordinate.longitude)
			return location.coordinate
		} else {
			return CLLocation(latitude: 37.359600825024025, longitude: 127.1050730428666).coordinate
		}
	}
	
	func updateUserLocation(_ lat: Double, _ lng: Double) -> Bool {
		if abs(self.userLat - lat) > 0.005 && abs(self.userLng - lng) > 0.005 {
			self.userLat = lat
			self.userLng = lng
			return true
		}
		return false
	}
}
