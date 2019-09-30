//
//  VideoPlayerRepresentable.swift
//  GCVideoPlayer
//
//  Created by guchan on 2019/09/05.
//  Copyright © 2019 GUCHAN. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct VideoPlayerRepresentable: UIViewRepresentable {
    var url: URL

     func makeUIView(context: Context) -> GCVPVideoPlayerView {
        let frame = UIScreen.main.bounds

        let uiView = GCVPVideoPlayerView(frame: frame, videoUrl: url)
        //uiView.playToEndTime = { context.coordinator.playToEndTime() }
        //uiView.replay = { context.coordinator.replay() }
        //uiView.stateDidChanged = { context.coordinator.stateDidChanged($0) }
        return uiView
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateUIView(_ uiView: GCVPVideoPlayerView, context: Context) {
        //isPlay ? uiView.play(for: url) : uiView.pause(reason: .userInteraction)
        //uiView.isMuted = isMute
        //uiView.isAutoReplay = isAutoReplay
    }

    public class Coordinator: NSObject {
        var playerView: VideoPlayerRepresentable

        init(_ videoPlayerView: VideoPlayerRepresentable) {
            self.playerView = videoPlayerView
        }
    }
}

struct VideoView: View {
    var url: URL

    init(videoName: String) {
        let name = videoName + "Video"
        let videoPath = Bundle.main.path(forResource: name, ofType: "mp4")
        print("Video name: \(videoPath)")
        self.url = URL(fileURLWithPath: videoPath!)
    }

    var body: some View {
        VideoPlayerRepresentable(url: url)
    }
}

/*
struct VideoPlayerRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerRepresentable()
    }
}
 */
