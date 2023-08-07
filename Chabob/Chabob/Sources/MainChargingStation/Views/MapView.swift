//
//  MapView.swift
//  Chabob
//
//  Created by woo0 on 2023/07/19.
//

import SwiftUI
import NMapsMap

struct MapView: View {
	let chargingStations: [ChargingStation]
	
	var body: some View {
		UIMapView(chargingStations: chargingStations)
	}
}

struct UIMapView: UIViewRepresentable {
	let chargingStations: [ChargingStation]
	
	func makeUIView(context: Context) -> NMFNaverMapView {
		var markers = [NMFMarker]()
		let view = NMFNaverMapView()
//		let location = model.locationManager.fetchUserLocation()
		view.showZoomControls = false
		view.mapView.positionMode = .direction
		view.mapView.zoomLevel = 17
//		view.mapView.moveCamera(NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude), zoomTo: 15))
		
		chargingStations.forEach { chargingStation in
//			print(chargingStation)
			let marker = NMFMarker()
//			marker.mapView = view.mapView
			marker.position = NMGLatLng(lat: Double(chargingStation.lat) ?? 37.359600825024025, lng: Double(chargingStation.longi) ?? 127.1050730428666)
			marker.iconImage = NMF_MARKER_IMAGE_BLACK
			marker.captionMinZoom = 9
			marker.captionMaxZoom = 16
			marker.captionRequestedWidth = 100
			marker.width = 20
			marker.height = 30
			
			markers.append(marker)
		}
		
		markers.forEach {
			$0.mapView = view.mapView
		}
		
		return view
	}
	
	func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
}

//extension View {
//	func Print(_ item: Any) -> some View {
//		#if DEBUG
//		print(item)
//		#endif
//		return self
//	}
//}
