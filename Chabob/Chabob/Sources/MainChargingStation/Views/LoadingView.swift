//
//  LoadingView.swift
//  Chabob
//
//  Created by woo0 on 2023/08/18.
//

import SwiftUI

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
