//
//  StationSearchModel.swift
//  Chabob
//
//  Created by woo0 on 1/12/24.
//

import SwiftUI
import Combine
import CoreLocation

final class StationSearchModel: ObservableObject, StationSearchModelProtocol {
	@Published var stations: [ChargingStation]
	@Published var filteredStations: [ChargingStation]
	@Published var userLocation: CLLocationCoordinate2D
	
	init(stations: [ChargingStation], userLocation: CLLocationCoordinate2D) {
		self.stations = stations
		self.filteredStations = stations
		self.userLocation = userLocation
	}
	
	func filterStations(searchQuery: String) {
		if searchQuery.isEmpty {
			filteredStations = stations
		} else {
			filteredStations = stations.filter { $0.csNm.localizedStandardContains(searchQuery) }.sorted {
				(abs(Double().toLatitude($0.lat) - userLocation.latitude), abs(Double().toLatitude($0.longi) - userLocation.longitude)) < (abs(Double().toLatitude($1.lat) - userLocation.latitude), abs(Double().toLongitude($1.longi) - userLocation.longitude))
			}
			
		}
	}
}
