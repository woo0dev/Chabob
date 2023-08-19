//
//  Double+.swift
//  Chabob
//
//  Created by woo0 on 2023/08/13.
//

import Foundation

extension Double {
	func toLatitude(_ string: String) -> Double {
		return Double(string) ?? 37.359600825024025
	}
	func toLongitude(_ string: String) -> Double {
		return Double(string) ?? 127.1050730428666
	}
}
