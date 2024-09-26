//
//  CollectionViewDataSourceDelegate.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/25/24.
//

import UIKit

extension ActivityViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredReportedActivities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as? ActivityCollectionViewCell {
            cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.systemBackground : UIColor(named: "CollectionSecondary")
            
            let activity = filteredReportedActivities[indexPath.row]
            cell.configure(with: activity)
            
            return cell
        }
        
        return UICollectionViewCell(frame: .zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width , height: 100)
    }
}
