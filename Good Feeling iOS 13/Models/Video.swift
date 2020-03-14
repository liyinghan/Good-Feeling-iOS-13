//
//  Video.swift
//  testYT
//
//  Created by han.li on 2020/3/9.
//  Copyright © 2020 jordanlake. All rights reserved.
//
//  MIT License

//  Copyright (c) 2017 Haik Aslanyan

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import UIKit

class Video {
    
    //MARK: Properties
    //    let thumbnail: UIImage?
    let title: String
    //    let views: Int
    //    let channel: Channel
    //    let duration: Int
    //    var videoLink: URL!
    //    let likes: Int
    //    let disLikes: Int
    //    var suggestedVideos = [SuggestedVideo]()
    
    //MARK: Inits
    //    init(title: String, channelName: String) {
    init(title: String) {
        
        //        self.thumbnail = UIImage.init(named: title)
        self.title = title
        //        self.views = Int(arc4random_uniform(1000000))
        //        self.duration = Int(arc4random_uniform(400))
        //        self.likes = Int(arc4random_uniform(1000))
        //        self.disLikes = Int(arc4random_uniform(1000))
        //        self.channel = Channel.init(name: channelName, image: UIImage.init(named: channelName))
    }
    
    //MARK: Methods
    class func fetchVideos(completion: @escaping (([Video]) -> Void)) {
        
        // randonly assign an array of video cells. this generates the maximun video cells
        var items:[Video] = Array()

        let limit = 2
        if items.count < limit {
            var index = items.count
            while index < limit {
                // to initilize a group of vides, just need to pass a title parameter
                items.append(Video.init(title: "Fitness"))
                index = index + 1
            }
            
            print("The maximun video pre-prepared initially is \(items.count)")
            //        items.myShuffle()
            completion(items)
        }
    } //end of fetch video
    
    //    class func fetchVideo(completion: @escaping ((Video) -> Void)) {
    //        let video = Video.init(title: "Big Buck Bunny", channelName: "Blender Foundation")
    //        video.videoLink = URL.init(string: "http://sample-videos.com/video/mp4/360/big_buck_bunny_360p_10mb.mp4")!
    //        let suggestedVideo1 = SuggestedVideo.init(title: "What Does Jared Kushner Believe haha", channelName: "Nerdwriter1")
    //        let suggestedVideo2 = SuggestedVideo.init(title: "Moore's Law Is Ending. So, What's Next", channelName: "Seeker")
    //        let suggestedVideo3 = SuggestedVideo.init(title: "What Bill Gates is afraid of", channelName: "Vox")
    //        let suggestedVideo4 = SuggestedVideo.init(title: "Why Can't America Have a Grown-Up Healthcare Conversation", channelName: "vlogbrothers")
    //        let suggestedVideo5 = SuggestedVideo.init(title: "TensorFlow Basics - Deep Learning with Neural Networks p. 2", channelName: "sentdex")
    //        let items = [suggestedVideo1, suggestedVideo2, suggestedVideo3, suggestedVideo4, suggestedVideo5]
    //        video.suggestedVideos = items
    //        completion(video)
    //        //    }
    //    }
    
//    struct SuggestedVideo {
//
//        let title: String
//        let channelName: String
//        let thumbnail: UIImage
//
//        init(title: String, channelName:String) {
//            self.title = title
//            self.channelName = channelName
//            self.thumbnail = UIImage.init(named: title)!
//        }
//    } // end of suggest video
//
//    class Channel {
//
//        let name: String?
//        let image: UIImage?
//        var subscribers = 0
//
//        class func fetchData(completion: @escaping (([Channel]) -> Void)) {
//            var items = [Channel]()
//            for i in 0...18 {
//                let name = ""
//                let image = UIImage.init(named: "channel\(i)")
//                let channel = Channel.init(name: name, image: image!)
//                items.append(channel)
//            }
//            items.myShuffle()
//            completion(items)
//        }
//
//
//        init(name: String, image: UIImage?) {
//            self.name = name
//            self.image = image
//        }
//    } // end of channel
} // end of video
