//
//  ViewController.swift
//  UIElements
//
//  Created by Igor Vologodskiy on 28.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var uiElements = ["UISegmentedControl",
                      "UILabel",
                      "UISlider",
                      "UITextField",
                      "UIButton",
                      "UIDatePicker"]
    
    var selectedElement: String?
    
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        slider.value = 1
        
        label.text = String(slider.value)
        label.font = label.font.withSize(35)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: true)
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .yellow
        slider.maximumTrackTintColor = .red
        slider.thumbTintColor = .blue
        
        //DatePicker localization
        datePicker.locale = Locale(identifier: "en_US")
        
        choiceUiElement()
        createTollbar()
    }
        
    func choiceUiElement() {
            
            let elementPicker = UIPickerView()
            elementPicker.delegate = self
            
            textField.inputView = elementPicker
        
            //Customization
        elementPicker.backgroundColor = .brown
    }
    
    func createTollbar() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissKeyboard))
        
        //button placement
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolbar
        
        //Customization
        toolbar.tintColor = .white
        toolbar.barTintColor = .brown
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideAllElements() {
        segmentedControl.isHidden = true
        slider.isHidden = true
        label.isHidden = true
        doneButton.isHidden = true
        datePicker.isHidden = true
    }
    
    
    @IBAction func switchAction(_ sender: UISwitch) {
        segmentedControl.isHidden = !segmentedControl.isHidden
        label.isHidden = !label.isHidden
        slider.isHidden = !slider.isHidden
        datePicker.isHidden = !datePicker.isHidden
        textField.isHidden = !textField.isHidden
        doneButton.isHidden = !doneButton.isHidden
        
        if sender.isOn {
            switchLabel.text = "Show elements"
        } else {
            switchLabel.text = "Hide elements"
        }
    }
    
    @IBAction func choiceSegment(_ sender: UISegmentedControl) {
        
        label.isHidden = false
        
        switch segmentedControl.selectedSegmentIndex {
        
        case 0:
            label.text = "The first segment selected"
            label.textColor = .red
            
        case 1:
            label.text = "The second segment selected"
            label.textColor = .blue
        
        case 2:
            label.text = "The third segment selected"
            label.textColor = .yellow
            
        default:
            print("Something went wrong!")
        }
    }
    @IBAction func changeDate(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        
        //Date localization
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let dateValue = dateFormatter.string(from: sender.date)
        
        label.text = dateValue
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        label.text = String(sender.value)
        
        let backgroundColor = self.view.backgroundColor
        self.view.backgroundColor = backgroundColor?.withAlphaComponent(CGFloat(sender.value))
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        
        guard textField.text?.isEmpty == false else { return }
        
        if let _ = Double(textField.text!) {
            showAlert(
                title: "Wrong format",
                message: "Please enter letters")
        } else {
            
            label.text = textField.text
            textField.text = nil
        }
    }
}

extension ViewController {
    private func showAlert (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addTextField {  (textFieldAlert: UITextField) -> Void in
            textFieldAlert.placeholder = "Enter your name"
        }
        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
//        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedElement = uiElements[row]
        textField.text = selectedElement
        
        switch row {
        case 0:
            hideAllElements()
            segmentedControl.isHidden = false
        case 1:
            hideAllElements()
            label.isHidden = false
        case 2:
            hideAllElements()
            slider.isHidden = false
        case 3:
            hideAllElements()
        case 4:
            hideAllElements()
            doneButton.isHidden = false
        case 5:
            datePicker.isHidden = false
        default:
            hideAllElements()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        
        var pickerViewLabel = UILabel()
        
        if let currentLabel = view as? UILabel {
            pickerViewLabel = currentLabel
        } else {
            pickerViewLabel = UILabel()
        }
        
        pickerViewLabel.textColor = .white
        pickerViewLabel.textAlignment = .center
        pickerViewLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 23)
        pickerViewLabel.text = uiElements[row]
        
        return pickerViewLabel
    }
}
