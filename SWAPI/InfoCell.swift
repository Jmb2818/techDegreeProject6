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
    @IBOutlet weak var secondLabelConstraint: NSLayoutConstraint!
    
    
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
            secondLabel.text = Formatter.convertToCredits(secondLabelText: secondLabel.text, conversionRate: conversionRate)
        } else if fourthLabel.textColor == .white {
            thirdLabel.textColor = .white
            fourthLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            secondLabel.text = Formatter.convertToUSD(secondLabelText: secondLabel.text, conversionRate: conversionRate)
        }
    }
    
    func configureLength() {
        if thirdLabel.textColor == .white {
            fourthLabel.textColor = .white
            thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            secondLabel.text = Formatter.convertToMetricUnits(secondLabelText: secondLabel.text)
        } else if fourthLabel.textColor == .white {
            thirdLabel.textColor = .white
            fourthLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
            secondLabel.text = Formatter.convertToImperialUnits(secondLabelText: secondLabel.text)
        }
    }
    
    func configureCell(model: InfoCellModel) {
        isUserInteractionEnabled = model.shouldAllowInteraction
        firstLabel.text = model.cellTitle
        secondLabel.text = model.cellData
        secondLabel.numberOfLines = model.shouldOnlyBeOneLine ? 1 : 0
        thirdLabel.isHidden = model.cellFirstSubLabel == nil ? true : false
        thirdLabel.text = model.cellFirstSubLabel
        fourthLabel.isHidden = model.cellSecondSubLabel == nil ? true : false
        fourthLabel.text = model.cellSecondSubLabel
        thirdLabel.textColor = #colorLiteral(red: 0.3764705882, green: 0.3882352941, blue: 0.4, alpha: 1)
        fourthLabel.textColor = .white
        if model.needsConstraintUpdate {
            updateConstraintForFullTitle()
        } else {
           thirdLabel.leadingAnchor.constraint(greaterThanOrEqualTo: secondLabel.trailingAnchor, constant: 10).isActive = true
        }
    }
    
    func updateConstraintForFullTitle() {
        if secondLabelConstraint != nil {
            secondLabelConstraint.isActive = false
        }
        secondLabel.trailingAnchor.constraint(equalTo: fourthLabel.trailingAnchor, constant: 0).isActive = true
    }
}
