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

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var type: MLCardDrawerType = .large
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupExample()
    }
    
    func setupExample() {
        containerView.subviews.forEach { $0.removeFromSuperview() }
        
        let cardDrawer = MLCardDrawerController(CardUIExamples.Pix(), CardDataHandler(), false, type)
        
        let cardView = cardDrawer.getCardView()
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.masksToBounds = true
        
        containerView.addSubview(cardView)
        
        cardView.layer.borderColor = UIColor.black.cgColor
        cardView.layer.borderWidth = 1
        
        NSLayoutConstraint.activate([cardView.topAnchor.constraint(equalTo: containerView.topAnchor),
                                     cardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                                     cardView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                                     cardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)])
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            type = .large
        case 1:
            type = .medium
        case 2:
            type = .small
        default:
            break
        }
        setupExample()
    }
}
