//
//  PicturesListPicturesListViewOutput.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

protocol PicturesListViewOutput {

    /**
        @author Yura Vash
        Notify presenter that view is ready
    */

    func viewIsReady()
    func requestImages()
    func addImage()
    func generateGif(_ weatherType: String)
    
}
