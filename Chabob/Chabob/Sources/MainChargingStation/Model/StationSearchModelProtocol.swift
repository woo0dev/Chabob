//
//  StationSearchModelProtocol.swift
//  Chabob
//
//  Created by woo0 on 1/12/24.
//

import Foundation

protocol StationSearchModelProtocol {
	var stations: [ChargingStation] { get }
	var filteredStations: [ChargingStation] { get }
	func filterStations(searchQuery: String)
}
