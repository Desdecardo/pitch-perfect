//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Phil Feinstein on 3/29/15.
//  Copyright (c) 2015 Phil Feinstein. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController
{

    var Audioplayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
  @IBOutlet weak var HideStop: UIButton!

   override func viewWillAppear(animated: Bool) {
        HideStop.hidden = true
    

}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        Audioplayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        Audioplayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        }
        override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    
    }
    func playAudioWithVariablePitch(pitch: Float){
        
        Audioplayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    
    ///button that plays audio slowly
    @IBAction func SlowPlay(sender: UIButton) {
    HideStop.hidden = false
    Audioplayer.stop()
    Audioplayer.rate = 0.5
    Audioplayer.play()
    Audioplayer.currentTime = 0.0

    }
    
    
    
    ///button that plays audio at 2x speed
    @IBAction func FastPlay(sender: UIButton) {
    HideStop.hidden = false
    Audioplayer.stop()
    Audioplayer.rate = 2.0
    Audioplayer.play()
    Audioplayer.currentTime = 0.0
        
    }
    
    
    
    ///button that stops playback
    @IBAction func AllStop(sender: AnyObject) {
    Audioplayer.stop()
    HideStop.hidden = true
    
    
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
       Audioplayer.stop()
        playAudioWithVariablePitch(1000)
        
    }
    
    
    @IBAction func playVaderAudio(sender: UIButton) {
        Audioplayer.stop()
        playAudioWithVariablePitch(-800)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
