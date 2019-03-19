//
//  NetworkManager.swift
//  d07
//
//  Created by Anna BIBYK on 1/24/19.
//  Copyright © 2019 Anna BIBYK. All rights reserved.
//

import Foundation
import RecastAI
import ForecastIO

class NetworkManager {
    
    var bot: RecastAIClient?
    var client: DarkSkyClient?
    
    init() {
        bot = RecastAIClient(token : "3cd97a9f54ceeffbdf17d56aa2c898d4", language: "en")
        client = DarkSkyClient(apiKey: "76637466482e672bcc9f936626f6c40d")
    }
    
    func getLocation(_ text: String, completion: @escaping ((String) -> Void)) {
        bot?.textRequest(text, successHandler: { [weak self] (response) in
            print(response)
            if let location = response.all(entity: "location") {
                if let latitude = location[0]["lat"] as? Double, let longitude = location[0]["lng"] as? Double,
                    let raw = location[0]["raw"] as? String {
                    self?.getWeather(latitude, longitude, raw, completion: { (response) in
                        completion(response)
                    })
                } else {
                    completion("Error")
                }
            } else {
                completion("Error")
            }
            }, failureHandle: { (error) in
                print(error)
                completion("Error")
        })
    }
    
    func getWeather(_ latitude: Double, _ longitude: Double, _ city: String, completion: @escaping ((String) -> Void)) {
        client?.getForecast(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let currentForecast, _):
                if let summary = currentForecast.currently?.summary {
                    let answerLabel = "It's " + summary + " in " + city
                    completion(answerLabel)
                } else {
                    completion("Error")
                }
            case .failure( _):
                completion("Error")
            }
        }
    }
}
