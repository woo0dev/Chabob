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
			case let .content(contents: chargingStations):
				MapView(chargingStations: chargingStations)
			case let .error(text: text):
				ErrorContent(text: text)
			}
		}
		.ignoresSafeArea(.all)
		.onAppear(perform: intent.viewOnAppear)
		.onDisappear(perform: intent.viewOnDisappear)
    }
}

struct LoadingView: View {
	@State private var isLoading = false
	var body: some View {
		ZStack {
			Color(red: 131/255, green: 222/255, blue: 140/255)
				.ignoresSafeArea()
				.opacity(isLoading ? 1 : 0)
			VStack {
				Spacer()
				Image("Icon")
					.resizable()
					.frame(width: 100, height: 100)
				Spacer()
			}
			ZStack {
				VStack {
					ProgressView()
						.progressViewStyle(CircularProgressViewStyle())
						.scaleEffect(2)
						.padding(.top, 60)
						.opacity(isLoading ? 1 : 0)
				}
			}
		}
		.onAppear {
			startLoading()
		}
	}
	
	func startLoading() {
		isLoading = true
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			isLoading = false
		}
	}
}

private struct ErrorContent: View {
	let text: String
	
	var body: some View {
		ZStack {
			Color.white
			Text(text)
		}
	}
}
