//
//  ContentView.swift
//  DemoSwiftUI
//
//  Created by guchan on 2019/09/04.
//  Copyright © 2019 guchan. All rights reserved.
//

import SwiftUI


struct SuperHeroContentRow: View {
    let hero: HerosInfo
    @State var isShowingVideo = false

    var body: some View {
        HStack {
            Image(hero.name).resizable().frame(width: 160, height: 90, alignment: .leading)
            Text(hero.name).font(.body)
            Button(action: {
                print("button pressed")
                self.isShowingVideo.toggle()
                }) {
                    Text("Youtube").foregroundColor(.red)
            }.sheet(isPresented: $isShowingVideo) {
                VideoView(videoName: self.hero.name)
            }
        }
    }

    func doSomething () {

    }

}

struct ContentView: View {
    private let heros = HerosInfoAPI.getHeros()

    var body: some View {
        List {
            ForEach(heros) { hero in
                SuperHeroContentRow(hero: hero)
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
