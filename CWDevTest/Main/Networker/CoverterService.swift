//
//  CoverterService.swift
//  CWDevTest
//
//  Created by Mojisola Adebiyi on 27/12/2020.
//

import SwiftyJSON

struct LatestRateService {
    private let networkManager = NetworkManager()
    
    func latestRates(completionHandler: @escaping (Result<JSON, Error>) -> ()) {
        let url = "http://data.fixer.io/api/latest"
        networkManager.makeRequest(requestType: .get, url: url, params: ["access_key": Config.apiKey], completionHandler: completionHandler)
    }
}
