import Foundation

class SmallPaymentMethodInfoCard: BasePaymentMethodInfoCard {
    
    enum ConstraintValues {
        
        static let entityLeadingAnchor: CGFloat = 8
        
        static let amountLeadingAnchor: CGFloat = 12
        static let amountTopAnchor: CGFloat = 8
        static let amountTrailingAnchor: CGFloat = -16
        
        static let amountWithEntityLeadingAnchor: CGFloat = 8
        
        static let amountOnlyTopAnchor: CGFloat = 17
        static let amountOnlyTrailingAnchor: CGFloat = -16
        static let amountOnlyBottomAnchor: CGFloat = -18
        
        static let panLeadingAnchor: CGFloat = 16
        static let panTopAnchor: CGFloat = 12
        static let panBottomAnchor: CGFloat = -13
        
        static let paymentTypeLeadingAnchor: CGFloat = 12
        static let paymentTypeTrailingAnchor: CGFloat = -16
        static let paymentTypeBottomAnchor: CGFloat = -8
        
        static let paymentTypeWithEntityLeadingAnchor: CGFloat = 8
    }
    
    override func setupCornerRadius() {
        layer.cornerRadius = CardCornerRadiusManager.getCornerRadius(from: .small)
    }
    
    override func setupConstraints() {
//        pan.setContentHuggingPriority(.required, for: .horizontal)
//        pan.setContentHuggingPriority(.required, for: .vertical)
        setFixedConstraints()
        setEntityConstraintsIfNeeded()
//        setAmountAndPaymentTypeConstraints()
        setAmountConstraints()
        setPaymentTypeConstraintsIfNeeded()
        
    }
    
    private func setFixedConstraints() {
        self.addSubview(container)
        container.addSubview(gradient)
        container.addSubview(overlay)
        container.addSubview(amount)
        container.addSubview(pan)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            gradient.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradient.topAnchor.constraint(equalTo: self.topAnchor),
            gradient.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            gradient.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            overlay.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            overlay.topAnchor.constraint(equalTo: self.topAnchor),
            overlay.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            overlay.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            pan.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: ConstraintValues.panLeadingAnchor),
            pan.topAnchor.constraint(equalTo: container.topAnchor, constant: ConstraintValues.panTopAnchor),
            pan.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: ConstraintValues.panBottomAnchor)
        ])
    }
    
    private func setEntityConstraintsIfNeeded() {
        if pan.PANLabel.text == nil {
            container.addSubview(entity)
            
            NSLayoutConstraint.activate([
                entity.leadingAnchor.constraint(equalTo: pan.trailingAnchor, constant: ConstraintValues.entityLeadingAnchor),
                entity.centerYAnchor.constraint(equalTo: pan.centerYAnchor)
            ])
        }
    }
    
    private func setPaymentTypeConstraintsIfNeeded() {
        if paymentType.text != nil {
            container.addSubview(paymentType)
            
            NSLayoutConstraint.activate([
                paymentType.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: ConstraintValues.paymentTypeBottomAnchor),
                paymentType.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: ConstraintValues.paymentTypeTrailingAnchor)
                ])
            if container.subviews.contains(entity) {
                NSLayoutConstraint.activate([
                    paymentType.leadingAnchor.constraint(equalTo: entity.trailingAnchor, constant: ConstraintValues.paymentTypeWithEntityLeadingAnchor)
                ])
            } else {
                NSLayoutConstraint.activate([
                    paymentType.leadingAnchor.constraint(equalTo: pan.trailingAnchor, constant: ConstraintValues.paymentTypeLeadingAnchor)
                    ])
            }
        }
    }
    
    private func setAmountConstraints() {
        if paymentType.text == nil {
            NSLayoutConstraint.activate([
                amount.topAnchor.constraint(equalTo: container.topAnchor, constant: ConstraintValues.amountOnlyTopAnchor),
                amount.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: ConstraintValues.amountOnlyTrailingAnchor),
                amount.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: ConstraintValues.amountOnlyBottomAnchor)
                ])
        } else {
            NSLayoutConstraint.activate([
                amount.topAnchor.constraint(equalTo: container.topAnchor, constant: ConstraintValues.amountTopAnchor),
                amount.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: ConstraintValues.amountTrailingAnchor)
                ])
        }
            
            if container.subviews.contains(entity) {
                NSLayoutConstraint.activate([
                    amount.leadingAnchor.constraint(equalTo: entity.trailingAnchor, constant: ConstraintValues.amountWithEntityLeadingAnchor)
                ])
            } else {
                NSLayoutConstraint.activate([
                    amount.leadingAnchor.constraint(equalTo: pan.trailingAnchor, constant: ConstraintValues.amountLeadingAnchor)
                ])
            }
        }
    
    private func setAmountAndPaymentTypeConstraints() {
        if paymentType.text == nil {
            NSLayoutConstraint.activate([
                amount.topAnchor.constraint(equalTo: container.topAnchor, constant: ConstraintValues.amountOnlyTopAnchor),
                amount.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: ConstraintValues.amountOnlyTrailingAnchor),
                amount.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: ConstraintValues.amountOnlyBottomAnchor)
            ])
        } else {
            container.addSubview(paymentType)
            
            NSLayoutConstraint.activate([
                amount.topAnchor.constraint(equalTo: container.topAnchor, constant: ConstraintValues.amountTopAnchor),
                amount.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: ConstraintValues.paymentTypeTrailingAnchor),
                
                paymentType.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: ConstraintValues.paymentTypeBottomAnchor),
                paymentType.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: ConstraintValues.paymentTypeTrailingAnchor)
            ])
            
            if container.subviews.contains(entity) {
                NSLayoutConstraint.activate([
                    amount.leadingAnchor.constraint(equalTo: entity.trailingAnchor, constant: ConstraintValues.paymentTypeLeadingAnchor),
                    
                    paymentType.leadingAnchor.constraint(equalTo: entity.trailingAnchor, constant: ConstraintValues.paymentTypeLeadingAnchor)
                ])
            } else {
                NSLayoutConstraint.activate([
                    amount.leadingAnchor.constraint(equalTo: pan.trailingAnchor, constant: ConstraintValues.paymentTypeLeadingAnchor),
                    
                    paymentType.leadingAnchor.constraint(equalTo: pan.trailingAnchor, constant: ConstraintValues.paymentTypeLeadingAnchor)
                ])
            }
        }
    }
}
