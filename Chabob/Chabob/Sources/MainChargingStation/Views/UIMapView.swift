//
//  MapView.swift
//  Chabob
//
//  Created by woo0 on 2023/07/19.
//

import SwiftUI
import NMapsMap

struct UIMapView: UIViewRepresentable {
	var container: MVIContainer<ChargingStationIntentProtocol, ChargingStationModelProtocol>
	var chargingStation: [ChargingStation]
	
	private var intent: ChargingStationIntentProtocol { container.intent }
	private var model: ChargingStationModelProtocol { container.model }
	
	func makeUIView(context: Context) -> NMFNaverMapView {
		let userLocation = model.locationManager.fetchUserLocation()
		let view = NMFNaverMapView()
		view.showZoomControls = false
		view.mapView.positionMode = .direction
		view.mapView.zoomLevel = 13
		view.mapView.moveCamera(NMFCameraUpdate(scrollTo: NMGLatLng(lat: userLocation.latitude, lng: userLocation.longitude), zoomTo: 13))
		view.mapView.addCameraDelegate(delegate: context.coordinator)
		
		return view
	}
	
	func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
		switch self.container.model.contentState {
		case let .content(contents: _, markers: markers):
			markers.forEach {
				$0.mapView = uiView.mapView
			}
		default:
			break
		}
	}
	
	class Coordinator: NSObject, NMFMapViewTouchDelegate, NMFMapViewCameraDelegate, NMFMapViewOptionDelegate {
		var container: MVIContainer<ChargingStationIntentProtocol, ChargingStationModelProtocol>
		var chargingStations: [ChargingStation]
		
		init(container: MVIContainer<ChargingStationIntentProtocol, ChargingStationModelProtocol>, chargingStations: [ChargingStation]) {
			self.container = container
			self.chargingStations = chargingStations
		}
		
		func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
			if reason == -1 && self.container.model.locationManager.updateUserLocation(mapView.cameraPosition.target.lat, mapView.cameraPosition.target.lng) {
				switch self.container.model.contentState {
				case let .content(contents: _, markers: markers):
					markers.forEach {
						$0.mapView = nil
					}
					self.container.intent.updateCameraPosition(self.chargingStations, mapView.projection.latlng(from: CGPoint(x: 0, y: 0)).lat, mapView.projection.latlng(from: CGPoint(x: mapView.frame.width, y: mapView.frame.height)).lat, mapView.projection.latlng(from: CGPoint(x: mapView.frame.width, y: mapView.frame.height)).lng, mapView.projection.latlng(from: CGPoint(x: 0, y: 0)).lng)
				default:
					break
				}
			}
		}
	}
	
	func makeCoordinator() -> Coordinator {
		return Coordinator(container: self.container, chargingStations: self.chargingStation)
	}
}
