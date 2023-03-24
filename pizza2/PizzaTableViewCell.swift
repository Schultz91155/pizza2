//
//  PizzaTableViewCell.swift
//  pizza2
//
//  Created by admin on 25.03.2023.
//

import UIKit

class PizzaTableViewCell: UITableViewCell {

    @IBOutlet weak var pizzaDescriptionTableCell: UITextView!
    @IBOutlet weak var pizzaTitleCell: UILabel!
    @IBOutlet weak var pizzaImageTableCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
