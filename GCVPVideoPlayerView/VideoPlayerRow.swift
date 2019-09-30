//
//  VideoPlayerRow.swift
//  DemoSwiftUI
//
//  Created by guchan on 2019/09/25.
//  Copyright © 2019 guchan. All rights reserved.
//

import SwiftUI
import UIKit
import AVKit

struct VideoViewWidge: View {
    @ObservedObject var videoContainer: AVPlayerContainer
    //var avPlayer: AVPlayer

    /*
     init(avPlayer: AVPlayer) {
     self.avPlayer = avPlayer

     }
     */

    var body: some View {
        PlayerViewRow(avPlayer: videoContainer.getAVPlayer())
            .scaledToFit()
            .onTapGesture {
                //self.videoContainer.getAvPlayer().pause()
        }.onDisappear(){
            print(" PlayerViewRow onDisappear")
            //self.videoContainer.getAVPlayer().pause()
        }.onAppear(){
            print(" PlayerViewRow onAppear")
            //self.videoContainer.getAVPlayer().play()
        }
    }
}

struct PlayerViewRow: UIViewRepresentable {
    var avPlayer: AVPlayer
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerViewRow>) {
    }

    func makeUIView(context: Context) -> UIView {
        let frame = CGRect(x: 0.0, y: 0.0, width: 320, height: 200)
        return PlayerRowUIView(avPlayer: avPlayer, frame: frame)
    }
}

class PlayerRowUIView: UIView {
    var videoPlayer: AVPlayer!
    var playerLayer: AVPlayerLayer!

    init(avPlayer: AVPlayer,frame: CGRect ) {
        super.init(frame: frame)
        self.videoPlayer = avPlayer

        playerLayer = AVPlayerLayer(player: videoPlayer)
        playerLayer.backgroundColor = UIColor.clear.cgColor
        playerLayer.videoGravity = .resizeAspect
        self.layer.addSublayer(playerLayer)
        self.videoPlayer.play()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

/*
 struct VideoPlayerRow_Previews: PreviewProvider {
 static var previews: some View {
 VideoPlayerRow()
 }
 }
 */


