//
//  AVPlayerContainer.swift
//  DemoSwiftUI
//
//  Created by guchan on 2019/09/29.
//  Copyright © 2019 guchan. All rights reserved.
//

import SwiftUI
import AVKit
import Combine

class AVPlayerContainer: ObservableObject {
    @Published var videoPlayer: AVPlayer = AVPlayer()
    @Published var currentTime: CMTime = CMTime()

    private var observation: NSKeyValueObservation?
    private var playerItem: AVPlayerItem?
    @Published var playerLayer: AVPlayerLayer?

    func createAvPlayer(url: String) {
        let name = url + "Video"
        let videoPath = Bundle.main.path(forResource: name, ofType: "mp4")
        print("Vido name: \(String(describing: videoPath))")
        let videoUrl = URL(fileURLWithPath: videoPath ?? "nothing")
        playerItem = AVPlayerItem(url: videoUrl)
        videoPlayer = AVPlayer(playerItem: playerItem)

        playerLayer = AVPlayerLayer(player: videoPlayer)
        playerLayer?.backgroundColor = UIColor.clear.cgColor
        playerLayer?.videoGravity = .resizeAspect
        self.startObservation()
    }

    func setAVPlayer(videoPlayer: AVPlayer) {
        print("setAvPlayer currentTime: \(String(describing: videoPlayer.currentItem?.currentTime()))")
        self.videoPlayer = videoPlayer
        self.currentTime = videoPlayer.currentTime()
    }

    func getAVPlayer() -> AVPlayer {
        print("getAvPlayer currentTime: \(String(describing: videoPlayer.currentItem?.currentTime()))")
        return self.videoPlayer
    }

    func getAVPlayerLayer() -> AVPlayerLayer {
        print("getAVPlayerLayer \(String(describing: videoPlayer.currentItem?.currentTime()))")
        return self.playerLayer!
    }


    func setVideoPlayerCurrentTime(avPlayer: AVPlayer) {
        //let current = avPlayer.currentTime()
        let currentTime: Float64 = CMTimeGetSeconds(avPlayer.currentTime())
        print("setVideoPlayerCurrentTime: \(String(describing: currentTime))")
        //videoPlayerContainer.setAVPlayer(videoPlayer: avPlayer)

    }

    func startObservation() {
        guard self.observation == nil else {
            return
        }

        // `AVPlayer.status`は存在しないファイルURLでもreadyToPlayになるので，`AVPlayerItem.status`の変化を監視
        self.observation = self.playerItem?.observe(\.status) { item, change in
            switch item.status {
            case .readyToPlay:
                print("Completed")
                    //self.finishLoading(.success(self.player!))

            case .failed:
                print("Failed")
                    //self.finishLoading(.failed)

            case .unknown:
                // unknownは初期値のため，この処理は実行されない
                print("unknown")
                break
                @unknown default:
                fatalError("Error failed")
            }
        }
    }
}


