//
//  UIColor+.swift
//  Chabob
//
//  Created by woo0 on 2023/08/24.
//

import UIKit

extension UIColor {
	static var firstColor: UIColor {
		return UIColor(named: "FirstColor") ?? .cyan
	}
	
	static var secondColor: UIColor {
		return UIColor(named: "SecondColor") ?? .cyan
	}
	
	static var thirdColor: UIColor {
		return UIColor(named: "ThridColor") ?? .green
	}
}
