//
//  AlbumManager.swift
//  FlickrAlbum
//
//  Created by kimmyunghoon on 2017. 3. 11..
//  Copyright © 2017년 Raspberry Soft. All rights reserved.
//

import Foundation
import UIKit

protocol AlbumManager {
  func requestPhotoFeeds()
  func downloadNewImages()
  func remove(used: UIImage)
  func checkMoq()
}
