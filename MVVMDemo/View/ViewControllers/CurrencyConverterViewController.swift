//
//  CurrencyConverterViewController.swift
//  MVVMDemo
//
//  Created by Muazam on 20/02/2022.
//

import UIKit

class CurrencyConverterViewController: UIViewController {

    ///:- Outlets
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField! {
        didSet {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            let image = UIImage(named: "dollar")
            imageView.image = image
            amountTextField.leftViewMode = .always
            amountTextField.leftView = imageView
        }
    }
    
    ///:- Veriables
    var selectedCurrency : CurrencyRate?
    var ratePrice : Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupVC()
    }
    
    func setupVC(){
        navigationItem.leftItemsSupplementBackButton = true
        btnConvert.layer.cornerRadius = 25
        hideKeyboardWhenTappedAround()
        amountTextField.delegate = self
        setupData()
    }
    
    func setupData(){
        if let model = selectedCurrency {
            self.title = model.currencyIso
            totalLabel.text = "0"
            rateLabel.text = "\(model.rate)"
            currencyNameLabel.text = model.currencyIso
            ratePrice = model.rate
        }
    }

    @objc
    func backTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func convertButtonAction(_ sender: UIButton) {
        guard let strAmount = amountTextField.text , !strAmount.isEmpty else {
            totalLabel.text = "0"
            AlertControllerHelper.showAlert(message: "Please enter amount.", vc: self)
            return
        }
        let amount = Double(strAmount)! * ratePrice
        totalLabel.text = String(format: "%.2f", amount)
    }
    
}

extension CurrencyConverterViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        // Allow to remove character (Backspace)
        if string == "" {
            return true
        }

       // Block multiple dot
        if (textField.text?.contains("."))! && string == "." {
            return false
        }

        // Check here decimal places
        if (textField.text?.contains("."))! {
            let limitDecimalPlace = 2
            let decimalPlace = textField.text?.components(separatedBy: ".").last
            if (decimalPlace?.count)! < limitDecimalPlace {
                return true
            }
            else {
                return false
            }
        }
        return true
    }
}
