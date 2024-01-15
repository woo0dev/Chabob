//
//  StationSearchIntentProtocol.swift
//  Chabob
//
//  Created by woo0 on 1/12/24.
//

import Foundation

protocol StationSearchIntentProtocol {
	var searchQueryString: String { get set }
	func changedSearchQuery(searchQuery: String)
}
