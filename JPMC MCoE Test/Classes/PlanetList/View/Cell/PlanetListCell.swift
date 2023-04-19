//
//  PlanetListCell.swift
//  JPMC MCoE Test
//
//  Created by Nikunj Gangani on 18/04/2023.
//

import UIKit

class PlanetListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var populationLabel: UILabel!
        @IBOutlet weak var rotationLabel: UILabel!
        @IBOutlet weak var orbitalLabel: UILabel!
        @IBOutlet weak var diameterLabel: UILabel!
        
        var planet: Planet? {
            didSet {
                setData()
            }
        }

        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        
        func setData() {
            self.nameLabel.text = planet?.name ?? ""
            self.populationLabel.text = planet?.population ?? ""
            self.rotationLabel.text = planet?.rotation_period ?? ""
            self.orbitalLabel.text = planet?.orbital_period ?? ""
            self.diameterLabel.text = planet?.diameter ?? ""
        }
    
}
