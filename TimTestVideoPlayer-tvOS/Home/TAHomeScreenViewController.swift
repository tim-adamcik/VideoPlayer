//
//  TAHomeScreenViewController.swift
//  TimTestVideoPlayer-tvOS
//
//  Created by Timothy Adamcik on 6/10/22.
//

import Foundation
import UIKit
import AVKit

class TAHomeScreenViewController: UIViewController {
    
    @IBOutlet private weak var playButton: UIButton! {
        didSet {
            playButton.layer.cornerRadius = 5.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func playButton(_ sender: Any) {
        playMovie()
    }
    
    private func playMovie() {
        guard let playerController: TAPlayerViewController = TAPlayerViewController(streamPath: "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8")  else {
            print("Player failed")
            return
        }
        
        present(playerController: playerController)
        
    }
        
    private func present(playerController: TAPlayerViewController) {
        if let navigationController: UINavigationController = navigationController {
            navigationController.pushViewController(playerController, animated: true)
        }
        else {
            playerController.modalPresentationStyle = .fullScreen
            present(playerController, animated: true)
        }
    }
    
    private func playAppleTest() {
        guard let url = URL(string: "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8") else { return }

        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)

        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player

        // Modally present the player and call the player's play() method when complete.
        present(controller, animated: true) {
            player.play()
        }
    }
    
}
