//
//  ChargingStation.swift
//  Chabob
//
//  Created by woo0 on 2023/08/01.
//

import Foundation

struct ChargingStationResponse: Codable {
	let currentCount, matchCount, page, perPage, totalCount: Int
	let data: [ChargingStation]
}

struct ChargingStation: Codable, Hashable {
	let addr, chargeTp, cpStat, cpTp, csNm, lat, longi, statUpdatetime: String
	let cpID, csID: Int?
	let cpNm: ChargerType
}

enum ChargerType: String, Codable {
	case quick01 = "급속01"
	case quick02 = "급속02"
	case quick03 = "급속03"
	case quick04 = "급속04"
	case quick05 = "급속05"
	case quick06 = "급속06"
	case quick07 = "급속07"
	case quick08 = "급속08"
	case quick09 = "급속09"
	case quick10 = "급속10"
	case quick11 = "급속11"
	case standard01 = "완속01"
	case standard02 = "완속02"
	case standard03 = "완속03"
	case standard04 = "완속04"
	case standard05 = "완속05"
	case standard06 = "완속06"
	case standard07 = "완속07"
	case standard08 = "완속08"
	case standard09 = "완속09"
	case standard10 = "완속10"
	case standard11 = "완속11"
	case standard12 = "완속12"
	case standard13 = "완속13"
}
