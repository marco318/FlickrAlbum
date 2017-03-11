//
//  AlbumManager.swift
//  FlickrAlbum
//
//  Created by kimmyunghoon on 2017. 3. 11..
//  Copyright © 2017년 Raspberry Soft. All rights reserved.
//

import Foundation

protocol AlbumManager {
  func parse(photoFeeds: PhotoFeeds) -> [Photo]
  func didUpdatePhotos()
  func remove(old: Photo)
}
