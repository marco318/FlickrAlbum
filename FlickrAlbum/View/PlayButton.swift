//
//  PlayButton.swift
//  FlickrAlbum
//
//  Created by kimmyunghoon on 2017. 3. 11..
//  Copyright © 2017년 Raspberry Soft. All rights reserved.
//

import Foundation
import UIKit

class PlayButton: UIButton {
  
  enum Status {
    case goToPlay, goToStop
    var titleText: String {
      switch self {
      case .goToPlay: return LocalizedStrings.PlayButton.play
      case .goToStop: return LocalizedStrings.PlayButton.stop
      }
    }
    var backgroundColor: UIColor {
      switch self {
      case .goToPlay: return UIColor(red: 79/255, green: 213/255, blue: 112/255, alpha: 1)
      case .goToStop: return UIColor(red: 241/255, green: 143/255, blue: 142/255, alpha: 1)
      }
    }
  }
  
  var status: Status = .goToPlay
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    updateUI(with: status)
  }
  
  func updateUI(with newStatus: Status) {
    setTitle(newStatus.titleText, for: .normal)
    backgroundColor = newStatus.backgroundColor
  }
  
  func flip() {
    switch status {
    case .goToPlay: status = .goToStop
    case .goToStop: status = .goToPlay
    }
    updateUI(with: status)
  }
}
