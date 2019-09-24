//
//  VideoContents.swift
//  GCVideoPlayer
//
//  Created by gc on 2019/02/10.
//  Copyright © 2019 gc. All rights reserved.
//

import Foundation
import SwiftUI

struct  HerosInfo: Identifiable{
    var id = UUID()
    let name:String
    let company:String
    let video:String
    let web:String
}

class HerosInfoAPI {
    static func getHeros() -> [HerosInfo]{

        let heros = [
            HerosInfo(name:"Superman",company:"DC",video:"",web:"https://en.wikipedia.org/wiki/Superman"),
            HerosInfo(name:"Batman",company:"DC",video:"",web:"https://en.wikipedia.org/wiki/Batman"),
            HerosInfo(name:"Flash",company:"DC",video:"",web:"https://en.wikipedia.org/wiki/Flash_(comics)"),
            HerosInfo(name:"Auqaman",company:"DC",video:"",web:"https://en.wikipedia.org/wiki/Aquaman"),
            HerosInfo(name:"Ironman",company:"Marvel",video:"",web:"https://en.wikipedia.org/wiki/Tony_Stark_(Marvel_Cinematic_Universe)"),
            HerosInfo(name:"Spiderman",company:"Marvel",video:"",web:"https://en.wikipedia.org/wiki/Spider-Man"),
            HerosInfo(name:"Greenlantern",company:"DC",video:"",web:"https://en.wikipedia.org/wiki/Green_Lantern"),
        ]
        return heros
    }
}
