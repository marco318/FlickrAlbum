//
//  FlickrApiResponseHandler.swift
//  FlickrAlbum
//
//  Created by kimmyunghoon on 2017. 3. 11..
//  Copyright © 2017년 Raspberry Soft. All rights reserved.
//

import Foundation

protocol FlickrApiResponseHandler {
  func didReceive(photos: [Photo])
  func didReceiveTimeOut()
  func didReceiveError(description: String)
}
