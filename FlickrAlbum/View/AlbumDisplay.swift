//
//  AlbumDisplay.swift
//  FlickrAlbum
//
//  Created by kimmyunghoon on 2017. 3. 11..
//  Copyright © 2017년 Raspberry Soft. All rights reserved.
//

import Foundation

protocol AlbumDisplay {
  func fetch(next: Photo)
  func show(next: Photo)
  func notifyDidFinishDisplay(of old: Photo)
}
