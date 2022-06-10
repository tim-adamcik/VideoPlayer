//
//  TAPlayerViewController.swift
//  TimTestVideoPlayer-tvOS
//
//  Created by Timothy Adamcik on 6/10/22.
//

import Foundation
import AVFoundation
import AVKit

class TAPlayerViewController: AVPlayerViewController {
    
    private var streamPath: String?
    private var mediaSelectionOption: AVMediaSelectionOption?
    private var mediaSelectionGroup: AVMediaSelectionGroup?
    private var mediaThumbnailImage: UIImage?
    private var mediaDescription: String?
    
    // Metadata
    private var mediaTitle: String?
    
    private var playerItem: AVPlayerItem? = nil {
        didSet {
            if let playerItem: AVPlayerItem = playerItem {
                playerItem.canUseNetworkResourcesForLiveStreamingWhilePaused = true
                player?.replaceCurrentItem(with: playerItem)
                setMediaSelectionOption(for: playerItem)
                addPlayerItemMetadataOutputDelegate()
            }
            else {
                print("Remove time observers")
            }
        }
    }
    
    convenience init?(streamPath: String?) {
        guard
            let path: String = streamPath,
            let _: URL = URL(string: path)
        else { return nil }
        
        self.init()
        self.streamPath = path
    }
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        self.mediaTitle = "BipBop"
        self.mediaDescription = "This is the metadata for bipbop"
        
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player = AVPlayer()
        setupPlayback()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func setupPlayback() {
        guard
            let mediaPath: String = streamPath,
            let assetURL: URL = URL(string: mediaPath)
        else {
            print("Error")
            return
        }
        
        let asset: AVURLAsset = AVURLAsset(url: assetURL)
            
        playerItem = AVPlayerItem(asset: asset)
        setupMetadata()
        player?.play()
    }
    
    private func setMediaSelectionOption(for playerItem: AVPlayerItem) {
        DispatchQueue.global(qos: .background).async {
            if let group: AVMediaSelectionGroup = playerItem.asset.mediaSelectionGroup(forMediaCharacteristic: AVMediaCharacteristic.legible) {
                let selectedMediaOption: AVMediaSelectionOption? = group.options.first
                self.mediaSelectionOption = selectedMediaOption
                self.mediaSelectionGroup = group
                DispatchQueue.main.async {
                    print("Update closed captionstate")
                }
            }
            else {
                DispatchQueue.main.async {
                    print("Closed caption not enabled")
                }
            }
        }
    }
    
    // MARK: - Timed Metadata Observer
    private func addPlayerItemMetadataOutputDelegate() {
        let playerItemMetadataOutput: AVPlayerItemMetadataOutput = AVPlayerItemMetadataOutput(identifiers: nil)
        playerItemMetadataOutput.setDelegate(self, queue: .main)
        player?.currentItem?.add(playerItemMetadataOutput)
    }
    
    private func setupMetadata() {
        var metadataItems: [AVMetadataItem] = []
        
        if mediaTitle != nil {
            let titleItem: AVMutableMetadataItem = AVMutableMetadataItem()
            titleItem.locale = Locale.current
            titleItem.identifier = .commonIdentifierTitle
            titleItem.value = mediaTitle! as NSString
            metadataItems.append(titleItem)
        }
        
        if let description: String = mediaDescription {
            let descriptionItem: AVMutableMetadataItem = AVMutableMetadataItem()
            descriptionItem.locale = Locale.current
            descriptionItem.identifier = .commonIdentifierDescription
            descriptionItem.value = description as NSString
            metadataItems.append(descriptionItem)
        }
        
        playerItem?.externalMetadata = metadataItems
    }

}



extension TAPlayerViewController: AVPlayerViewControllerDelegate {
    
}

extension TAPlayerViewController: AVPlayerItemMetadataOutputPushDelegate {
    
    // MARK: - AVPlayerItemMetadataOutputPushDelegate
    func metadataOutput(_ output: AVPlayerItemMetadataOutput, didOutputTimedMetadataGroups groups: [AVTimedMetadataGroup], from track: AVPlayerItemTrack?) {
        let timedMetadata: [AVMetadataItem] = groups.flatMap({ $0.items })
        guard !timedMetadata.isEmpty else { return }
        print("timed meta data = \(timedMetadata)")
    }
    
}
