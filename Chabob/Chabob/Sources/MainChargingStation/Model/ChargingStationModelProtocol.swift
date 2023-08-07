//
//  ChargingStationModelProtocol.swift
//  Chabob
//
//  Created by woo0 on 2023/07/27.
//

import Foundation

protocol ChargingStationModelProtocol {
	var locationManager: LocationService { get }
	var contentState: ChargingStationType.Model.ContentState { get }
	func fetchChargingStationData(url: URL, completion: @escaping (Result<[ChargingStation], ChargingStationError>) -> Void)
	func dataFetchLoading()
	func dataUpdate(contents: [ChargingStation])
	func dataFetchError(_ error: Error)
}

//protocol ChargingStationModelStateProtocol {
//	func dataFetchLoading()
//	func dataUpdate(contents: [ChargingStation])
//	func dataFetchError(_ error: Error)
//}

enum ChargingStationError: Error {
	case emptyData
}
