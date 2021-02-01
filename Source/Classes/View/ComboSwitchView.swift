//
//  ComboSwitch.swift
//  MLCardDrawer
//
//  Created by Jonathan Scaramal on 29/01/2021.
//

public class ComboSwitchView: UIView {
    
    var switchModel : SwitchModel?
    
    var switchDidChangeCallback : ((_ selectedOption: String) -> Void)?
    
    @IBOutlet weak var switchControl: UISegmentedControl!
    
    @IBAction func switchDidChange(_ sender: Any) {
        if let selectedOption = switchModel?.options[switchControl.selectedSegmentIndex], let callback = switchDidChangeCallback {
            callback(selectedOption.id)
        }
    }
    
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
    
    public func setSwitchModel(_ switchModel : SwitchModel) {
        
        self.switchModel = switchModel
        
        for (index, option) in switchModel.options.enumerated() {
            
            switchControl.setTitle(option.name, forSegmentAt: index)
            switchControl.setEnabled(option.enabled, forSegmentAt: index)
            
            if(switchModel.defaultState == option.id) {
                switchControl.selectedSegmentIndex = index
            }
            
        }
        
    }
    
    public func setSwitchDidChangeCallback(switchDidChangeCallback: @escaping (_ selectedOption: String) -> Void) {
        self.switchDidChangeCallback = switchDidChangeCallback
    }
}
