//
//  InfoCell.swift
//  SWAPI
//
//  Created by Joshua Borck on 1/14/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import UIKit
import Foundation

class InfoCell: UITableViewCell, NotificationPostable {
    
    // MARK: IBOutlets
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var secondLabelConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Reset cell
        thirdLabel.isHidden = true
        fourthLabel.isHidden = true
        self.isUserInteractionEnabled = false
    }
    
    // MARK: Congfigure Methods
    func configureMoney(conversionRate: Int) {
        // Configure the cell for the money conversion option being selected
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
        // Configure the cell for the length option being selected
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
        // Using a model configure the cell to look correct
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
    
    // MARK: Helper Methods
    func updateConstraintForFullTitle() {
        // Update the label's constraint so it fills the whole line
        if secondLabelConstraint != nil {
            secondLabelConstraint.isActive = false
        }
        secondLabel.trailingAnchor.constraint(equalTo: fourthLabel.trailingAnchor, constant: 0).isActive = true
    }
}
