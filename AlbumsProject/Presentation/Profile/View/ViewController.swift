//
//  ViewController.swift
//  AlbumsProject
//
//  Created by Ali Amer on 03/12/2024.
//

import UIKit
import Combine
class ViewController: UIViewController {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var albumsTableView: UITableView!
    
    var viewModel: ProfileViewModel?
    private var cancellables: Set<AnyCancellable> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ProfileViewModel()
        getUsers()
        setupTableView()
        initBinding()
    }
    func setupTableView() {
        albumsTableView.dataSource = self
        albumsTableView.delegate = self
        let nib = UINib(nibName: "AlbumTableViewCell", bundle: nil)
        albumsTableView.register(nib, forCellReuseIdentifier: "AlbumTableViewCell")
//        albumsTableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "AlbumTableViewCell")
    }
    
    func getUsers() {
        viewModel?.getUsers()
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
    
    func initBinding() {
        viewModel?.$users
            .dropFirst()
            .sink(receiveValue: {[weak self] users in
                self?.getRandomUser(users: users ?? [])
        }).store(in: &cancellables)
        
        viewModel?.$albums
            .dropFirst()
            .sink(receiveValue: { [weak self] albums in
                DispatchQueue.main.async { [weak self] in
                    self?.albumsTableView.reloadData()
                }
        }).store(in: &cancellables)
        
        viewModel?.$error
            .dropFirst()
            .sink(receiveValue: {[weak self] error in
            DispatchQueue.main.async { [weak self] in
                self?.showAlert(errorMessage: error?.message ?? "")
            }
        }).store(in: &cancellables)
    }
    
    func getRandomUser(users: [User]) {
        let randomInt = Int.random(in: 1...users.count - 1)
        DispatchQueue.main.async { [weak self] in
            self?.nameLabel.text = users[randomInt].name
            self?.addressLabel.text = users[randomInt].address.city + "," + users[randomInt].address.suite + "," + users[randomInt].address.street + "," + "\n" + users[randomInt].address.geo.lng + users[randomInt].address.geo.lat 
            self?.getAlbums(userId: randomInt)
            

        }
        
    }
    
    func getAlbums(userId: Int) {
        viewModel?.getAlbums(userId: userId)
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.albums?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as? AlbumTableViewCell
        cell?.albumLabel.text = viewModel?.albums?[indexPath.row].title
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumDetailsViewController = AlbumDetailsViewController()
        albumDetailsViewController.album = viewModel?.albums?[indexPath.row]
        navigationController?.pushViewController(albumDetailsViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}

