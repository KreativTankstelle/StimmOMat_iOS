//
//  AudioHandler.swift
//  StimmOMat
//
//  Created by Achim Friedland on 10.09.22.
//

import SwiftUI
import Foundation
import AVFoundation

class AudioHandler: NSObject, ObservableObject, AVAudioPlayerDelegate {

    @Published var isPlaying: Bool = false {
        willSet {
            //if newValue == true {
            //    playAudio()
            //}
        }
    }

    var audioPlayer = AVAudioPlayer()
    var onFinished: (Bool) -> Void

    override init() {
        onFinished = {_ in }
        super.init()
    }

    func playAudio(filename:   String,
                   onFinished: @escaping (Bool) -> Void = {_ in }) {
        
        let path = Bundle.main.path(forResource: filename, ofType: "mp3")!
        let url  = URL(fileURLWithPath: path)
        
        self.onFinished = onFinished

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            isPlaying = true
            audioPlayer.play()
        } catch {
            print("\(error)")
        }
        
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Finish playing")
        isPlaying = false
        self.onFinished(true)
    }
    
}
