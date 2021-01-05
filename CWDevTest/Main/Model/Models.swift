//
//  Models.swift
//  CWDevTest
//
//  Created by Mojisola Adebiyi on 27/12/2020.
//

import RealmSwift

class RateList: Object {
    var rates = List<CurrencyRate>()
}

class CurrencyRate: Object {
    @objc dynamic var code = ""
    @objc dynamic var rate = 0.0
}
