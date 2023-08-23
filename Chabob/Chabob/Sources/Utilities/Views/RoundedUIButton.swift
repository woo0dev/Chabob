//
//  RoundedUIButton.swift
//  Chabob
//
//  Created by woo0 on 2023/08/24.
//

import UIKit

final class RoundedUIButton: UIButton {
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupView(_ imageName: String) {
		var buttonConfig = UIButton.Configuration.filled()
		let imageConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .light)
		let image = UIImage(systemName: imageName, withConfiguration: imageConfig)
		buttonConfig.image = image
		buttonConfig.imagePlacement = .top
		buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
		buttonConfig.background.cornerRadius = 10
		buttonConfig.baseForegroundColor = .white
		buttonConfig.background.backgroundColor = UIColor(named: "FirstColor")
		self.configuration = buttonConfig
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOffset = CGSize(width: 0, height: 4)
		self.layer.shadowRadius = 5
		self.layer.shadowOpacity = 0.3
	}
}
