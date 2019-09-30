//
//  VideoPlayerFullScreenView.swift
//  DemoSwiftUI
//
//  Created by guchan on 2019/09/29.
//  Copyright © 2019 guchan. All rights reserved.
//

import SwiftUI
import UIKit
import AVKit

struct VideoPlayerFullScreenView: View {
    @ObservedObject var videoContainer: AVPlayerContainer
    //var avPlayer: AVPlayer

    init(videoContainer: AVPlayerContainer) {
        self.videoContainer = videoContainer
    }

    var body: some View {
        VideoPlayerFullScreenViewRepresentable(avPlayer: self.videoContainer.getAVPlayer())
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .onDisappear(){
                print(" VideoPlayerFullScreenView onDisappear")
                //self.videoContainer.getAVPlayer().pause()
        }.onAppear(){
            print(" VideoPlayerFullScreenView onAppear")
            //self.videoContainer.getAVPlayer().play()
        }
    }
}

struct VideoPlayerFullScreenViewRepresentable: UIViewRepresentable {
    var avPlayer: AVPlayer

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoPlayerFullScreenViewRepresentable>) {
    }

    func makeUIView(context: Context) -> UIView {
        let frame = UIScreen.main.bounds
        return PlayerFullScreenUIView(avPlayer: avPlayer, frame: frame)
    }
}

class PlayerFullScreenUIView: UIView {
    var videoPlayer: AVPlayer!
    var playerLayer: AVPlayerLayer!
    private var playerItem: AVPlayerItem?

    init(avPlayer: AVPlayer,frame: CGRect ) {
        super.init(frame: frame)
        self.videoPlayer = avPlayer
        self.playerItem = self.videoPlayer.currentItem
        playerLayer = AVPlayerLayer(player: videoPlayer)

        backgroundColor = .lightGray
        playerLayer.videoGravity = .resizeAspect
        self.layer.addSublayer(playerLayer)
        //self.videoPlayer.play()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = UIScreen.main.bounds
    }
}
