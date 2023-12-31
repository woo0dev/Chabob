//
//  ChabobApp.swift
//  Chabob
//
//  Created by woo0 on 2023/06/26.
//

import SwiftUI
import NMapsMap

@main
struct ChabobApp: App {
	
	init() {
		NMFAuthManager.shared().clientId = Bundle.main.naverMapClientID
	}
	
    var body: some Scene {
        WindowGroup {
			MainChargingStationView.build()
        }
    }
}
