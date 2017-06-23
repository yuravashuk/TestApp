//
//  GIFPopupViewController.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-23.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class GIFPopupViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    static let storyboardIdentifier = String(describing: GIFPopupViewController.self)
    var imageUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadGIF()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Configurations
    
    private func configureWebView() {
        webView.isUserInteractionEnabled = false
        webView.delegate = self
        webView.isHidden = true
        webView.scalesPageToFit = true
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.contentMode = UIViewContentMode.scaleAspectFit
    }
    
    // MARK: Gif
    
    private func loadGIF() {
        SVProgressHUD.show()
        Alamofire.request(imageUrl).responseData(completionHandler: { [weak self] (response) in
            SVProgressHUD.dismiss()
            if let data = response.result.value {
                SVProgressHUD.show()
                self?.webView.load(data, mimeType: "image/gif", textEncodingName: "UTF-8", baseURL: NSURL() as URL)
            }
        })
    }
    
}

// MARK: UIWebViewDelegate
extension GIFPopupViewController: UIWebViewDelegate {

    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
        webView.isHidden = false
    }
    
}

