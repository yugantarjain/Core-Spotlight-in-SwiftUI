//
//  ContentView.swift
//  My App
//
//  Created by Yugantar Jain on 19/09/22.
//

import SwiftUI
import CoreSpotlight

struct ContentView: View {
	// Sample app-data
	let appData = [102, 503, 653, 998, 124, 587, 776, 354, 449, 287]
	@State private var selection: Int?

    var body: some View {
		NavigationView {
			List {
				Section {
					ForEach(appData, id: \.self) { value in
						NavigationLink(tag: value, selection: $selection) {
							DetailView(value: value)
						} label: {
							Text("\(value)")
						}
					}
				}

				Section {
					Button("Index Data", action: indexData)
					Button("Delete Data", role: .destructive, action: deleteData)
				}
			}
			.navigationTitle("My App")
		}
		.onContinueUserActivity(CSSearchableItemActionType, perform: handleSpotlight)
		.onContinueUserActivity(CSQueryContinuationActionType, perform: handleSpotlightSearchContinuation)
    }

	func indexData() {
		var searchableItems = [CSSearchableItem]()

		appData.forEach {
			let attributeSet = CSSearchableItemAttributeSet(contentType: .content)
			attributeSet.displayName = $0.description
			attributeSet.actionIdentifiers = ["CS_ACTION_1", "CS_ACTION_2"]
//			attributeSet.thumbnailData = UIImage(named: "custom")?.jpegData(compressionQuality: 0.7)
//			attributeSet.phoneNumbers = ["1224"]
//			attributeSet.supportsPhoneCall = true

			let searchableItem = CSSearchableItem(uniqueIdentifier: $0.description, domainIdentifier: "sample", attributeSet: attributeSet)
			searchableItems.append(searchableItem)
		}

		CSSearchableIndex.default().indexSearchableItems(searchableItems)
	}

	func deleteData() {
		CSSearchableIndex.default().deleteSearchableItems(withDomainIdentifiers: ["sample"])
	}

	func handleSpotlight(userActivity: NSUserActivity) {
		// Get selected spotlight search item
		guard let element = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String else {
			return
		}

		// If custom action requested, execute it
		if let actionIdentifier = userActivity.userInfo?[CSActionIdentifier] as? String {
			if actionIdentifier == "CS_ACTION_1" {
				// Perform action 1
			} else if actionIdentifier == "CS_ACTION_2" {
				// Perform action 2
			}
		}
		// Else handle the element
		// Maybe deep-link, or something else entirely
		// This totally depends on your app's use-case
		else {
			self.selection = Int(element)
		}
	}

	func handleSpotlightSearchContinuation(userActivity: NSUserActivity) {
		guard let searchString = userActivity.userInfo?[CSSearchQueryString] as? String else {
			return
		}

		// Continue spotlight search in app
		// Use the search string as per your app's use-case
		print(searchString)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
