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
    self.photos = photos
    print("didReceive photos, count: \(photos.count)")
  }
}
