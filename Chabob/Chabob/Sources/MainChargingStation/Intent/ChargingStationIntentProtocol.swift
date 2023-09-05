//
//  ChargingStationIntentProtocol.swift
//  Chabob
//
//  Created by woo0 on 2023/08/01.
//

import SwiftUI

protocol ChargingStationIntentProtocol {
	func viewOnAppear()
	func viewOnDisappear()
	func updateCameraPosition(_ chargingStations: [ChargingStation], _ maxLat: Double, _ minLat: Double, _ maxLng: Double, _ minLng: Double)
}
