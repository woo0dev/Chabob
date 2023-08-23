//
//  MVIContainer.swift
//  Chabob
//
//  Created by woo0 on 2023/08/01.
//

import SwiftUI
import Combine

final class MVIContainer<Intent, Model>: ObservableObject {
	let intent: Intent
	let model: Model

	private var cancellable: Set<AnyCancellable> = []

	init(intent: Intent, model: Model, modelChangePublisher: ObjectWillChangePublisher) {
		self.intent = intent
		self.model = model

		modelChangePublisher
			.receive(on: RunLoop.main)
			.sink(receiveValue: objectWillChange.send)
			.store(in: &cancellable)
	}
}
