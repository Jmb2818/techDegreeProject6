//
//  InfoCell.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/14/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import UIKit
import Foundation

class InfoCell: UITableViewCell {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thirdLabel.isHidden = true
        fourthLabel.isHidden = true
        self.isUserInteractionEnabled = false
    }
    
    func configureMoney(conversionRate: Int) {
        guard conversionRate > 0 else {
            //TODO: Throw conversion rate incorrect error
            return
        }
        if thirdLabel.textColor == .white {
            fourthLabel.textColor = .white
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            let secondLabelWithoutDollar = self.secondLabel.text?.filter({ $0 != "$"})
            let secondLabel = secondLabelWithoutDollar?.filter( { $0 != ","})
            if let cost = secondLabel, let credits = Int(cost) {
                let costInCreditsString = String(credits/conversionRate)
                self.secondLabel.text = "\(Formatter.formatNumberWithComma(costInCreditsString))"
            }
        } else if fourthLabel.textColor == .white {
            thirdLabel.textColor = .white
            fourthLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            let secondLabel = self.secondLabel.text?.filter( { $0 != ","})
            if let cost = secondLabel, let credits = Int(cost) {
                let costInDollarsString = String(credits * conversionRate)
                self.secondLabel.text = "$\(Formatter.formatNumberWithComma(costInDollarsString))"
            }
        }
    }
    
    func configureLength() {
        if thirdLabel.textColor == .white {
            fourthLabel.textColor = .white
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            returnMetricUnits()
        } else if fourthLabel.textColor == .white {
            thirdLabel.textColor = .white
            fourthLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            returnImperialUnits()
        }
    }
    
    func returnMetricUnits() {
        let secondLabelNoN = self.secondLabel.text?.filter({ $0 != "n"})
        let secondLabelNoI = secondLabelNoN?.filter({ $0 != "i"})
        let secondLabel = secondLabelNoI?.filter( { $0 != ","})
        
        if let feet = secondLabel, let length = Double(feet) {
            let meters = Measurement(value: length, unit: UnitLength.inches).converted(to: .meters).value
            self.secondLabel.text = "\(Formatter.formatToOneDecimal(meters))m"
        }
    }
    
    func returnImperialUnits() {
        let secondLabelNoM = self.secondLabel.text?.filter({ $0 != "m"})
        let secondLabel = secondLabelNoM?.filter( { $0 != ","})
        if let meters = secondLabel, let length = Double(meters) {
            let feet = Measurement(value: length, unit: UnitLength.meters).converted(to: .inches).value
            self.secondLabel.text = "\(Formatter.formatToOneDecimal(feet))in"
        }
    }
    
    func configureCell(model: InfoCellModel) {
        isUserInteractionEnabled = model.shouldAllowInteraction
        firstLabel.text = model.cellTitle
        secondLabel.text = model.cellData
        thirdLabel.isHidden = model.cellFirstSubLabel == nil ? true : false
        thirdLabel.text = model.cellFirstSubLabel
        fourthLabel.isHidden = model.cellSecondSubLabel == nil ? true : false
        fourthLabel.text = model.cellSecondSubLabel
        thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
        fourthLabel.textColor = .white
        if model.needsConstraintUpdate {
            updateConstraintForFullTitle()
        }
    }
    
    func updateConstraintForFullTitle() {
        secondLabel.trailingAnchor.constraint(equalTo: fourthLabel.trailingAnchor, constant: 0).isActive = true
    }
}
