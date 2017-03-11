//
//  AlbumDisplayViewController.swift
//  FlickrAlbum
//
//  Created by kimmyunghoon on 2017. 3. 11..
//  Copyright © 2017년 Raspberry Soft. All rights reserved.
//

import Foundation
import UIKit

class AlbumDisplayViewController: ViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var playButton: PlayButton!
  
  var albumController = AlbumController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    albumController.delegate = self
    albumController.requestPhotoFeeds()
    
  }
  // MARK: Actions
  
  @IBAction func onTouchPlayButton(_ sender: PlayButton) {
    if sender.status == .loading {
      return
    }
    playButtonDidClicked()
  }
  
  @IBAction func onTouchTimerButton(_ sender: Any) {
    AlertManager().show(.timer, from: self)
  }
  
}

extension AlbumDisplayViewController: AlbumDisplay {

  func playButtonDidClicked() {
    let staus = playButton.status
    defer {
      playButton.flip()
    }
    switch staus {
    case .goToPlay: showFirstImage()
    case .goToStop: break
    case .loading: break
    }
    
  }
  
  private func showFirstImage() {
    print("showFirstImage")
    
    guard albumController.images.count > 0 else {
      print("no image")
      return
    }
    let image = albumController.images[0]
    changeImageWithAnim(image: image)
    
    albumController.remove(usedImage: image)
    
    var interval = UserDefaults.standard.integer(forKey: Constants.UserDefaults.Key.refreshTime)
    interval = min(10, max(1,interval))
    delay(with: Double(interval), closure: {
      if self.playButton.status == .goToStop {
        self.showFirstImage()
      }
    })
  }
  
  private func changeImageWithAnim(image: UIImage) {
    
    guard let currentImage = self.imageView.image else {
      self.imageView.image = image
      return
    }
    let fadeAnim = CABasicAnimation(keyPath: "contents")
    fadeAnim.setValue("fadeAnim", forKey: "fadeAnimKey")
    fadeAnim.fromValue = currentImage
    fadeAnim.toValue = image
    fadeAnim.duration = 0.75
    self.imageView.layer.add(fadeAnim, forKey: "contents")
    self.imageView.image = image
  
  }
  
  func fetch(next: Photo) {

  }
  
  func show(next: Photo) {
    
  }
  
  func notifyDidFinishDisplay(of old: Photo) {
    
  }
}

extension AlbumDisplayViewController: AlbumControllerDelegate {
  func imageDidLoad() {
    if playButton.status == .loading {
      playButton.status = .goToPlay
      playButton.updateUI(with: .goToPlay)
    }
  }
}
