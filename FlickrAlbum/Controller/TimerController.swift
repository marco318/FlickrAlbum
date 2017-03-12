//
//  TimerController.swift
//  FlickrAlbum
//
//  Created by kimmyunghoon on 2017. 3. 12..
//  Copyright © 2017년 Raspberry Soft. All rights reserved.
//

import Foundation

class TimerController {
  
  static func setTimeInterval(_ interval: Int) {
    let filtered = max(1,min(10,interval))
    UserDefaults.standard.set(filtered, forKey: Constants.UserDefaults.Key.refreshTime)
  }
  
  static func timeInterval() -> Int {
    let interval = UserDefaults.standard.integer(forKey: Constants.UserDefaults.Key.refreshTime)
    return min(10, max(1,interval))
  }
}
