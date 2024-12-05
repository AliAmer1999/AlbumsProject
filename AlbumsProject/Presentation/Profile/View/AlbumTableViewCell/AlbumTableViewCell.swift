//
//  AlbumTableViewCell.swift
//  AlbumsProject
//
//  Created by Ali Amer on 04/12/2024.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var albumLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
