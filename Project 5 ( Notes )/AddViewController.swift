//
//  AddViewController.swift
//  Project 5 ( Notes )
//
//  Created by robusta on 20/04/2024.
//

import UIKit

class AddViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet var noteLabel: UITextView!
    @IBOutlet var titleLabel: UITextField!
    
    public var completion: ((String , String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteLabel.delegate = self
        titleLabel.delegate = self
        // Do any additional setup after loading the view.
        title = "New Note"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNote))
    }

    @objc func saveNote(){
        if let title = titleLabel.text{
            if let description = noteLabel.text {
                noteLabel.resignFirstResponder()
                titleLabel.resignFirstResponder()
                completion!(title , description)
            }
        }
    }

}
