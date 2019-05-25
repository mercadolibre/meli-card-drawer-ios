//
//  TypeCollectionCell.swift
//  Example_MeliCardDrawer
//
//  Created by Juan sebastian Sanzone on 5/22/19.
//  Copyright © 2019 Mercadolibre. All rights reserved.
//

import UIKit
import MLCardDrawer

final class TypeCollectionCell: UICollectionViewCell {
    static let identifier: String = "TypeCollectionCell"
    @IBOutlet weak var colorIndicador: UIView!
    @IBOutlet weak var image: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }
}

extension TypeCollectionCell {
    func setup(_ cardUIProtocol: CardUI) {
        colorIndicador.backgroundColor = cardUIProtocol.cardBackgroundColor
        image.image = cardUIProtocol.cardLogoImage as? UIImage
    }
}
