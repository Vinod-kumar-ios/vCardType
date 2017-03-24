//
//  CardTypeAndValidatorTextField.swift
//  VCardType
//
//  Created by MAC on 23/03/17.
//  Copyright © 2017 MAC. All rights reserved.
//

import UIKit




 protocol vCardTypeDelegates
{
    func vCardType(cardName:String)
    func vTextChange(text:String , textField:UITextField)
    
    
  
    
}


class CardTypeAndValidatorTextField: UITextField,UITextFieldDelegate
{
   
    var vcardDelegate:vCardTypeDelegates?
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        delegate = self
        
         self.leftViewMode = UITextFieldViewMode.always
         self.leftView = UIImageView(image: UIImage(named: "Bankcard"))
         self.keyboardType = .numberPad
         self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
    }
    
    
    func textFieldDidChange(_ textField: UITextField)
    {
        vcardDelegate?.vTextChange(text: textField.text!, textField: textField)
        if((textField.text?.characters.count)! > 3)
        {
            let strNameOfCard =  typeOfCard(from: textField.text!)
            self.leftViewMode = UITextFieldViewMode.always
            self.leftView = UIImageView(image: UIImage(named: strNameOfCard!))
            
            
            vcardDelegate?.vCardType(cardName: strNameOfCard!)
            //imageView?.image = UIImage(named:strNameOfCard!)
            print(strNameOfCard)
        }
        else
        {
            self.leftViewMode = UITextFieldViewMode.always
            self.leftView = UIImageView(image: UIImage(named: "Bankcard"))
        }
        
    }
    
    func typeOfCard(from text: String) -> String?
    {
        for type in CardTypeAndValidatorTextField.types
        {
            let predicate = NSPredicate(format: "SELF MATCHES %@", type["regex"]!)
            if predicate.evaluate(with: text)
            {
                return type["name"]!
            }
        }
        return nil
    }
    
   
    
    
    private static let types = [
        [
            "name": "Amex",
            "regex": "^3[47][0-9]{5,}$"
        ],
        [
            "name": "Visa",
            "regex": "^4\\d{0,}$"
        ],
        [
            "name": "MasterCard",
            "regex": "^5[1-5]\\d{0,14}$"
        ],
        [
            "name": "Maestro",
            "regex": "^(?:5[0678]\\d\\d|6304|6390|67\\d\\d)\\d{8,15}$"
        ],
        [
            "name": "DinersClub",
            "regex": "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
        ],
        [
            "name": "JCB",
            "regex": "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
        ],
        [
            "name": "Discover",
            "regex": "^6(?:011|5[0-9]{2})[0-9]{3,}$"
        ],
        [
            "name": "UnionPay",
            "regex": "^62[0-5]\\d{13,16}$"
        ],
        [
            "name": "mir",
            "regex": "^22[0-9]{1,14}$"
        ],
        [
            "name": "Electron",
            "regex": "^(4026|417500|4405|4508|4844|4913|4917)\\d+$"
        ],
        [
            "name": "Dankort",
            "regex": "^(5019)\\d+$"
        ],
        [
            "name":  "RuPay",
            "regex": "^(6061|6062|6063|6064|6065|6066|6067|6068|6069|607|608)\\d+$"
        ]
    ]
    
    
    
}
