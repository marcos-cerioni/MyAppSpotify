//
//  AudioPlayerViewController.swift
//  MyApp
//
//  Created by Marcos Cerioni on 05/11/2021.
//

import UIKit
import AudioPlayer
import AVFoundation

class AudioPlayerViewController: UIViewController {

    var song: AudioPlayer?
    var timeActual: Any? = 0
    var track: Track?
    var isPlaying: Bool = true

    var volumeSlider: UISlider = {
        let slide = UISlider()
        slide.autoresizingMask = .flexibleWidth
        slide.translatesAutoresizingMaskIntoConstraints = false
        slide.value = 1
        slide.addTarget(self, action: #selector(slider2Touch(_ :)), for: .valueChanged)
        return slide
    }()
    
    var songSlider: UISlider = {
        let sliderSong = UISlider()
        sliderSong.autoresizingMask = .flexibleWidth
        sliderSong.translatesAutoresizingMaskIntoConstraints = false
        sliderSong.addTarget(self, action: #selector(sliderSongChange(_ :)), for: .valueChanged)
        return sliderSong
    }()
    
    var playButton: UIButton = {
        let play = UIButton(type: .system)
        play.setTitle("Play", for: .normal)
        play.autoresizingMask = .flexibleWidth
        play.translatesAutoresizingMaskIntoConstraints = false
        play.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        return play
    }()
    
    var stopButton: UIButton = {
        let stop = UIButton(type: .system)
        stop.setTitle("Stop", for: .normal)
        stop.autoresizingMask = .flexibleWidth
        stop.translatesAutoresizingMaskIntoConstraints = false
        stop.addTarget(self, action: #selector(stopAction), for: .touchUpInside)
        return stop
    }()
    
    var volumeLabel: UILabel = {
        let labelVolume = UILabel()
        labelVolume.text = "Volumen"
        labelVolume.font = UIFont.systemFont(ofSize: 15)
        labelVolume.autoresizingMask = .flexibleWidth
        labelVolume.translatesAutoresizingMaskIntoConstraints = false
        labelVolume.textAlignment = .left
        return labelVolume
    }()
    
    var dismissButton: UIButton = {
        let dismissBtn = UIButton(type: .system)
        dismissBtn.setTitle("dismiss", for: .normal)
        dismissBtn.autoresizingMask = .flexibleWidth
        dismissBtn.translatesAutoresizingMaskIntoConstraints = false
        dismissBtn.addTarget(self, action: #selector(dismissFunc), for: .touchUpInside)
        return dismissBtn
    }()
    
    var gifImage: UIImageView = {
        let imageGif = UIImageView()
        imageGif.autoresizingMask = .flexibleWidth
        imageGif.translatesAutoresizingMaskIntoConstraints = false
        return imageGif
    }()
    
    @objc func dismissFunc() {
        dismiss(animated: true)
    }

    @objc func slider2Touch(_ sender:UISlider!) {
        song?.volume = volumeSlider.value
        print("slider volumen se ajustó en \(sender.value)")
    }

    @objc func playAction() {
        if !isPlaying {
            song?.play()
            song?.volume = volumeSlider.value
            isPlaying = true
        }
    }
    
    @objc func stopAction() {
        if isPlaying {
            song?.fadeOut()
            isPlaying = false
        }
    }
    
    @objc func sliderSongChange(_ sender:UISlider) {
        self.timeActual = song?.currentTime
        self.song?.currentTime = TimeInterval((songSlider.value))
    }

    @objc func updateSlider(){
        self.songSlider.value = Float(song!.currentTime)
    }

    
    var currentSong: UILabel = {
        let songLabel = UILabel()
        songLabel.font = UIFont.systemFont(ofSize: 30)
        songLabel.backgroundColor = UIColor(red: 0.0, green: 1.1, blue: 0.5, alpha: 1.0)
        songLabel.autoresizingMask = .flexibleWidth
        songLabel.translatesAutoresizingMaskIntoConstraints = true
        songLabel.textAlignment = .center
        return songLabel
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        track?.isPlaying = true
        do {
            song = try AudioPlayer(fileName: "musica.mp3")
            song?.play()
            // Timer que va cambiando el timpo de cancion
            timeActual = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
        }
        catch{
            print("Song inicialized failed")
        }
        
        super.viewDidLoad()

        currentSong.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50)
        currentSong.text = track?.title
        self.view.addSubview(currentSong)

        view.addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: currentSong.bottomAnchor, constant: 20),
            playButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
        ])
        
        view.addSubview(stopButton)
        NSLayoutConstraint.activate([
            stopButton.topAnchor.constraint(equalTo: currentSong.bottomAnchor, constant: 20),
            stopButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25)
        ])
        
        songSlider.maximumValue = Float(song?.duration ?? 10000.0)
        view.addSubview(songSlider)
        NSLayoutConstraint.activate([
            songSlider.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20),
            songSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            songSlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25)
        ])
        

        view.addSubview(volumeLabel)
        NSLayoutConstraint.activate([
            volumeLabel.topAnchor.constraint(equalTo: songSlider.bottomAnchor, constant: 25),
            volumeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            volumeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25)
        ])

        view.addSubview(volumeSlider)
        NSLayoutConstraint.activate([
            volumeSlider.topAnchor.constraint(equalTo: volumeLabel.bottomAnchor, constant: 25),
            volumeSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            volumeSlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
        ])
        
        view.addSubview(gifImage)
        NSLayoutConstraint.activate([
            gifImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            gifImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            gifImage.heightAnchor.constraint(lessThanOrEqualToConstant: 210),
            gifImage.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
        
        
        view.addSubview(dismissButton)
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: volumeSlider.bottomAnchor, constant: 20),
            dismissButton.leadingAnchor.constraint(equalTo: volumeSlider.leadingAnchor)
        ])


        let path = Bundle.main.path(forResource: "gif", ofType: "gif")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        gifImage.image = UIImage.animatedImage(withAnimatedGIFData: data)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeButtonIcon")
                                        ,object: self.track?.isPlaying)
    }

    override func viewWillDisappear(_ animated: Bool) {
        if !self.isBeingPresented {
            song?.fadeOut()
            isPlaying = false
        }
        track?.isPlaying = isPlaying

    }
    
    // Shake
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if isPlaying {
            song?.fadeOut()
            isPlaying = false
        } else {
            song?.play()
            song?.volume = volumeSlider.value
            isPlaying = true
        }
    }
}
