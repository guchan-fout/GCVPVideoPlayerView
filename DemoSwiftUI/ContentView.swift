//
//  ContentView.swift
//  DemoSwiftUI
//
//  Created by guchan on 2019/09/04.
//  Copyright © 2019 guchan. All rights reserved.
//

import SwiftUI
import AVKit

struct SuperHeroContentRow: View {
    let hero: HerosInfo


    @State var isShowingVideo = false

    var body: some View {
        VStack {
            //self.setVideoPlayer(url: hero.name)
            Image(hero.name).resizable().frame(width: 160, height: 90, alignment: .leading)
            Text(hero.name).font(.body)

            VideoViewWidge(avPlayer: self.setVideoPlayer(url: hero.name))

            /*
             Button(action: {
             print("button pressed")
             self.isShowingVideo.toggle()
             }) {
             Text("Youtube").foregroundColor(.red)
             }.sheet(isPresented: $isShowingVideo) {
             VideoView(videoName: self.hero.name)
             }
             */
        }
    }

    func setVideoPlayer(url:String) -> AVPlayer{
        let name = url + "Video"
        let videoPath = Bundle.main.path(forResource: name, ofType: "mp4")
        print("Vido name: \(videoPath)")
        let videoUrl = URL(fileURLWithPath: videoPath ?? "nothing")
        let videoItem = AVPlayerItem(url:videoUrl)
        let avPlayer = AVPlayer(playerItem: videoItem)
        return avPlayer
    }


}

struct ContentView: View {
    private let heros = HerosInfoAPI.getHeros()

    var body: some View {
        NavigationView {
            List {
                ForEach(heros) { hero in
                    NavigationLink(destination: VideoView(videoName: hero.name)){
                        SuperHeroContentRow(hero: hero)
                    }.frame(height: 330)
                }
            }
        }
    }
}



/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }

 */
