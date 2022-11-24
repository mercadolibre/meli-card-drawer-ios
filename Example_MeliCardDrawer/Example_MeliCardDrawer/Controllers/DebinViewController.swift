//
//  DebinViewController.swift
//  Example_MeliCardDrawer
//
//  Created by Gisela Araceli Ramos Carrasco on 19/01/2022.
//  Copyright © 2022 Mercadolibre. All rights reserved.
//

import Foundation
import UIKit
import MLCardDrawer

class DebinViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    
    var cardType: MLCardDrawerTypeV3 = .large
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.addTarget(nil, action: #selector(valueChanged), for: .valueChanged)
        setupCard(cardType: cardType)
    }
    
    @objc func valueChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cardType = .large
            containerViewHeightConstraint.constant = 250
            
        case 1:
            cardType = .small
            containerViewHeightConstraint.constant = 105
            
        default:
            break
        }
        
        setupCard(cardType: cardType)
    }
    
    private func setupCard(cardType: MLCardDrawerTypeV3) {
        containerView.subviews.forEach { $0.removeFromSuperview() }
        
        let cardDrawer = MLCardDrawerController(cardUI: CardUIExamples.Debin(), cardType, CardDataHandler())
                
        let cardView = cardDrawer.getCardView()
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.masksToBounds = true
        
        containerView.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: containerView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cardView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            cardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)])
    }
}
