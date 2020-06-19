//
//  DataManager.swift
//  Cate Sports App
//
//  Created by Cole Hillyer on 6/4/20.
//  Copyright © 2020 Ian Mabon. All rights reserved.
//

import Foundation
// i don't know if this is completely necessary but it's how I'm decoding the json data into strings
struct SportData: Decodable {
    let Sport: [String]
    let Location: [String]
    let Notes: [String]
    let Lat: [String]
    let Long: [String]
    let Time: [String]
}

