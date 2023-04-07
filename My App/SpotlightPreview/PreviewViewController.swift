//
//  PreviewViewController.swift
//  SpotlightPreview
//
//  Created by Yugantar Jain on 04/04/23.
//

import UIKit
import QuickLook

class PreviewViewController: UIViewController, QLPreviewingController {
        
	@IBOutlet weak var titleLabel: UILabel!

	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func preparePreviewOfSearchableItem(identifier: String, queryString: String?, completionHandler handler: @escaping (Error?) -> Void) {
        // Perform any setup necessary in order to prepare the view.
		titleLabel.text = identifier

        // Call the completion handler so Quick Look knows that the preview is fully loaded.
        // Quick Look will display a loading spinner while the completion handler is not called.
        handler(nil)
    }

}
