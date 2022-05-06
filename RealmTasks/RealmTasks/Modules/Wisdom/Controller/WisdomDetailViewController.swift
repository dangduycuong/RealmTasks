//
//  WisdomDetailViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 05/05/2022.
//

import UIKit

class WisdomDetailViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    let pickerDataSize = 100_000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPicker()
    }
    
    func setupPicker() {
        pickerView.dataSource = self
        pickerView.delegate = self
        
        // set the picker to the middle of the long list
        pickerView.selectRow(pickerDataSize/2, inComponent: 0, animated: false)
        pickerView.selectRow(pickerDataSize/2, inComponent: 1, animated: false)
        pickerView.selectRow(pickerDataSize/2, inComponent: 2, animated: false)
        pickerView.selectRow(pickerDataSize/2, inComponent: 3, animated: false)
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return String(row % 10)
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // do something with the resulting selected row
        print("cdd didSelectRow", component, row)
        // reset the picker to the middle of the long list
        let position = pickerDataSize/2 + row
        pickerView.selectRow(position, inComponent: 0, animated: false)
    }
    
    // columns count
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    // rows count
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSize
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            if let bold = PlayfairDisplayFont.bold(with: 20) {
                pickerLabel?.font = bold
            }

            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = String(row % 10)
        pickerLabel?.textColor = UIColor.white

        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row % 10)
    }
}
