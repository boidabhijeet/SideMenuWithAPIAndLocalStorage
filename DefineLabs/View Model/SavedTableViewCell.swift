//
//  SavedTableViewCell.swift
//  DefineLabs
//
//  Created by Abhi on 07/09/21.
//

import UIKit

class SavedTableViewCell: UITableViewCell {

    @IBOutlet weak var isSaved: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
