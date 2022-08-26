//
//  ComboSwitchSmallView.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 01/07/2021.
//

public class ComboSwitchSmallView: ComboSwitchView {
    
    var switchModel : SwitchModel?
    
    @IBOutlet weak var switchControl: CustomSwitch!
    
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
    
    override public func setSwitchModel(_ switchModel: SwitchModel) {
        self.switchModel = switchModel
        switchControl.delegate = self
        if let switchBorderColor = switchModel.switchBorderColor {
            switchControl.containerViewBorderColor = UIColor.fromHex(switchBorderColor).cgColor
        }
        if let selectorBackgroundColor = switchModel.selectorBackgroundColor {
            switchControl.selectorViewColor = UIColor.fromHex(selectorBackgroundColor)
        }
        switchControl.pillBorderColor = UIColor.fromHex(switchModel.pillBackgroundColor)
        switchControl.containerViewBackgroundColor = UIColor.fromHex(switchModel.switchBackgroundColor)
        switchControl.selectorTextColor = UIColor.fromHex(switchModel.states.checked.textColor)
        switchControl.textColor = UIColor.fromHex(switchModel.states.unchecked.textColor)
        switchControl.buttonFont = switchModel.states.unchecked.weight.getFont().withSize(12)
        switchControl.buttonSelectedFont = switchModel.states.checked.weight.getFont().withSize(12)
        switchControl.setOptions(options: switchModel.options)
        switchControl.selectedOption = switchModel.defaultState
        backgroundColor = UIColor.clear
    }
    
    override func change(to index: Int) {
        if let id = switchModel?.options[index].id, let callback = switchDidChangeCallback {
            switchControl.selectedOption = id
            callback(id)
        }
    }
}
