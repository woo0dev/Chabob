//
//  SearchBarView.swift
//  Chabob
//
//  Created by woo0 on 12/19/23.
//

import SwiftUI

struct SearchBarView: View {
	@State var searchText: String
	
	var body: some View {
		HStack {
			HStack {
				Image(systemName: "magnifyingglass")
				
				TextField("Search", text: $searchText)
					.foregroundColor(.primary)
				
				if !searchText.isEmpty {
					Button(action: {
						self.searchText = ""
					}) {
						Image(systemName: "xmark.circle.fill")
					}
				} else {
					EmptyView()
				}
			}
			.padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
			.foregroundColor(.secondary)
			.background(Color(.secondarySystemBackground))
			.cornerRadius(10.0)
		}
		.padding(.horizontal)
	}
}
