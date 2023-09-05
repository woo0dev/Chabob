//
//  MapView.swift
//  Chabob
//
//  Created by woo0 on 2023/07/19.
//

import SwiftUI

struct UIMapView: UIViewControllerRepresentable {
	var container: MVIContainer<ChargingStationIntentProtocol, ChargingStationModelProtocol>
	var chargingStations: [ChargingStation]
	
	private var intent: ChargingStationIntentProtocol { container.intent }
	private var model: ChargingStationModelProtocol { container.model }
	
	func makeUIViewController(context: Context) -> UIViewController {
		return UIMapViewController(container: container, chargingStations: chargingStations)
	}
	
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
		if let viewController = uiViewController as? UIMapViewController {
			viewController.updateMapMarkers()
		}
	}
}
