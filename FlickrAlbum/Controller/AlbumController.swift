//
//  AlbumController.swift
//  FlickrAlbum
//
//  Created by kimmyunghoon on 2017. 3. 11..
//  Copyright © 2017년 Raspberry Soft. All rights reserved.
//

import Foundation

class AlbumController: AlbumManager {
  
  fileprivate(set) var photos: [Photo] = []
  fileprivate var timeOutCount = 0
  
  func requestPhotoFeeds() {
    NetworkingController.shared.fetchPhotoFeeds(responseWith: self)
  }
  
  func didUpdatePhotos() {
    
  }
  
  func remove(old: Photo) {
    
  }
}

extension AlbumController: FlickrApiResponseHandler {
  func didReceive(photos: [Photo]) {
    timeOutCount = 0
    self.photos = photos
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
    // error
  }
  
}
