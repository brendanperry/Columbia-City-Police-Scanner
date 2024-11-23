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
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityCell", for: indexPath as IndexPath) as? ActivityCollectionViewCell {
            cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.systemBackground : UIColor(named: "CollectionSecondary")
            
            let activity = filteredReportedActivities[indexPath.row]
            cell.configure(with: activity) { [weak self] in
                if let archiveViewController = self?.tabBarController?.viewControllers?[2] as? ArchiveViewController {
                    self?.tabBarController?.selectedIndex = 2
                    
                    let selectedDate = self?.datePicker.date ?? Date()
                    let timeComponents = activity.time.split(separator: ":")
                    if let hour = Int(timeComponents[0]), let minute = Int(timeComponents[1]) {
                        let date = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: selectedDate)
                        archiveViewController.datePicker.date = date ?? selectedDate
                        Task {
                            await archiveViewController.loadData()
                        }
                    }
                }
            }
            
            return cell
        }
        
        return UICollectionViewCell(frame: .zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 100)
    }
}
