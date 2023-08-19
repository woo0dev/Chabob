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
		ZStack {
			switch model.contentState {
			case .loading:
				LoadingView()
			case let .content(contents: chargingStations, markers: _):
				UIMapView(container: container, chargingStation: chargingStations)
			case let .error(text: text):
				ErrorView(text: text)
			}
		}
		.ignoresSafeArea(.all)
		.onAppear(perform: intent.viewOnAppear)
		.onDisappear(perform: intent.viewOnDisappear)
    }
}

