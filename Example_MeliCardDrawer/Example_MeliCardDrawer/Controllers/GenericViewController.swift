//
//  GenericViewController.swift
//  Example_MeliCardDrawer
//
//  Created by Vinicius De Andrade Silva on 27/04/21.
//  Copyright © 2021 Mercadolibre. All rights reserved.
//

import UIKit
import MLCardDrawer

class GenericViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var gradientColorsSwitch: UISwitch!
    
    var cardType: MLCardDrawerTypeV3 = .large
    var cardTemplate = CardUIExamples.Pix()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientColorsSwitch.addTarget(nil, action: #selector(enabledGradientColors), for: .valueChanged)
        segmentedControl.addTarget(nil, action: #selector(changedValue), for: .valueChanged)
        setupCard(cardType: cardType)
    }
    
    @objc func enabledGradientColors() {
        cardTemplate.gradientColors = gradientColorsSwitch.isOn ? ["#132F3B", "#3688AB", "#37B4AA"] : [""]
        cardTemplate.labelBackgroundColor = gradientColorsSwitch.isOn ? "#FFFFFF" : "#1A479AD1"
        setupCard(cardType: cardType)
    }
    
    @objc func changedValue() {
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
        
        let cardDrawer = MLCardDrawerController(cardUI: cardTemplate, cardType, CardDataHandler())
                
        let cardView = cardDrawer.getCardView()
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.masksToBounds = true
        
        containerView.addSubview(cardView)
        
        cardView.layer.borderColor = UIColor.black.cgColor
        cardView.layer.borderWidth = 1
        cardView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: containerView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cardView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            cardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
}
