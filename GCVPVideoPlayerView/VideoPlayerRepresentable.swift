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
    @ObservedObject var videoPlayerContainer: AVPlayerContainer
    //var videoContainer: GCVPVideoPlayerContainer

     func makeUIView(context: Context) -> GCVPVideoPlayerView {
        let frame = UIScreen.main.bounds

        let uiView = GCVPVideoPlayerView(frame: frame, videoUrl: url, videoPlayer: videoPlayerContainer.getAVPlayer())

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

struct FullScreenVideoView: View {
    var url: URL
    var videoContainer: AVPlayerContainer

    init(videoName: String, container: AVPlayerContainer) {
        let name = videoName + "Video"
        let videoPath = Bundle.main.path(forResource: name, ofType: "mp4")
        print("Video name: \(String(describing: videoPath))")
        self.url = URL(fileURLWithPath: videoPath ?? "nothing")
        self.videoContainer = container
    }

    var body: some View {
        VideoPlayerRepresentable(url: url, videoPlayerContainer: videoContainer)
    }
}

/*
struct VideoPlayerRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerRepresentable()
    }
}
 */
