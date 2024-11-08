//
//  ArchiveViewController+RecordingList.swift
//  RadioScanner
//
//  Created by Brendan Perry on 10/20/24.
//

import UIKit
import MobileVLCKit

extension ArchiveViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recordings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recordingCell", for: indexPath as IndexPath) as? ArchiveCollectionViewCell {
            cell.backgroundColor = indexPath.row % 2 != 0 ? UIColor.systemBackground : UIColor(named: "CollectionSecondary")
            
            let recording = recordings[indexPath.row]
            cell.configure(with: recording) { [weak self] id in
                // play audio
                self?.videoPlayer.media = VLCMedia(url: URL(string: "https://scanwc.com/assets/php/archives/archive_download.php?rs=yes&id=\(id)")!)
                self?.videoPlayer.position = self?.videoPlayer.media.le
                self?.videoPlayer.play()
                print(id)
            }
            
            return cell
        }
        
        return UICollectionViewCell(frame: .zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width , height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
