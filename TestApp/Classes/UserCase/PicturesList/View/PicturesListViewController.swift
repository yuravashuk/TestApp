//
//  PicturesListPicturesListViewController.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit
import SVProgressHUD

class PicturesListViewController: UIViewController, PicturesListViewInput {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!

    var output: PicturesListViewOutput!
    static let storyboardIdentifier = String(describing: PicturesListViewController.self)

    fileprivate var imagePreview: ImagePreviewHelper!
    
    fileprivate struct Constants {
        static let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        static let itemsPerRow: CGFloat = 2
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imagePreview == nil {
            imagePreview = ImagePreviewHelper(viewController: self)
        }
        output.requestImages()
    }

    // MARK: PicturesListViewInput
    func setupInitialState() {
        configureCollectionView()
    }

    func set(title: String) {
        titleLabel.text = title
    }

    func refreshView() {
        collectionView.reloadData()
    }
    
    func togglePlaceholder(on: Bool) {
        placeholderView.isHidden = !on
    }

    func showSpinner() {
        SVProgressHUD.show()
    }

    func hideSpinner() {
        SVProgressHUD.dismiss()
    }

    func showError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
    
    // MARK: Configuration
    
    func configureCollectionView() {
        collectionView.register(UINib.init(nibName: WeatherCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: Actions
    
    @IBAction func actionAdd(_ sender: Any) {
        output.addImage()
    }
    
    @IBAction func actionPlay(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Generate GIF", message: "Please type kind of weather", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { [weak self] (_) in
            let field = alertController.textFields![0]
            self?.output.generateGif(field.text ?? "")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Weather"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func actionLogout(_ sender: Any) {
        output.logout()
    }

}

// MARK: UICollectionViewDelegate & UICollectionViewDataSource
extension PicturesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return output.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
        
        let item = output.picture(at: indexPath.item, section: indexPath.section)
        let url = item.smallImagePath
        let weather = item.parameters?.weather ?? ""
        let location = item.parameters?.address ?? ""
        
        cell.setup(imageUrl: url, title: weather, location: location)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let picture = output.picture(at: indexPath.item, section: indexPath.section )
        let url = picture.smallImagePath
        self.imagePreview.showImage(from: url)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension PicturesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Constants.sectionInsets.left * (Constants.itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / Constants.itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.sectionInsets.left
    }
    
}
