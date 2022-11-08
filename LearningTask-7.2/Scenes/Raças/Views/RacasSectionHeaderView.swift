//
//  RacasSectionHeaderView.swift
//  LearningTask-7.2
//
//  Created by Italo cavalcanti on 07/11/22.
//

import UIKit

class RacasSectionHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var titleLabel: UILabel!
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            titleLabel.text = title
        }
    }
    
}
