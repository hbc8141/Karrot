//
//  ItemDetailController+collectionview.swift
//  Karrot
//
//  Created by User on 2021/07/23.
//

import UIKit

extension ItemImageCell:
    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame:CGRect = collectionView.frame
        print(frame)

        return CGSize(width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let item:Item = item else { return }
        
        let pageWidth:CGFloat = self.itemImageCollectionView.frame.size.width
        let currentPage:Int = Int(self.itemImageCollectionView.contentOffset.x / pageWidth)

        if currentPage == 0 && scrollView.contentOffset.x <= 0 {
            scrollView.contentOffset.x = 0
        }
        
        else if currentPage == item.imageUrl.count - 1 && scrollView.contentOffset.x > pageWidth {
            scrollView.contentOffset.x = pageWidth
        }
    }
}
