//
//  ViewController.swift
//  ImageGesture
//
//  Created by DCS on 07/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let myImageView:UIImageView = {
       let img = UIImageView()
        img.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        return img
    }()
    
    private let imagePicker:UIImagePickerController = {
       let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        return imagePicker
    }()
    
    private let myLabel:UILabel = {
       let txt = UILabel()
        txt.text = "Tap Here to select the image"
        txt.textColor = .gray
        txt.frame = CGRect(x: 20, y: 400, width: 350, height: 40)
        txt.textAlignment = .center
        return txt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        view.addSubview(myImageView)
        imagePicker.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        view.addGestureRecognizer(tap)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(letsPinch))
        view.addGestureRecognizer(pinch)
        
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(letsRotate))
        view.addGestureRecognizer(rotation)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(letsSwipe))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(letsSwipe))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(letsSwipe))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(letsSwipe))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(letsPan))
        view.addGestureRecognizer(pan)
        
    }

}

extension ViewController {
    @objc private func openImagePicker(_ gesture:UITapGestureRecognizer){
        imagePicker.sourceType = .photoLibrary
        DispatchQueue.main.async {
            self.present(self.imagePicker, animated: true)
        }
    }
    
    @objc private func letsPinch(_ gesture:UIPinchGestureRecognizer)
    {
        myImageView.transform
            = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    
    @objc private func letsRotate(_ gesture:UIRotationGestureRecognizer)
    {
        myImageView.transform
            = CGAffineTransform(rotationAngle: gesture.rotation)
    }
    
    @objc private func letsSwipe(_ gesture:UISwipeGestureRecognizer)
    {
        if gesture.direction
            == .left {
            UIView.animate(withDuration: 0.3){
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x - 50
                    , y: self.myImageView.frame.origin.y, width: 300, height: 300)
            }
        }
        else if gesture.direction
            == .right {
            UIView.animate(withDuration: 0.3){
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x + 50
                    , y: self.myImageView.frame.origin.y, width: 300, height: 300)
            }
        }
        else if gesture.direction
            == .up {
            UIView.animate(withDuration: 0.3){
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x
                    , y: self.myImageView.frame.origin.y - 50, width: 300, height: 300)
            }
        }
        else if gesture.direction
            == .down {
            UIView.animate(withDuration: 0.3){
                self.myImageView.frame = CGRect(x: self.myImageView.frame.origin.x
                    , y: self.myImageView.frame.origin.y + 50, width: 300, height: 300)
            }
        }
    }
    
    @objc private func letsPan(_ gesture:UIPanGestureRecognizer){
        let x = gesture.location(in: view).x
        let y = gesture.location(in: view).y
        myImageView.center = CGPoint(x: x, y: y)
    }
    
    
}

extension ViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectImage = info[.originalImage] as? UIImage
            {
                myImageView.image = selectImage
            }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
