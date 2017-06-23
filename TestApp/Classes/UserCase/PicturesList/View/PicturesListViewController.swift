//
//  PicturesListPicturesListViewController.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit

class PicturesListViewController: UIViewController, PicturesListViewInput {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var placeholderView: UIView!
    
    var output: PicturesListViewOutput!
    static let storyboardIdentifier = String(describing: PicturesListViewController.self)
    
    fileprivate var items: [WeatherImage] = [] {
        didSet {
            tooglePlaceholder()
        }
    }
    
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
    
    func presentImages(_ images: [WeatherImage]) {
        self.items = images
        collectionView.reloadData()
    }
    
    func tooglePlaceholder() {
        placeholderView.isHidden = items.count > 0
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
    
}

// MARK: UICollectionViewDelegate & UICollectionViewDataSource
extension PicturesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
        
        let item = items[indexPath.item]
        let url = item.smallImagePath
        let weather = item.parameters?.weather ?? ""
        let location = item.parameters?.address ?? ""
        
        cell.setup(imageUrl: url, title: weather, location: location)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = items[indexPath.row].smallImagePath
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
