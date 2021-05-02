//
//  ToDoItemCell.swift
//  MyTodoApp
//
//  Created by Noor Walid on 20/04/2021.
//

import UIKit

class ToDoItemCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let formatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        formatter.timeZone = TimeZone(abbreviation: "GMT+2")
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
