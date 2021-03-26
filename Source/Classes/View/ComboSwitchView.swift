//
//  ComboSwitch.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 29/01/2021.
//

public class ComboSwitchView: UIView {
    
    var switchModel : SwitchModel?
    
    @IBOutlet weak var switchControl: CustomSwitch!
    @IBOutlet weak var comboLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        loadFromNib()
    }
    
    public func setSwitchModel(_ switchModel: SwitchModel) {
        self.switchModel = switchModel
        switchControl.backgroundColor = UIColor(hexaRGB: switchModel.switchBackgroundColor)
        switchControl.selectorViewColor = UIColor(hexaRGB: switchModel.pillBackgroundColor)!
        switchControl.selectorTextColor = UIColor(hexaRGB: switchModel.states.checked.textColor)!
        switchControl.textColor = UIColor(hexaRGB: switchModel.states.unchecked.textColor)!
        switchControl.defaulSelection = switchModel.defaultState
        switchControl.setOptions(options: switchModel.options)
        comboLabel.textColor = UIColor(hexaRGB: switchModel.description.textColor!)
        comboLabel.text = switchModel.description.text
        backgroundColor = UIColor(hexaARGB: switchModel.safeZoneBackgroundColor)
    }
    
    public func getSelectedSwitchOption() -> SwitchOption? {
        return switchControl.selectedOption 
    }
}
