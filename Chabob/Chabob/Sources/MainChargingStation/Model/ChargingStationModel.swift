//
//  ChargingStationModel.swift
//  Chabob
//
//  Created by woo0 on 2023/07/27.
//

import SwiftUI
import Combine
import NMapsMap

final class ChargingStationModel: ObservableObject, ChargingStationModelProtocol {
	// TODO: locationManager 대신 userLocation을 가지고 있도록 수정
	@Published var locationManager = LocationService()
	@Published var contentState: ChargingStationType.Model.ContentState = .loading
	
	func fetchChargingStationData(url: URL, completion: @escaping (Result<[ChargingStation], ChargingStationError>) -> Void) {
		var chargingStations = [ChargingStation]()
		let urlRequest = URLRequest(url: url)
		let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
			if let error = error {
				print("task 생성 에러: ", error)
				return
			}
			
			guard let response = response as? HTTPURLResponse else { return }
			
			if response.statusCode == 200 {
				guard let data = data else { return }
				DispatchQueue.main.async {
					do {
						let decodeResponse = try JSONDecoder().decode(ChargingStationResponse.self, from: data)
						chargingStations = decodeResponse.data.enumerated().map {
							var station = $0
							station.element.id = $0.offset
							return station.element
						}
					} catch let error {
						print("Error: Decoding: ", error)
					}
					if chargingStations.isEmpty {
						completion(.failure(.emptyData))
					} else {
						completion(.success(chargingStations))
					}
				}
			}
		}
		
		dataTask.resume()
	}
}

extension ChargingStationModel {
	func dataFetchLoading() {
		contentState = .loading
	}
	
	func dataUpdate(contents: [ChargingStation]) {
		var markers = [NMFMarker]()
		
		contents.forEach { station in
			let marker = NMFMarker()
			marker.position = NMGLatLng(lat: Double().toLatitude(station.lat), lng: Double().toLongitude(station.longi))
			marker.iconImage = NMFOverlayImage(name: "Marker")
			marker.captionMinZoom = 9
			marker.captionMaxZoom = 16
			marker.captionRequestedWidth = 100
			marker.width = 20
			marker.height = 30
			marker.isHideCollidedMarkers = true
			markers.append(marker)
		}
		
		contentState = .content(contents: contents, markers: markers)
	}
	
	func dataFetchError(_ error: Error) {
		contentState = .error(text: "Fail")
	}
}

extension ChargingStationType.Model {
	enum ContentState {
		case loading
		case content(contents: [ChargingStation], markers: [NMFMarker])
		case error(text: String)
	}
}
