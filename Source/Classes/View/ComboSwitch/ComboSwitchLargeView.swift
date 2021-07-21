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
        switchControl.backgroundColor = UIColor.fromHex(switchModel.switchBackgroundColor)
        switchControl.selectorViewColor = UIColor.fromHex(switchModel.pillBackgroundColor)
        switchControl.selectorTextColor = UIColor.fromHex(switchModel.states.checked.textColor)
        switchControl.textColor = UIColor.fromHex(switchModel.states.unchecked.textColor)
        switchControl.buttonFont = switchModel.states.unchecked.weight.getFont().withSize(18)
        switchControl.buttonSelectedFont = switchModel.states.checked.weight.getFont().withSize(18)
        switchControl.setOptions(options: switchModel.options)
        switchControl.selectedOption = switchModel.defaultState
        comboLabel.textColor = UIColor.fromHex(switchModel.description.textColor ?? "")
        comboLabel.text = switchModel.description.message
        comboLabel.font = switchModel.description.weight?.getFont()
        backgroundColor = UIColor.fromHex(switchModel.safeZoneBackgroundColor)
    }
    
    override func change(to index: Int) {
        if let id = switchModel?.options[index].id, let callback = switchDidChangeCallback {
            switchControl.selectedOption = id
            callback(id)
        }
    }
}
