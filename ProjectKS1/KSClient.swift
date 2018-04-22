//
//  KSClient.swift
//  ProjectKS1
//
//  Created by Estrella, Natalia [GCB-OT] on 4/18/18.
//  Copyright © 2018 Estrella, Natalia [GCB-OT]. All rights reserved.
//

import Foundation


protocol KSClientDelegate {
    func foundGif(gifModels:[GifModel])
}

class KSClient  {
    let delegate : KSClientDelegate
    
    init(delegate : KSClientDelegate) {
        self.delegate = delegate
    }
    
    func searchImage(searchTerm: String) {
        DispatchQueue.global(qos: .background).async {
            // Background Thread
            if let url = URL(string:"https://api.giphy.com/v1/gifs/search?api_key=229ac3e932794695b695e71a9076f4e5&limit=25&offset=0&rating=G&lang=en&q=\(searchTerm)"),
                let jsonData = try? Data(contentsOf: url),
                let giphyData = try? JSONDecoder().decode(GiphyResult.self, from: jsonData) {                
                let gifModels = giphyData.data.flatMap({ (giphyModel) -> GifModel? in
                    return giphyModel.images?.previewGif
                })
                // Main Thread
                DispatchQueue.main.async {
                    self.delegate.foundGif(gifModels: gifModels)
                }
            } else {
                // Main Thread
                DispatchQueue.main.async {
                    self.delegate.foundGif(gifModels: [])
                }
            }
        }
    }
}
