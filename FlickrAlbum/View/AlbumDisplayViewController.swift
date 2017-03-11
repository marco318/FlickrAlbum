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
    sender.flip()
    playButtonDidClicked()
  }
  
  @IBAction func onTouchTimerButton(_ sender: Any) {
    AlertManager().show(.timer, from: self)
  }
  
}

extension AlbumDisplayViewController: AlbumDisplay {

  
  func playButtonDidClicked() {
    guard albumController.images.count > 0 else {
      print("no image")
      return
    }
    let image = albumController.images[0]
    imageView.image = image
    
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
