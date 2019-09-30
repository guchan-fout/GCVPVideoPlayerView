//
//  GCVPVideoPlayerView..swift
//
//  Created by gc on 2019/02/08.
//  Copyright © 2019 gc. All rights reserved.
//

import UIKit
import AVKit

class GCVPVideoPlayerView: UIView {
    var videoUrl:URL
    var videoPlayer: AVPlayer
    var playerLayer: AVPlayerLayer!
    var originalCenter:CGPoint!
    var endedPosition:CGPoint!
    var yOffset:CGFloat! = 200
    var originalFrame:CGRect!
    var shrinkedFrame:CGRect!
    var shrinkedHeight:CGFloat! = 80
    var isShrinked:Bool


    init(frame: CGRect, videoUrl: URL, videoPlayer: AVPlayer ){
        print("init")
        self.videoUrl = videoUrl
        self.isShrinked = false
        self.videoPlayer = videoPlayer
        super.init(frame:frame)
        /*
        let videoItem = AVPlayerItem(url:self.videoUrl)

        videoPlayer = AVPlayer(playerItem: videoItem)
         */

        playerLayer = AVPlayerLayer(player: self.videoPlayer)
        playerLayer.backgroundColor = UIColor.clear.cgColor
        playerLayer.videoGravity = .resizeAspect
        self.layer.addSublayer(playerLayer)
        self.originalFrame = self.frame

        let button   = UIButton(type: UIButton.ButtonType.system) as UIButton
        let image = UIImage(named: "close") as UIImage?
        let buttonWidth = self.shrinkedHeight * 0.6
        button.frame = CGRect(x:self.frame.width - buttonWidth, y:buttonWidth/2, width:buttonWidth, height:buttonWidth)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(closeBtnClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.addSubview(button)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGesture(sender:)))
        self.addGestureRecognizer(panGestureRecognizer)
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        print("layoutSubviews")
        //init UI or reset UI to fullscreen
        if !self.isShrinked {
            //safeAreaInset can only get from layoutSubviews
            self.shrinkedFrame = CGRect(x:0,y:self.bounds.height-shrinkedHeight-self.safeAreaInsets.bottom,width:self.bounds.width,height:shrinkedHeight)

            let playerWidth = self.bounds.width
            let playerHeight = playerWidth/(16/9)
            let yPos = (self.bounds.height-playerHeight)/2
            self.playerLayer.frame = CGRect(x:0,y:yPos,width:playerWidth,height:playerHeight)
            self.playerLayer.player?.play()
        }else { //shrink UI to bottom
            print("shrink")
            //self.playerLayer.videoGravity = .resizeAspect
            self.playerLayer.frame = CGRect(x:0,y:0,width:self.shrinkedHeight*(16/9),height:self.shrinkedHeight)
        }
    }

    @objc func panGesture(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            originalCenter = self.center
        case .changed:
            if !self.isShrinked {
                if sender.translation(in: self).y>0 {
                    self.center = CGPoint(x:originalCenter.x,y:originalCenter.y + sender.translation(in: self).y)
                }
            } else {
                if sender.translation(in: self).y<0 {
                    self.center = CGPoint(x:originalCenter.x,y:originalCenter.y + sender.translation(in: self).y)
                }

            }

        case .ended:
            print("ended")
            endedPosition = sender.translation(in: self)
            if !self.isShrinked {
                if endedPosition.y>yOffset {
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        print("shrinkedFrame \(self.shrinkedFrame)")
                        self.isShrinked = true
                        self.frame = self.shrinkedFrame
                    })
                }else {
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.center = self.originalCenter
                    })
                }
            }else {
                print("endedPosition \(endedPosition)")
                if endedPosition.y < (yOffset * -1) {
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        //self.center = self.originalCenter
                        self.frame = self.originalFrame
                        print("self.frameframe \(self.frame)")
                    })
                    self.isShrinked = false
                }else {
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        //self.center = self.originalCenter
                        self.frame = self.shrinkedFrame
                    })
                }
            }
        default:
            break
        }
    }

    @objc func closeBtnClicked(sender: UIButton) {
        self.removeFromSuperview()
    }
}







