//
//  ListaDeRacasViewCell.swift
//  LearningTask-7.2
//
//  Created by Italo cavalcanti on 07/11/22.
//

import UIKit

class ListaDeRacasViewCell: UICollectionViewCell {
    
    @IBOutlet weak var racaImageView: UIImageView!
    @IBOutlet weak var racaLabel: UILabel!
    
    var raca: Raca? {
        didSet {
            guard let raca = raca else { return }
            racaImageView.image = UIImage(named: raca.nome)
            racaLabel.text = raca.nome
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        racaImageView.layer.masksToBounds = true
        racaImageView.layer.cornerRadius = contentView.bounds.width / 2
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        layoutAttributes.frame.size.height = size.height

        setNeedsLayout()
        return layoutAttributes
    }
    
}
