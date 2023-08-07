//
//  ChargingStationIntent.swift
//  Chabob
//
//  Created by woo0 on 2023/08/01.
//

import SwiftUI

class ChargingStationIntent: ChargingStationIntentProtocol {
	private var model: ChargingStationModelProtocol?
	
	private var chargingStations = [ChargingStation]()
	
	init(model: ChargingStationModelProtocol? = nil) {
		self.model = model
	}
	
	func viewOnAppear() {
		guard let url = URL(string: "https://api.odcloud.kr/api/EvInfoServiceV2/v1/getEvSearchList?page=1&perPage=10000&serviceKey=\(Bundle.main.chargingStationAPIKey)") else { fatalError("url 변환 실패") }
		model?.fetchChargingStationData(url: url) { [weak self] result in
			switch result {
			case let .success(chargingStations):
				self?.chargingStations = chargingStations
				self?.model?.dataUpdate(contents: chargingStations)
			case let .failure(error):
				self?.model?.dataFetchError(error)
			}
		}
	}
	
	func viewOnDisappear() {
		print("MainChargingStationViewDisappear")
	}
}
