import RxSwift
import RxCocoa

extension UITextField {
    func addDoneButton() {
        let screenWidth = UIScreen.main.bounds.width
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 50))
        toolbar.barStyle = .default
        
        let flexBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        
        let items = [flexBarButtonItem, doneBarButtonItem]
        toolbar.items = items
        toolbar.sizeToFit()
        inputAccessoryView = toolbar
    }
    
    @objc private func dismissKeyboard() {
        resignFirstResponder()
    }
}

extension UITextField {
    public func createRxDelegateProxy() -> RxTextFieldDelegateProxy {
        return RxTextFieldDelegateProxy(textField: self)
    }
}
