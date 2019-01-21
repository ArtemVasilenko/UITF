
import UIKit

class ViewController: UIViewController {
    
    let myTextField = UITextField()
    
    fileprivate func createTextFied() {
        myTextField.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        myTextField.borderStyle = .roundedRect
        myTextField.contentVerticalAlignment = .center
        myTextField.textAlignment = .center
        myTextField.placeholder = "placeholder"
        myTextField.center = self.view.center
        myTextField.clearButtonMode = .whileEditing
        view.addSubview(myTextField)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTextFied()
        myTextField.delegate = self
        
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: {nc in self.view.frame.origin.y = -200} ) //поднимает вью вверх при появлении клавы клавиатуры

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: {nc in self.view.frame.origin.y = 0})  //опускает вью на место при убирании клавы
        
        
        NotificationCenter.default.addObserver(self, selector: #selector (textDidChange(parametr:)), name: UITextField.textDidChangeNotification, object: nil)      //изменение текста
        
        }
    
    @objc func textDidChange(parametr: NSNotification) {
        print("textDidChange = \(parametr.name)")
    }
}



extension ViewController {
    func showToast(_ message: String) {
        let toastFrame = CGRect(x: self.view.frame.size.width/2-150, y: self.view.frame.size.height-180, width: 300, height: 180)
        let toastLabel = UILabel(frame: toastFrame)
        toastLabel.numberOfLines = 0 //сколько текста столько строк auto
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = false
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {toastLabel.alpha = 0.0}, completion: {(isCompleted) in toastLabel.removeFromSuperview()} )
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing: ща редактнём текстФилд")
        //showToast("textFieldShouldBeginEditing")
        return true //должно начаться редактирование
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //showToast("textFieldDidBeginEditing")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //showToast("textFieldShouldEndEditing")
        if textField.text == "12345" {
            return true
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //showToast("textFieldDidEndEditing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print(reason.rawValue)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        showToast("textFieldShouldClear")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == myTextField {
            self.myTextField.resignFirstResponder()
            return true
        }
        return false
    }
    //подключает возможность убрать клаву через ретюрн
    
}

