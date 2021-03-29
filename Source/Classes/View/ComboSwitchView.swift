//
//  ComboSwitch.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 29/01/2021.
//

public class ComboSwitchView: UIView {
    
    var switchModel : SwitchModel?
    
    var switchDidChangeCallback : ((_ selectedOption: String) -> Void)?
    
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
        switchControl.delegate = self
        switchControl.backgroundColor = UIColor.fromHex(switchModel.switchBackgroundColor)
        switchControl.selectorViewColor = UIColor.fromHex(switchModel.pillBackgroundColor)
        switchControl.selectorTextColor = UIColor.fromHex(switchModel.states.checked.textColor)
        switchControl.textColor = UIColor.fromHex(switchModel.states.unchecked.textColor)
        switchControl.buttonFont = switchModel.states.unchecked.weight.getFont()
        switchControl.buttonSelectedFont = switchModel.states.checked.weight.getFont()
        switchControl.setOptions(options: switchModel.options)
        switchControl.selectedOption = switchModel.defaultState
        comboLabel.textColor = UIColor.fromHex(switchModel.description.textColor ?? "")
        comboLabel.text = switchModel.description.text
        comboLabel.font = switchModel.description.weight?.getFont()
        backgroundColor = UIColor.fromHex(switchModel.safeZoneBackgroundColor)
    }
    
    public func setSwitchDidChangeCallback(switchDidChangeCallback: @escaping (_ selectedOption: String) -> Void) {
        self.switchDidChangeCallback = switchDidChangeCallback
    }
}

extension ComboSwitchView: CustomSwitchDelegate {
    func change(to index: Int) {
        if let id = switchModel?.options[index].id, let callback = switchDidChangeCallback {
            callback(id)
        }
    }
}
