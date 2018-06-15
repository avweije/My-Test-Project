//
//  ViewController.swift
//  My Test Project
//
//  Created by Adriaan van Weije on 27/05/2018.
//  Copyright © 2018 Adriaan van Weije. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var genderComboBox: AWComboBox!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var genderComboBox2: AWComboBox!
    @IBOutlet weak var otherComboBox: AWComboBox!
    
    @IBOutlet weak var languageButton: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        birthDatePicker.layer.borderColor = UIColor.black.cgColor
        birthDatePicker.layer.borderWidth = 1
        
        addBorder(birthDatePicker, side: .Top, color: .white)
        //addBorder(birthDatePicker, side: .Bottom, color: .orange)

        addBorder(birthDatePicker, side: .Left, color: .white)
        //addBorder(birthDatePicker, side: .Right, color: .brown)
        
        //
        //genderComboBox = AWComboBox(self.view)
        print("self.view: \(self.view)")
        
        //genderComboBox.dataSource = ["Man","Vrouw","Transgender"]
        genderComboBox.textAlignment = .left
        genderComboBox2.dataSource = ["Man","Vrouw","Transgender","Bankstel","Stoel","Autootje","Vrouw","Transgender","Bankstel","Stoel","Autootje","Vrouw","Transgender","Bankstel","Stoel","Autootje","Vrouw","Transgender","Bankstel","Stoel","Autootje","Vrouw","Transgender","Bankstel","Stoel","Autootje"]
        
        //
        //UIApplication.shared.la
        let langCode = Locale.current.languageCode
        let prefLanguages = Locale.preferredLanguages
        let langDesc = Locale.current.localizedString(forLanguageCode: langCode!)
        
        print("languageCode: \(String(describing: langCode))")
        print("languageCode: \(String(describing: langDesc))")
        print("preferredLanguages: \(String(describing: prefLanguages))")

        languageButton.setTitle(langDesc, for: .normal)

        do {
            let path = Bundle.main.path(forResource: "whoosh", ofType: "mp3")!
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: path))
            audioPlayer.prepareToPlay()
        } catch {
            print(error)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //genderComboBox.setParentView(self.view)
        //otherComboBox.setParentView(self.view)
        //genderComboBox2.setParentView(self.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            //
            playAudio()
        }
    }
    
    private func playAudio() {
        audioPlayer.play()
    }
}

