//
//  DetailView.swift
//  My App
//
//  Created by Yugantar Jain on 19/09/22.
//

import SwiftUI

struct DetailView: View {
	let value: Int

	var body: some View {
		Text(value.description)
			.font(.system(size: 100, weight: .bold, design: .monospaced))
			.navigationTitle("Detail View")
	}
}

struct DetailView_Previews: PreviewProvider {
	static var previews: some View {
		DetailView(value: 294)
	}
}
