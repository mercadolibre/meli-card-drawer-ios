//
//  ComboSwitch.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 29/01/2021.
//

public class ComboSwitchLargeView: ComboSwitchView {
    
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
    
    override public func setSwitchModel(_ switchModel: SwitchModel) {
        self.switchModel = switchModel
        switchControl.delegate = self
        
        if let switchBorderColor = switchModel.switchBorderColor {
            switchControl.containerViewBorderColor = UIColor.fromHex(switchBorderColor).cgColor
        }
        switchControl.containerViewBackgroundColor = UIColor.fromHex(switchModel.switchBackgroundColor)
        switchControl.selectorViewColor = UIColor.fromHex(switchModel.pillBackgroundColor)
        switchControl.selectorTextColor = UIColor.fromHex(switchModel.states.checked.textColor)
        switchControl.textColor = UIColor.fromHex(switchModel.states.unchecked.textColor)
        switchControl.buttonFont = switchModel.states.unchecked.weight.getFont().withSize(13)
        switchControl.buttonSelectedFont = switchModel.states.checked.weight.getFont().withSize(13)
        switchControl.setOptions(options: switchModel.options)
        switchControl.selectedOption = switchModel.defaultState
        backgroundColor = UIColor.fromHex(switchModel.safeZoneBackgroundColor)
        guard let description = switchModel.description else {
            return
        }
        comboLabel.textColor = UIColor.fromHex(description.textColor ?? "")
        comboLabel.text = description.message
        comboLabel.font = description.weight?.getFont()
    }
    
    override func change(to index: Int) {
        if let id = switchModel?.options[index].id, let callback = switchDidChangeCallback {
            switchControl.selectedOption = id
            callback(id)
        }
    }
}
