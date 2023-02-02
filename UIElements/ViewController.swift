//
//  ViewController.swift
//  UIElements
//
//  Created by Igor Vologodskiy on 28.01.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
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
