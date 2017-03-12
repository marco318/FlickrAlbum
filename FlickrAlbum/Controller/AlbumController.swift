//
//  AlbumController.swift
//  FlickrAlbum
//
//  Created by kimmyunghoon on 2017. 3. 11..
//  Copyright © 2017년 Raspberry Soft. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


class AlbumController {
  
  var delegate: AlbumControllerDelegate?
  
  fileprivate(set) var photos: [Photo] = []
  fileprivate(set) var images: [UIImage] = []
  fileprivate var timeOutCount = 0
  fileprivate var errorCount = 0
  
  fileprivate let moq = 3
  /// moq: minimum order quantity
}

extension AlbumController: AlbumManager {
  
  func requestPhotoFeeds() {
    NetworkingController.shared.fetchPhotoFeeds(responseWith: self)
  }
  
  func remove(used: UIImage) {
    guard let selectedIndex = images.index(of: used) else {
      return
    }
    images.remove(at: selectedIndex)
    checkMoq()
  }
 
  func checkMoq() {
    if images.count < moq {
      downloadNewImages()
    }
  }
  
  func downloadNewImages() {
    guard photos.count > 0 else {
      requestPhotoFeeds()
      return
    }
    
    var failedToDownloadFirstPhoto = false
    defer {
      photos.remove(at: 0)
      if failedToDownloadFirstPhoto {
        downloadNewImages()
      }
      if photos.count < moq {
        requestPhotoFeeds()
      }
    }
    
    let downloader = SDWebImageDownloader.shared()
    guard let urlString = photos[0].urlString else {
      failedToDownloadFirstPhoto = true
      return
    }
    
    downloader.downloadImage(
      with: URL(string: urlString),
      options: [],
      progress: nil,
      completed: { image, data, error, finished in
        if let image = image {
          self.images.append(image)
          self.delegate?.imageDidLoad()
        } else {
          failedToDownloadFirstPhoto = true
        }
        self.checkMoq()
    })
    
  }
}

extension AlbumController: FlickrApiResponseHandler {
  func didReceive(photos: [Photo]) {
    timeOutCount = 0
    self.photos = photos
    checkMoq()
  }
  
  func didReceiveTimeOut() {
    timeOutCount += 1
    if timeOutCount < 2 {
      requestPhotoFeeds()
    } else {
      delegate?.tooMuchTimeOutDidOccur()
    }
  }
  
  func didReceiveError(description: String) {
    errorCount += 1
    if errorCount < 5 {
      requestPhotoFeeds()
    } else {
      delegate?.tooMuchErrorDidOccur()
    }
  }
  
}

protocol AlbumControllerDelegate {
  func imageDidLoad()
  func tooMuchTimeOutDidOccur()
  func tooMuchErrorDidOccur()
}
