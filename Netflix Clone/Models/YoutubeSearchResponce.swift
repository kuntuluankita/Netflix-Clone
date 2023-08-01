//
//  YoutubeSearchResponce.swift
//  Netflix Clone
//
//  Created by K Praveen Kumar on 01/08/23.
//

import Foundation

struct YoutubeSearchResponse:Codable {
    let items: [VideoElement]
}

struct VideoElement:Codable {
    let id: IdVideoElement
}

struct IdVideoElement:Codable{
    let kind: String?
    let videoId: String?
}


