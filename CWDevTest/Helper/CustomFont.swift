//
//  CustomFont.swift
//  CWDevTest
//
//  Created by Mojisola Adebiyi on 02/01/2021.
//

import UIKit


enum MontserratAlternatesFont: String {
    case bold = "MontserratAlternates-Bold"
    case semiBold = "MontserratAlternates-SemiBold"
    case regular = "MontserratAlternates-Regular"
    case medium = "MontserratAlternates-Medium"
}


class CustomFont {
    static func of(type: MontserratAlternatesFont, size: Int) -> UIFont {
        return UIFont(name: type.rawValue, size: CGFloat(size)) ?? UIFont()
    }
}
