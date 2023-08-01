//
//  MainChargingStationView+Build.swift
//  Chabob
//
//  Created by woo0 on 2023/08/02.
//

import SwiftUI

extension MainChargingStationView {
	
	static func build() -> some View {
		let model = ChargingStationModel()
		let intent = ChargingStationIntent(model: model)
		let container = MVIContainer(
			intent: intent as ChargingStationIntentProtocol,
			model: model as ChargingStationModelProtocol,
			modelChangePublisher: model.objectWillChange)
		let view = MainChargingStationView(container: container)
		return view
	}
}
