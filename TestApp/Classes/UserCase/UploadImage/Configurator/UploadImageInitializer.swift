//
//  UploadImageUploadImageInitializer.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit

class UploadImageModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var uploadimageViewController: UploadImageViewController!

    override func awakeFromNib() {

        let configurator = UploadImageModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: uploadimageViewController)
    }

}
