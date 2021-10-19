//
//  BlogEntryTableViewCell.swift
//  BlogApp
//
//  Created by 周元博 on 10/19/21.
//

import UIKit

class BlogEntryTableViewCell: UITableViewCell {

    @IBOutlet var monthTag: UILabel!
    @IBOutlet var dayTag: UILabel!
    @IBOutlet var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
