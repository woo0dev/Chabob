//
//  StationSearchIntent.swift
//  Chabob
//
//  Created by woo0 on 1/12/24.
//

import SwiftUI

final class StationSearchIntent: StationSearchIntentProtocol {
	private var model: StationSearchModelProtocol?
	var searchQueryString: String = "" {
		didSet {
			model?.filterStations(searchQuery: searchQueryString)
		}
	}
	
	init(model: StationSearchModelProtocol? = nil) {
		self.model = model
	}
	
	func changedSearchQuery(searchQuery: String) {
		searchQueryString = searchQuery
	}
}
