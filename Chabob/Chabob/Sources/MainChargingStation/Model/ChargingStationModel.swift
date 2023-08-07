//
//  ChargingStationModel.swift
//  Chabob
//
//  Created by woo0 on 2023/07/27.
//

import SwiftUI
import Combine

final class ChargingStationModel: ObservableObject, ChargingStationModelProtocol {
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
						chargingStations = decodeResponse.data
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
		contentState = .content(contents: contents)
	}
	
	func dataFetchError(_ error: Error) {
		contentState = .error(text: "Fail")
	}
}

extension ChargingStationType.Model {
	enum ContentState {
		case loading
		case content(contents: [ChargingStation])
		case error(text: String)
	}
}
