import UIKit

class StockDetailBottomView: BaseView {
    
    let investmentInputView = InputView()
    let costInputView = InputView()
    let dateInputView = InputView()
    let slider = UISlider()
    
    override func configureUI() {
        addSubview(investmentInputView)
        addSubview(costInputView)
        addSubview(dateInputView)
        addSubview(slider)
        
        investmentInputView.configureUI(placeholder: "Enter your initial investment amout",
                                        description: "initial investment amout")
     
        
        costInputView.configureUI(placeholder: "Monthly dollar cost averaging amout",
                                        description: "Monthly dollar cost averaging amout")
        
        dateInputView.configureUI(placeholder: "Enter your initial date of investment",
                                        description: "Enter your initial date of investment")
        
        investmentInputView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        investmentInputView.textField.keyboardType = .numberPad
        investmentInputView.textField.addDoneButton()
        
        costInputView.snp.makeConstraints { make in
            make.top.equalTo(investmentInputView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        costInputView.textField.keyboardType = .numberPad
        costInputView.textField.addDoneButton()
        
        dateInputView.snp.makeConstraints { make in
            make.top.equalTo(costInputView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        slider.snp.makeConstraints { make in
            make.top.equalTo(dateInputView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configureUI(currentcy: String) {
        investmentInputView.valueLabel.text = currentcy
    }
    
    class InputView: BaseView {
        let textField = UITextField()
        let descriptionLabel = SmallLabel()
        let valueLabel = NormalGrayLabel()
        
        override func configureUI() {
            textField.font = .systemFont(ofSize: 18)
            textField.autocorrectionType = .no
            
            addSubview(textField)
            addSubview(descriptionLabel)
            addSubview(valueLabel)
            
            textField.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
            }
            
            descriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(textField.snp.bottom).offset(8)
                make.leading.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            
            valueLabel.snp.makeConstraints { make in
                make.centerY.equalTo(descriptionLabel.snp.centerY)
                make.leading.equalTo(descriptionLabel.snp.trailing).offset(4)
            }
        }
        
        func configureUI(placeholder: String, description: String, value: String? = "") {
            self.textField.placeholder = placeholder
            self.descriptionLabel.text = description
            self.valueLabel.text = value
        }
    }
}
