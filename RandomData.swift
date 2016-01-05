//
//  RandomData.swift
//  WatchDataTransfer
//
//  Created by Pieter Kubben on 03-01-16.
//  Copyright © 2016 DigitalNeurosurgeon.com. All rights reserved.
//

import Foundation

class RandomData {
    
    static func generateString(maxItems: Int) -> String {
        var result = ""
        for _ in 0..<maxItems {
            let randomNumber = Int(arc4random_uniform(100))
            result += "\(randomNumber)\n"
        }
        return result
    }
    
}