//
//  ChargingStationModel.swift
//  Chabob
//
//  Created by woo0 on 2023/07/27.
//

import SwiftUI
import Combine

class ChargingStationModel: ObservableObject, ChargingStationModelProtocol {
	@Published var chargingStations: [ChargingStation] = [ChargingStation]()
	
	func fetchChargingStationData(url: URL) {
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
						self.chargingStations = decodeResponse.data
					} catch let error {
						print("Error: Decoding: ", error)
					}
				}
			}
		}
		
		dataTask.resume()
	}
}
