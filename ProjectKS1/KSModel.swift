//
//  KSModel.swift
//  ProjectKS1
//
//  Created by Estrella, Natalia [GCB-OT] on 4/15/18.
//  Copyright © 2018 Estrella, Natalia [GCB-OT]. All rights reserved.
//

import Foundation

struct GiphyResult: Codable {
    let data: [GiphyModel]
}

struct GiphyModel: Codable {
    let id : String?
    let slug : String?
    let url : String?
    let images : ImageModel?
}

struct ImageModel: Codable {
    let previewGif : GifModel?
    
    enum CodingKeys: String, CodingKey {
        case previewGif = "downsized_medium"
    }
}

struct GifModel: Codable {
    let url : String?
    let width : String?
    let height: String?
}
