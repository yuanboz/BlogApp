//
//  BlogEntryViewController.swift
//  BlogApp
//
//  Created by 周元博 on 10/19/21.
//

import UIKit

class BlogEntryViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var blogContent: UITextView!
    
    var blogEntry: BlogEntry?
    @IBOutlet var botConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        if blogEntry == nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                blogEntry = BlogEntry(context: context)
                blogEntry?.date = datePicker.date
                blogEntry?.content = ""
                blogContent.becomeFirstResponder()
            }
        }
        blogContent.text = blogEntry?.content
        if let dateToBeDisplayed = blogEntry?.date {
            datePicker.date = dateToBeDisplayed
        }
        blogContent.delegate = self
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            botConstraint.constant = keyboardHeight
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    @IBAction func onDelete(_ sender: Any) {
        if blogEntry != nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(blogEntry!)
                try? context.save()
            }
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        blogEntry?.content = blogContent.text
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    @IBAction func onDataChanged(_ sender: Any) {
        blogEntry?.date = datePicker.date
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
}
