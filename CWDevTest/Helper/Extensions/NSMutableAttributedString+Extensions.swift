//
//  NSMutableAttributedString+Extensions.swift
//  CWDevTest
//
//  Created by Mojisola Adebiyi on 02/01/2021.
//

import UIKit

extension NSMutableAttributedString {
    func setColor(color: UIColor, forText stringValue: String) {
       let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
       self.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
    }
}
