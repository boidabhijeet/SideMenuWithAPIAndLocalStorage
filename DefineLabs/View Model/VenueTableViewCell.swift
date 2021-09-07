//
//  VenueTableViewCell.swift
//  DefineLabs
//
//  Created by Abhi on 07/09/21.
//

import UIKit

class VenueTableViewCell: UITableViewCell {

    @IBOutlet weak var venueSelected: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
