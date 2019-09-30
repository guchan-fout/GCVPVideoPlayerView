//
//  ContentView.swift
//  DemoSwiftUI
//
//  Created by guchan on 2019/09/04.
//  Copyright © 2019 guchan. All rights reserved.
//

import SwiftUI
import AVKit

struct ContentView: View {
    private let heros = HerosInfoAPI.getHeros()

    var body: some View {
        NavigationView {
            List {
                ForEach(heros) { hero in
                    //NavigationLink(destination: FullScreenVideoView(videoName: hero.name)){
                    SuperHeroContentRow(hero: hero).frame(height: 330)
                   //   }.frame(height: 330)
                }
            }
        }
    }
}

struct SuperHeroContentRow: View {
    var hero: HerosInfo
    // @ObservedObject var videoPlayerContainer: GCVPVideoPlayerContainer = GCVPVideoPlayerContainer()
    var videoPlayerContainer: AVPlayerContainer = AVPlayerContainer()

    var body: some View {
        VStack {
            Text(hero.name).font(.title)
            self.setVideoPlayer(url: hero.name).hidden()

            NavigationLink(destination: VideoPlayerFullScreenView(videoContainer: videoPlayerContainer)) {
                //Text("Show Detail View")
                VideoViewWidge(videoContainer: videoPlayerContainer)
            }
        }.onAppear(){
            print("onAppear")
            //self.videoPlayerContainer.setAVPlayer(videoPlayer: self.setVideoPlayer(url: self.hero.name))
        }.onTapGesture{
            //self.setVideoPlayerCurrentTime(avPlayer: self.videoPlayerContainer.videoPlayer)
            print("onTapGesture pressed")
        }.onDisappear() {
            print("onDisappear pressed")
            //self.videoPlayerContainer.getAvPlayer().pause()
        }
    }

    func setVideoPlayer(url:String) -> Text {
        videoPlayerContainer.createAvPlayer(url: url)
        return Text("")
    }
}



/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }

 */
