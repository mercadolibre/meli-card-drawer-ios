//
//  TagBottomView.swift
//  MLCardDrawer
//
//  Created by Pedro Silva Dos Santos on 31/10/22.
//

import UIKit

public class TagBottomView: UIView {
    
    public init() {
        super.init(frame: .zero)
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var color: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    func addTagBottom() {
        setHighlightTagBottomView()
     }
    

    func setHighlightTagBottomView() {

          roundCorners(cornerRadiuns: 16, typeCorners: [.lowerLeft, .topLeft])
          preencherTagBottom(top: nil,
                                                    leading: nil,
                                                    trailing: self.trailingAnchor,
                                                    bottom: self.bottomAnchor,
                                                    padding: .init(top: 0, left: 0, bottom: -10, right: 0),
                                                    size: CGSize(width: 125, height: 30))
      }
}
