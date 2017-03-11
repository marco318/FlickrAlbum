//
//  AlbumController.swift
//  FlickrAlbum
//
//  Created by kimmyunghoon on 2017. 3. 11..
//  Copyright © 2017년 Raspberry Soft. All rights reserved.
//

import Foundation

class AlbumController: AlbumManager {
  
  func requestPhotoFeeds() {
    NetworkingController.shared.fetchPhotoFeeds(responseWith: self)
  }
  
  func parse(photoFeeds: PhotoFeeds) -> [Photo] {
    return []
  }
  
  func didUpdatePhotos() {
    
  }
  
  func remove(old: Photo) {
    
  }
}

extension AlbumController: FlickrApiResponseHandler {
  func didReceive(photoFeeds: PhotoFeeds?) {
    print("didReceive photoFeeds from AlbumController")
  }
}
