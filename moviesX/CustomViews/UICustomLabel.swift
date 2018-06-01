//
//  UICustomLabel.swift
//  testios
//
//  Created by thejus manoharan on 04/04/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import UIKit

@IBDesignable
open class UICustomLabel: UILabel {

  

    public override init(frame: CGRect) {
        super.init(frame: frame)

    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBInspectable
    public var isShadow: Bool = true {
        didSet {
            if isShadow {
                self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
                self.layer.shadowOffset = CGSize(width: 0, height: 3)
                self.layer.shadowOpacity = 1.0
                self.layer.shadowRadius = 10.0
                self.layer.masksToBounds = false
            }
            
        }
    }

}
