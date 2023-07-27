//
//  Bundle.swift
//  Chabob
//
//  Created by woo0 on 2023/07/26.
//

import Foundation

extension Bundle {
	var naverMapClientID: String {
		guard let file = self.path(forResource: "API_Key", ofType: "plist") else { return "" }
		
		guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
		guard let key = resource["NMFClientId"] as? String else { fatalError("API_Key.plist에 NMFClientId를 입력해주세요.")}
		return key
	}
	
	var chargingStationAPIKey: String {
		guard let file = self.path(forResource: "API_Key", ofType: "plist") else { return "" }
		
		guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
		guard let key = resource["ChargingStationAPIKey"] as? String else { fatalError("API_Key.plist에 ChargingStationAPIKey를 입력해주세요.")}
		return key
	}
}
