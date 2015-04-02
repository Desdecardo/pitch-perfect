//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Phil Feinstein on 3/29/15.
//  Copyright (c) 2015 Phil Feinstein. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var RecordButton: UIButton!
    
    @IBOutlet weak var Recording: UILabel!
    
    @IBOutlet weak var StopButton: UIButton!
   
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
StopButton.hidden = true
RecordButton.enabled = true
    
    }

    @IBAction func RecordSound(sender: UIButton) {
Recording.hidden = false
StopButton.hidden = false
RecordButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag){
        recordedAudio = RecordedAudio()
        recordedAudio.filePathUrl = recorder.url
        recordedAudio.title = recorder.url.lastPathComponent
        
            self.performSegueWithIdentifier("StopRecording", sender: recordedAudio)
        
        }else{
            println("recording unsuccessful!")
            RecordButton.enabled = true
            StopButton.hidden = true
        }
    }
    
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "StopRecording"){
        let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
    
        let data = sender as RecordedAudio
        playSoundsVC.receivedAudio = data
        
    }
    
    
    }
    
    @IBAction func StopButton(sender: UIButton) {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)        
Recording.hidden = true
RecordButton.enabled = true

        
    }

       
    
    
    
    
    
}

