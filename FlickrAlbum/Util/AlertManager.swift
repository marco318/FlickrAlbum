//
//  AlertManager.swift
//  FlickrAlbum
//
//  Created by kimmyunghoon on 2017. 3. 11..
//  Copyright © 2017년 Raspberry Soft. All rights reserved.
//

import Foundation
import UIKit

class AlertManager {
  enum AlertType {
    case timer, tooMuchTimeOut, serverError, parsingError
  }
  
  func show(_ type: AlertType, from viewController: UIViewController) {
    switch type {
    case .timer: showTimerAlert(from: viewController)
    case .tooMuchTimeOut: break
    case .serverError: break
    case .parsingError: break
    }
  }
  
  private func showTimerAlert(from viewController: UIViewController) {
    let alert = UIAlertController(title: "update time", message: "1 to 10 sec", preferredStyle: .alert)
    alert.addTextField { textField in
      let refreshTime = UserDefaults.standard.integer(forKey: Constants.UserDefaults.Key.refreshTime)
      if refreshTime == 0 {
        UserDefaults.standard.set(1, forKey: Constants.UserDefaults.Key.refreshTime)
      }
      textField.text = "\(max(1,refreshTime))"
      textField.keyboardType = .numberPad
    }
    let actionConfirm = UIAlertAction(title: "Confirm", style: .default, handler: {
      action -> Void in
      guard let time = alert.textFields![0].text else {
        return
      }
      guard let timeInt = Int(time) else {
        return
      }
      let refreshTime = max(1,min(10,timeInt))
      UserDefaults.standard.set(refreshTime, forKey: Constants.UserDefaults.Key.refreshTime)
    })
    let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(actionConfirm)
    alert.addAction(actionCancel)
    viewController.present(alert, animated: true, completion: nil)
  }
}
