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
  
  fileprivate let moq = 3
  
}

extension AlbumController: AlbumManager {
  
  func requestPhotoFeeds() {
    NetworkingController.shared.fetchPhotoFeeds(responseWith: self)
  }
  
  func didUpdatePhotos() {
    
  }
  
  func remove(usedImage: UIImage) {
    guard let selectedIndex = images.index(of: usedImage) else {
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
      if failedToDownloadFirstPhoto {
        photos.remove(at: 0)
        downloadNewImages()
      } else {
        photos.remove(at: 0)
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
    print("didReceive photos, count: \(photos.count)")
  }
  
  func didReceiveTimeOut() {
    print("time out!! count: \(timeOutCount)")
    if timeOutCount < 2 {
      requestPhotoFeeds()
    } else {
      // error
    }
  }
  
  func didReceiveError(description: String) {
    requestPhotoFeeds()
  }
  
}

protocol AlbumControllerDelegate {
  func imageDidLoad()
}
