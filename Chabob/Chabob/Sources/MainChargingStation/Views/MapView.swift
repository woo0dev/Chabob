//
//  MapView.swift
//  Chabob
//
//  Created by woo0 on 2023/07/19.
//

import SwiftUI
import NMapsMap

struct MapView: View {
	var body: some View {
		UIMapView()
	}
}

struct UIMapView: UIViewRepresentable {
	func makeUIView(context: Context) -> NMFNaverMapView {
		let view = NMFNaverMapView()
		view.showZoomControls = false
		view.mapView.positionMode = .direction
		view.mapView.zoomLevel = 17
		
		return view
	}
	
	func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
}
