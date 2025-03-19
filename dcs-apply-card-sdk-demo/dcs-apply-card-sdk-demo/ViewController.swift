//
//  ViewController.swift
//  dcs-apply-card-sdk-demo
//
//  Created by Ran on 2025/3/19.
//

import UIKit
import DcsCardSdk

class ViewController: UIViewController {

    @IBOutlet weak var orgCode: UITextField!
    @IBOutlet weak var orgKey: UITextField!
    @IBOutlet weak var areaCode: UITextField!
    @IBOutlet weak var phone: UITextField!
    var authen: String?
    @IBOutlet weak var logView: UITextView!
    var logText = NSMutableString()
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var nationality: UITextField!
    @IBOutlet weak var idNo: UITextField!
    @IBOutlet weak var idType: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var postCode: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var productCode: UITextField!
    @IBOutlet weak var cardType: UITextField!
    @IBOutlet weak var cardFlag: UITextField!
    @IBOutlet weak var partnerID: UITextField!
    @IBOutlet weak var cardFace: UITextField!
    @IBOutlet weak var externalWorkflowId: UITextField!
    @IBOutlet weak var cardToken: UITextField!
    @IBOutlet weak var environment: UITextField!
    @IBOutlet weak var custIdToken: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        logText = NSMutableString()
        if let orgCode = orgCode.text {
            userId.text = orgCode
        }
        orgCode.addTarget(
            self,
            action: #selector(userIdChange(_:)),
            for: .editingChanged
        )
        let tag = UITapGestureRecognizer(
            target: self,
            action: #selector(assignKeyboard)
        )
        view.addGestureRecognizer(tag)
    }

    @objc
    private func userIdChange(_ textField: UITextField) {
        guard let userId = textField.text else { return }
        self.userId.text = "\(userId)-01"
    }

    @objc
    private func assignKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Authorization
    func authorization() {
        let orgCodeText = orgCode.text ?? ""
        let orgKeyText = orgKey.text ?? ""
        let areaCodeText = areaCode.text ?? ""
        let phoneText = phone.text ?? ""
        let bizCodeText = "470101"
        let partnerIDText = partnerID.text ?? ""
        let externalUserIDText = userId.text ?? ""
        let externalWorkflowIDText = externalWorkflowId.text ?? ""
        let environmentText = environment.text ?? ""

        
        DCSCard.sharedInstance().authenSdkWithorgCode(orgCodeText,
                                                      orgSecretKey: orgKeyText,
                                                      areaCode: areaCodeText,
                                                      phoneNumber: phoneText,
                                                      bizCode: bizCodeText,
                                                      partnerID: partnerIDText,
                                                      externalUserId: externalUserIDText,
                                                      externalWorkflowId: externalWorkflowIDText,
                                                      environment: environmentText) { responseObject, error in
            if let data = responseObject["data"] as? [String: Any],
               let authen = data["accessToken"] as? String, !authen.isEmpty {
                self.authen = authen
            }
            if !error.isEmpty {
                self.log(["error": error])
            } else if let responseDict = responseObject as? [String: Any] {
                self.log(responseDict)
            } else {
                self.log(["error": "Invalid response format"])
            }
        }
    }

    // MARK: - Apply Card
    func startApply() {
        guard let authen = authen else {
            log(["tip": "Please click on the authorization application to obtain the token first"])
            return
        }
        let bizType = "D001"
        let bizCode = "470102"
        let firstNameText = firstName.text ?? ""
        let lastNameText = lastName.text ?? ""
        let genderText = gender.text ?? ""
        let birthDateText = birthDate.text ?? ""
        let nationalityText = nationality.text ?? ""
        let idTypeText = idType.text ?? ""
        let idNoText = idNo.text ?? ""
        let addressText = address.text ?? ""
        let postCodeText = postCode.text ?? ""
        let emailText = email.text ?? ""
        let partnerIDText = partnerID.text ?? ""
        let externalWorkflowIDText = externalWorkflowId.text ?? ""
        let environmentText = environment.text ?? ""
        
        let productCode = productCode.text ?? ""
        let cardType = cardType.text ?? ""
        let cardFace = cardFace.text ?? ""
        let cardFlag = cardFlag.text ?? ""
        let productInfo: [[String: String]] = [
            [
                "productCode": productCode,
                "cardType": cardType,
                "cardFace": cardFace,
                "cardFlag": cardFlag
            ]
        ]
        DCSCard.sharedInstance().goApplyforCardbizType(bizType,
                                                       bizCode: bizCode,
                                                       accessToken: authen,
                                                       firstName: firstNameText,
                                                       lastName: lastNameText,
                                                       gender: genderText,
                                                       birthDate: birthDateText,
                                                       nationality: nationalityText,
                                                       idType: idTypeText,
                                                       idNo: idNoText,
                                                       address: addressText,
                                                       postCode: postCodeText,
                                                       email: emailText,
                                                       productInfo: productInfo,
                                                       partnerID: partnerIDText,
                                                       externalWorkflowId: externalWorkflowIDText,
                                                       environment: environmentText) { responseObject, error in
            if !error.isEmpty {
                self.log(["error": error])
            } else if let responseDict = responseObject as? [String: Any] {
                self.log(responseDict)
            } else {
                self.log(["error": "Invalid response format"])
            }
        }
    }

    // MARK: - Card Progress Query
    func cardProgress() {
        guard let authen = authen else {
            log(["tip": "Please click on the authorization application to obtain the token first"])
            return
        }
        let bizType = "D002"
        let bizCode = "470102"
        let externalWorkflowIDText = externalWorkflowId.text ?? ""
        let environmentText = environment.text ?? ""
        DCSCard.sharedInstance().cardProgressInquirybizType(bizType,
                                                            bizCode: bizCode,
                                                            accessToken: authen,
                                                            externalWorkflowId: externalWorkflowIDText,
                                                            environment: environmentText) { responseObject, error in
            if !error.isEmpty {
                self.log(["error": error])
            } else if let responseDict = responseObject as? [String: Any] {
                self.log(responseDict)
            } else {
                self.log(["error": "Invalid response format"])
            }
        }
    }

    // MARK: - Reset PIN
    func goToRestPIN() {
        guard let authen = authen else {
            log(["tip": "Please click on the authorization application to obtain the token first"])
            return
        }
        let bizType = "D007"
        let bizCode = "470102"
        let cardTokenText = cardToken.text ?? ""
        let custIdTokenText = custIdToken.text ?? ""
        let externalWorkflowIDText = externalWorkflowId.text ?? ""
        let environmentText = environment.text ?? ""
        DCSCard.sharedInstance().restPinForbizType(bizType,
                                                   bizCode: bizCode,
                                                   accessToken: authen,
                                                   cardToken: cardTokenText,
                                                   custIdToken: custIdTokenText,
                                                   externalWorkflowId: externalWorkflowIDText,
                                                   environment: environmentText) { responseObject, error in
            if !error.isEmpty {
                self.log(["error": error])
            } else if let responseDict = responseObject as? [String: Any] {
                self.log(responseDict)
            } else {
                self.log(["error": "Invalid response format"])
            }
        }
    }

    // MARK: - Logging
    func log(_ res: [String: Any]) {
        
        let jsonData = try? JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
        let jsonString = jsonData.flatMap { String(data: $0, encoding: .utf8) } ?? "Error converting to JSON String"

        logText.append("=======================\n")
        logText.append(jsonString)
        logText.append("\n\n")

        DispatchQueue.main.async {
            self.logView.text = self.logText as String
            let originY = max(0, self.logView.contentSize.height - self.logView.bounds.height)
            self.logView.setContentOffset(CGPoint(x: 0, y: originY), animated: true)
        }
    }

    @IBAction func clearLog(_ sender: Any) {
        logText.setString("")
        DispatchQueue.main.async {
            self.logView.text = self.logText as String
            let originY = max(0, self.logView.contentSize.height - self.logView.bounds.height)
            self.logView.setContentOffset(CGPoint(x: 0, y: originY), animated: true)
        }
    }

    // MARK: - Selection Action
    @IBAction func selectTypeClick(_ sender: Any) {
        let alertVC = UIAlertController(
            title: "Please select the type",
            message: nil,
            preferredStyle: .actionSheet
        )
        alertVC.addAction(UIAlertAction(title: "Authorization", style: .default) { _ in self.authorization() })
        alertVC.addAction(UIAlertAction(title: "Apply Card", style: .default) { _ in self.startApply() })
        alertVC.addAction(UIAlertAction(title: "Card Progress", style: .default) { _ in self.cardProgress() })
        alertVC.addAction(UIAlertAction(title: "Rest Pin", style: .default) { _ in self.goToRestPIN() })
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertVC, animated: true)
    }
}
