//
//  extractAlbumArt.swift
//  Corn
//
//  Created by khush on 17/08/26.
//

import AVFoundation
import SwiftUI

func extractAlbumArt(from fileURL: URL) async -> UIImage? {
    let asset = AVURLAsset(url: fileURL)
    
    do {
        let formats = try await asset.load(.commonMetadata)
        let artworks = AVMetadataItem.metadataItems(from: formats, withKey: AVMetadataKey.commonKeyArtwork, keySpace: AVMetadataKeySpace.common)

        guard let firstArtwork = artworks.first,
              let data = try await firstArtwork.load(.value) as? Data else {
            return nil
        }
        return UIImage(data: data)
    } catch {
        print("Error extracting metadata: \(error.localizedDescription)")
        return nil
    }
}
