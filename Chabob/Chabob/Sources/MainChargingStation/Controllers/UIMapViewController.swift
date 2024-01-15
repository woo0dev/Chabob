//
//  UIMapViewController.swift
//  Chabob
//
//  Created by woo0 on 2023/08/23.
//

import UIKit
import NMapsMap
import SwiftUI

class UIMapViewController: UIViewController {
	var container: MVIContainer<ChargingStationIntentProtocol, ChargingStationModelProtocol>
	var chargingStations: [ChargingStation]
	
	let mapView = NMFNaverMapView()
	
	private var intent: ChargingStationIntentProtocol { container.intent }
	private var model: ChargingStationModelProtocol { container.model }
	
	private lazy var profileButton = RoundedUIButton()
	private lazy var searchUIButton = SearchUIButton()
	
	init(container: MVIContainer<ChargingStationIntentProtocol, ChargingStationModelProtocol>, chargingStations: [ChargingStation]) {
		self.container = container
		self.chargingStations = chargingStations
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupMapView()
		setupSubViews()
		updateMapMarkers()
	}
	
	func setupMapView() {
		let userLocation = model.locationManager.fetchUserLocation()
		mapView.showZoomControls = false
		mapView.mapView.positionMode = .direction
		mapView.mapView.zoomLevel = 13
		mapView.mapView.minZoomLevel = 5
		mapView.mapView.extent = NMGLatLngBounds(southWestLat: 31.43, southWestLng: 122.37, northEastLat: 44.35, northEastLng: 132)
		mapView.mapView.moveCamera(NMFCameraUpdate(scrollTo: NMGLatLng(lat: userLocation.latitude, lng: userLocation.longitude), zoomTo: 13))
		mapView.mapView.addCameraDelegate(delegate: self)
		
		view.addSubview(mapView)
		
		mapView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
			self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
		])
	}
	
	func setupSubViews() {
		[profileButton, searchUIButton].forEach { view.addSubview($0) }
		
		profileButton.setupView("person.fill")
		profileButton.addTarget(self, action: #selector(tappedProfileButton), for: .touchUpInside)
		profileButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			self.profileButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
			self.profileButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
			self.profileButton.widthAnchor.constraint(equalTo: self.profileButton.heightAnchor)
		])
		
		searchUIButton.setupView()
		searchUIButton.addTarget(self, action: #selector(tappedSearchButton), for: .touchUpInside)
		searchUIButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			self.searchUIButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
			self.searchUIButton.trailingAnchor.constraint(equalTo: self.profileButton.leadingAnchor, constant: -10),
			self.searchUIButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
			self.searchUIButton.bottomAnchor.constraint(equalTo: self.profileButton.bottomAnchor)
		])
	}
	
	func updateMapMarkers() {
		switch self.container.model.contentState {
		case let .content(contents: chargingStations, markers: markers):
			markers.enumerated().forEach { (index, marker) in
				marker.mapView = self.mapView.mapView
				marker.touchHandler = { (overlay) -> Bool in
					// TODO: 충전소 상세정보 페이지 호출
					return false
				}
			}
		default:
			break
		}
	}
	
	@objc func tappedProfileButton() {
		// TODO: 마이페이지 뷰 호출 구현
	}
	
	@objc func tappedSearchButton() {
		let hostingVC = UIHostingController(rootView: SearchView.build(chargingStations: chargingStations, userLocation: model.locationManager.fetchUserLocation()))
		hostingVC.modalPresentationStyle = .fullScreen
		self.present(hostingVC, animated: true)
	}
}

extension UIMapViewController: NMFMapViewCameraDelegate {
	func mapViewCameraIdle(_ mapView: NMFMapView) {
		if self.container.model.locationManager.updateUserLocation(mapView.cameraPosition.target.lat, mapView.cameraPosition.target.lng, mapView.zoomLevel) {
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

