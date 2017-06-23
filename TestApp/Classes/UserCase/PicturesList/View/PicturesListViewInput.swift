//
//  PicturesListPicturesListViewInput.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

protocol PicturesListViewInput: class {

    /**
        @author Yura Vash
        Setup initial state of the view
    */

    func setupInitialState()
    func presentImages(_ images: [WeatherImage])
    func tooglePlaceholder()
    
}
