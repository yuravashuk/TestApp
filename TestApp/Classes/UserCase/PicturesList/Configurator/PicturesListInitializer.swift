//
//  PicturesListPicturesListInitializer.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit

class PicturesListModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var pictureslistViewController: PicturesListViewController!

    override func awakeFromNib() {

        let configurator = PicturesListModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: pictureslistViewController)
    }

}
