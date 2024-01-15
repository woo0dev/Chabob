//
//  SearchBarView.swift
//  Chabob
//
//  Created by woo0 on 12/19/23.
//

import SwiftUI
import CoreLocation

struct SearchView: View {
	@StateObject var container: MVIContainer<StationSearchIntentProtocol, StationSearchModelProtocol>
	@State private var searchQueryString: String = ""
	
	private var intent: StationSearchIntentProtocol { container.intent }
	private var model: StationSearchModelProtocol { container.model }
	
	var body: some View {
		// TODO: navigation bar content view
		NavigationView {
			if model.filteredStations.isEmpty {
				Text("\(searchQueryString)에 대한 검색결과가 없습니다.")
					.foregroundStyle(Color.gray)
			} else {
				List(model.filteredStations) { station in
					// TODO: 검색 단어 컬러로 구분하기, 표시할 정보 수정하기, 터치 이벤트 추가하기
					Text(station.csNm)
				}
				.listStyle(.plain)
			}
		}
		// !!!: 처음 포커스 될 때 딜레이 생기고 매번 warning 발생. 관련링크 -https://forums.developer.apple.com/forums/thread/731700
		.searchable(
			text: $searchQueryString,
			placement: .navigationBarDrawer(displayMode: .always),
			prompt: "충전소 이름을 입력해주세요."
		)
		.onChange(of: searchQueryString) { query in
			intent.changedSearchQuery(searchQuery: query)
		}
	}
}

extension SearchView {
	static func build(chargingStations: [ChargingStation], userLocation: CLLocationCoordinate2D) -> some View {
		let model = StationSearchModel(stations: chargingStations, userLocation: userLocation)
		let intent = StationSearchIntent(model: model)
		let container = MVIContainer(
			intent: intent as StationSearchIntentProtocol,
			model: model as StationSearchModelProtocol,
			modelChangePublisher: model.objectWillChange)
		let view = SearchView(container: container)
		return view
	}
}
