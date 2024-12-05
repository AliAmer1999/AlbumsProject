//
//  AlbumDetailsViewController.swift
//  AlbumsProject
//
//  Created by Ali Amer on 04/12/2024.
//

import UIKit
import Combine
class AlbumDetailsViewController: UIViewController {
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UICollectionView!
    var album: Album?
    var viewModel: AlbumDetailsViewModel?
    var photos: [Photo]?
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AlbumDetailsViewModel()
        initBinding()
        albumTitleLabel.text = album?.title
        viewModel?.getPhotos(albumID: album?.id ?? 0)
        photosCollectionView.register(UINib(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        searchBar.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
    }
    
    func initBinding() {
        self.viewModel?.$photos
            .dropFirst()
            .sink(receiveValue: { [weak self] photos in
            DispatchQueue.main.async { [weak self] in
                self?.photos = photos
                self?.photosCollectionView.reloadData()
            }
        }).store(in: &cancellables)
        
        self.viewModel?.$error
            .dropFirst()
            .sink(receiveValue: { [weak self] error in
                DispatchQueue.main.async { [weak self] in
                    self?.showAlert(errorMessage: error?.message ?? "")
                }
            }).store(in: &cancellables)
    }
    
    func showAlert(errorMessage: String) {

                let alertController = UIAlertController(
                    title: "Error",
                    message: errorMessage,
                    preferredStyle: .alert
                )
                let dismissAction = UIAlertAction(
                    title: "Dismiss",
                    style: .default,
                    handler: nil // No action on dismissal
                )
                alertController.addAction(dismissAction)
                present(alertController, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}


extension AlbumDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        cell.photoTitle.text = viewModel?.photos?[indexPath.row].title
        return cell
        
    }
    
    
}


extension AlbumDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = 20
        let numberOfCellsPerRow: CGFloat = 3
        let width = (photosCollectionView.bounds.width - CGFloat(totalSpacing)) / numberOfCellsPerRow
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension AlbumDetailsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.components(separatedBy: .whitespacesAndNewlines).joined().isEmpty {
            self.photos = viewModel?.photos
        } else {
            self.photos = viewModel?.photos?.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        self.photosCollectionView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
