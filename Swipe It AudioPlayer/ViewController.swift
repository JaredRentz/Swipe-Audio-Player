//
//  ViewController.swift
//  Swipe It AudioPlayer
//
//  Created by Jared Rentz on 1/14/16.
//  Copyright © 2016 UXOThings LLC. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    
    var player = AVAudioPlayer()
    
    
    let songs = ["Solid","Million","Show You","Snakeships","Spotless Mind"]
    let artist = ["TyDolla Sign","Tink","Justin Beiber","Tinashe","Jhene Aiko"]
    let artistImage = ["TyDollaSign.png","Tink.png","Justin Beiber.png","Tinashe.png","Jhene.png"]
    
    var currentPosition = 0
    
    

    @IBOutlet weak var imageShadow: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipe:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        
        image.layer.cornerRadius = 8.0
        
        imageShadow.layer.shadowRadius = 10
        imageShadow.layer.shadowOpacity = 1
        imageShadow.layer.shadowOffset = CGSizeMake(10.0, 8.0)
        imageShadow.layer.shadowColor = UIColor.blackColor().CGColor
        
        image.clipsToBounds = true

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func swipe (gesture:UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                
                
                
                let arr = Int(songs.count) - 1
              
                
                if currentPosition == arr {
                    
                    currentPosition--
                    playnextSong()
    
                }
                
                  currentPosition++
                  playnextSong()
 
            case UISwipeGestureRecognizerDirection.Left:
               let arr = Int(songs.count) - 1
              
                
                if currentPosition == 0 {
                    
                    currentPosition = arr
                    playnextSong()
                    
                }
                if currentPosition > 0{
                currentPosition--
                playnextSong()
                }
                
            default:
                break
            }
        }
    }
    


    @IBAction func onPlayPressed(sender: AnyObject) {
       playnextSong()
        
        
    }

    @IBAction func onStopPressed(sender: AnyObject) {
        player.pause()
        
        let filePath = NSBundle.mainBundle().pathForResource("Solid", ofType: ".mp3")
        
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: filePath!))
            
        } catch {
            
            print("ERROR")
            
        }

        
    }
    
    func playnextSong () {
        
        let songPlaying = songs[currentPosition]
        let currentArtist = artistImage[currentPosition]
        let artistTitle = artist[currentPosition]
        
        
        
        artistName.text = "\(artistTitle) - \(songPlaying)"
        
        image.image = UIImage(named: currentArtist)
        
       
        
        
        
        let filePath = NSBundle.mainBundle().pathForResource(songPlaying, ofType: ".mp3")
        
        do {
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: filePath!))
            player.play()
            
        } catch {
            
            print("ERROR")
            
        }
    }
    

    
}

