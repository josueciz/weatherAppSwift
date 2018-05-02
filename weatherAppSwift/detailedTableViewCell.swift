//
//  detailedTableViewCell.swift
//  weatherAppSwift
//
//  Created by Josue on 2018/05/02.
//  Copyright © 2018 Private. All rights reserved.
//

import UIKit

class detailedTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var firstRowOne: UILabel!
    @IBOutlet weak var firstRowTwo: UILabel!
    @IBOutlet weak var firstRowThree: UILabel!
    @IBOutlet weak var firstRowFour: UILabel!
    @IBOutlet weak var secondRowOne: UILabel!
    @IBOutlet weak var secondRowTwo: UILabel!
    @IBOutlet weak var secondRowThree: UILabel!
    @IBOutlet weak var secondRowFour: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
