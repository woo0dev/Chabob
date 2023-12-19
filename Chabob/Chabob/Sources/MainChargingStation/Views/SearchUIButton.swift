//
//  SearchBarButton.swift
//  Chabob
//
//  Created by woo0 on 12/19/23.
//

import UIKit

final class SearchUIButton: UIButton {
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupView() {
		var buttonConfig = UIButton.Configuration.filled()
		buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
		buttonConfig.title = "충전소 검색"
		buttonConfig.titleAlignment = .leading
		buttonConfig.background.cornerRadius = 10
		buttonConfig.baseForegroundColor = .lightGray
		buttonConfig.baseBackgroundColor = .white
		self.configuration = buttonConfig
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOffset = CGSize(width: 0, height: 4)
		self.layer.shadowRadius = 5
		self.layer.shadowOpacity = 0.3
	}
}
