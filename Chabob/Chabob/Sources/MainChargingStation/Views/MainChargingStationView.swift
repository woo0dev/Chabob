//
//  ContentView.swift
//  Chabob
//
//  Created by woo0 on 2023/06/26.
//

import SwiftUI

struct MainChargingStationView: View {
	@StateObject var container: MVIContainer<ChargingStationIntentProtocol, ChargingStationModelProtocol>
	
	private var intent: ChargingStationIntentProtocol { container.intent }
	private var model: ChargingStationModelProtocol { container.model }
	
    var body: some View {
		mainView()
			.onAppear(perform: intent.viewOnAppear)
			.onDisappear(perform: intent.viewOnDisappear)
    }
}

private extension MainChargingStationView {
	func mainView() -> some View {
		MapView()
	}
}
