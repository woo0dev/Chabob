//
//  ErrorView.swift
//  Chabob
//
//  Created by woo0 on 2023/08/18.
//

import SwiftUI

struct ErrorView: View {
	let text: String
	
	var body: some View {
		ZStack {
			Color.white
			Text(text)
		}
	}
}
