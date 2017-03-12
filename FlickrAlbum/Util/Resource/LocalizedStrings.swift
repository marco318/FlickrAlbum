//
//  LocalizedStrings.swift
//  FlickrAlbum
//
//  Created by kimmyunghoon on 2017. 3. 11..
//  Copyright © 2017년 Raspberry Soft. All rights reserved.
//

import Foundation

struct LocalizedStrings {
  struct PlayButton {
    static let play = NSLocalizedString("PlayButton.play", comment: "")
    static let stop = NSLocalizedString("PlayButton.stop", comment: "")
    static let loading = NSLocalizedString("PlayButton.loading", comment: "")
  }
  
  struct Alert {
    static let timeInterval = NSLocalizedString("Alert.timeInterval", comment: "")
    static let timeRangeGuide = NSLocalizedString("Alert.timeRangeGuide", comment: "")
    static let tooMuchTimeOut = NSLocalizedString("Alert.tooMuchTimeOut", comment: "")
    static let tooMuchServerError = NSLocalizedString("Alert.tooMuchServerError", comment: "")
    static let tryAgainLater = NSLocalizedString("Alert.tryAgainLater", comment: "")
  }
  
  struct Common {
    static let cancel = NSLocalizedString("Common.cancel", comment: "")
    static let confirm = NSLocalizedString("Common.confirm", comment: "")
  }
}
