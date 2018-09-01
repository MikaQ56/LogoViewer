//
//  ViewController.swift
//  LogoViewer
//
//  Created by Ambroise COLLON on 24/04/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit

// MARK: - Outlets
class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

}

// MARK: - Logo
extension ViewController {
    
    @IBAction func didTapSearchButton() {
        toggleActivityIndicator(shown: true)
        searchLogo()
    }

    func searchLogo() {
        guard let domain = textField.text else {
            domainAlert()
            return
        }
        LogoService.shared.getLogo(domain: domain) { (success, data) in
            guard success, let data = data else {
                self.presentAlert()
                return
            }
            self.updateLogo(data: data)
            self.toggleActivityIndicator(shown: false)
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        searchButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
    private func updateLogo(data: Data){
        imageView.image = UIImage(data: data)
    }
}

// MARK: - Alerts
extension ViewController {
    
    private func presentAlert(){
        let alertVC = UIAlertController(title: "Error", message: "The logo download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func domainAlert() {
        let alertVC = UIAlertController(title: "Pas de nom de domaine...", message: "Entrez un nom de domaine pour voir le logo !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - Keyboard
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchLogo()
        return true
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
}
