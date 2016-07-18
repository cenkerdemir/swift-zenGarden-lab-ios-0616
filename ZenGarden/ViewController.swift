//
//  ViewController.swift
//  ZenGarden
//
//  Created by Flatiron School on 6/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // properties for imageViews
    @IBOutlet weak var rockImageView: UIImageView!
    @IBOutlet weak var rakeImageView: UIImageView!
    @IBOutlet weak var shrubImageView: UIImageView!
    @IBOutlet weak var swordInRockImageView: UIImageView!
    
    // bools for the winner
    var rockInPlaceForWin: Bool = false;
    var rakeAndShrubInPlaceForWin: Bool = false;
    var swordInPlaceForWin: Bool = false;
    
    // properties for constraints
    //for the rock image
    var rockHeightConstraint = NSLayoutConstraint()
    var rockWidthConstraint = NSLayoutConstraint()
    var rockTopConstraint = NSLayoutConstraint()
    var rockLeftConstraint = NSLayoutConstraint()

    //for the rake image
    var rakeHeightConstraint = NSLayoutConstraint()
    var rakeWidthConstraint = NSLayoutConstraint()
    var rakeTopConstraint = NSLayoutConstraint()
    var rakeLeftConstraint = NSLayoutConstraint()
    
    //for shrub image
    var shrubHeightConstraint = NSLayoutConstraint()
    var shrubWidthConstraint = NSLayoutConstraint()
    var shrubTopConstraint = NSLayoutConstraint()
    var shrubLeftConstraint = NSLayoutConstraint()
    
    //for the swordInRock image
    var swordInRockHeightConstraint = NSLayoutConstraint()
    var swordInRockWidthConstraint = NSLayoutConstraint()
    var swordInRockTopConstraint = NSLayoutConstraint()
    var swordInRockLeftConstraint = NSLayoutConstraint()
    
    // difference points for coordinate calculation
    var rockDifferencePoint: CGPoint?
    var rakeDifferencePoint: CGPoint?
    var shrubDifferencePoint: CGPoint?
    var swordInRockDifferencePoint: CGPoint?
    
    //gesture recognizers
    var rockGestureRecognizer = UIPanGestureRecognizer()
    var rakeGestureRecognizer = UIPanGestureRecognizer()
    var shrubGestureRecognizer = UIPanGestureRecognizer()
    var swordGestureRecognizer = UIPanGestureRecognizer()
    
    //a bool to make sure the alerts is shown only once per game
    var wasAlertShown: Bool = false
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.removeConstraints(self.view.constraints)
        //self.view.translatesAutoresizingMaskIntoConstraints = false
        // call the function that creates constraints here...
        setConstraints()
        
        //enable user interaction
        self.rockImageView.userInteractionEnabled = true
        self.rakeImageView.userInteractionEnabled = true
        self.shrubImageView.userInteractionEnabled = true
        self.swordInRockImageView.userInteractionEnabled = true
        
        // define and assign gesture recognizers
        self.rockGestureRecognizer = UIPanGestureRecognizer.init(target:self, action: #selector(self.rockDragged))
        self.rockImageView.addGestureRecognizer(rockGestureRecognizer)
        
        self.rakeGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(self.rakeDragged))
        self.rakeImageView.addGestureRecognizer(rakeGestureRecognizer)
        
        self.shrubGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(self.shrubDragged))
        self.shrubImageView.addGestureRecognizer(shrubGestureRecognizer)
        
        self.swordGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(self.swordInRockDragged))
        self.swordInRockImageView.addGestureRecognizer(swordGestureRecognizer)
    }

        //rock dragged function
        func rockDragged(recognizer: UIPanGestureRecognizer) {
            let coordinates = recognizer.translationInView(self.rockImageView)
            if recognizer.state == .Began {
                self.rockDifferencePoint = coordinates
            }
            else {
                if let differencePoint = self.rockDifferencePoint {
                    let differenceForX = coordinates.x - differencePoint.x
                    let differenceForY = coordinates.y - differencePoint.y
                    self.rockLeftConstraint.constant += differenceForX
                    self.rockTopConstraint.constant += differenceForY
                    self.rockDifferencePoint = coordinates
                }
            }
            if self.isThereAWinner() && self.wasAlertShown == false {
                //show alert for the win
                self.showAlert()
            }
        }
    
        // rake dragged function
        func rakeDragged(recognizer: UIPanGestureRecognizer) {
            let coordinates = recognizer.translationInView(self.rakeImageView)
            if recognizer.state == .Began {
                self.rakeDifferencePoint = coordinates
            }
            else {
                if let differencePoint = self.rakeDifferencePoint {
                    let differenceForX = coordinates.x - differencePoint.x
                    let differenceForY = coordinates.y - differencePoint.y
                    self.rakeLeftConstraint.constant += differenceForX
                    self.rakeTopConstraint.constant += differenceForY
                    self.rakeDifferencePoint = coordinates
                }
            }
            if self.isThereAWinner() && self.wasAlertShown == false{
                //show alert for the win
                self.showAlert()
            }
        }
    
        //shrub dragged
        func shrubDragged(recognizer: UIPanGestureRecognizer) {
            let coordinates = recognizer.translationInView(self.shrubImageView)
            if recognizer.state == .Began {
                self.shrubDifferencePoint = coordinates
            }
            else {
                if let differencePoint = self.shrubDifferencePoint {
                    let differenceForX = coordinates.x - differencePoint.x
                    let differenceForY = coordinates.y - differencePoint.y
                    self.shrubLeftConstraint.constant += differenceForX
                    self.shrubTopConstraint.constant += differenceForY
                    self.shrubDifferencePoint = coordinates
                }
            }
            if self.isThereAWinner() && self.wasAlertShown == false {
                //show alert for the win
                self.showAlert()
            }
        }
    
        // sword-in-rock dragged
        func swordInRockDragged(recognizer: UIPanGestureRecognizer) {
            let coordinates = recognizer.translationInView(self.swordInRockImageView)
            if recognizer.state == .Began {
                self.swordInRockDifferencePoint = coordinates
            }
            else {
                if let differencePoint = self.swordInRockDifferencePoint {
                    let differenceForX = coordinates.x - differencePoint.x
                    let differenceForY = coordinates.y - differencePoint.y
                    self.swordInRockLeftConstraint.constant += differenceForX
                    self.swordInRockTopConstraint.constant += differenceForY
                    self.swordInRockDifferencePoint = coordinates
                }
            }
            if self.isThereAWinner() && self.wasAlertShown == false {
                //show alert for the win
                self.showAlert()
            }
        }
        
    
    
    //is there a winner?
    func isThereAWinner() -> Bool {
        if self.swordInRockLeftConstraint.constant <  50 && (self.swordInRockTopConstraint.constant < 50 || self.swordInRockTopConstraint.constant > 450) {
            self.swordInPlaceForWin = true
        }
        if fabs(self.rakeTopConstraint.constant - self.shrubTopConstraint.constant) < 50 && fabs(self.rakeLeftConstraint.constant - self.shrubLeftConstraint.constant) < 50 {
            self.rakeAndShrubInPlaceForWin = true
        }
        if self.swordInRockTopConstraint.constant < 50 && self.rockTopConstraint.constant > 450{
            self.rockInPlaceForWin = true
        }
        if self.swordInRockTopConstraint.constant > 450 && self.rockTopConstraint.constant < 50 {
            self.rockInPlaceForWin = true
        }
        if (self.rockInPlaceForWin == true) && (self.rakeAndShrubInPlaceForWin == true) && (self.swordInPlaceForWin == true) {
            return true
        }
        else {
            return false
        }
    }
    
    //show alert function
    func showAlert() {
        let alertController = UIAlertController(title: "", message: "you won", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            self.resetForNewGame()
            self.setConstraints()
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.resetForNewGame()
            self.setConstraints()
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) { }
        self.wasAlertShown = true
    }
    

    // a separate function to set the constraints
    func setConstraints(){
        //rock image constraints
        self.rockImageView.removeConstraints(self.rockImageView.constraints)
        self.rockImageView.translatesAutoresizingMaskIntoConstraints = false
        self.rockHeightConstraint = self.rockImageView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.15)
        self.rockHeightConstraint.active = true
        self.rockWidthConstraint = self.rockImageView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.4)
        self.rockWidthConstraint.active = true
        self.rockTopConstraint = self.rockImageView.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: CGFloat(arc4random_uniform(200)))
        self.rockTopConstraint.active = true
        self.rockLeftConstraint = self.rockImageView.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor, constant: CGFloat(arc4random_uniform(250)))
        self.rockLeftConstraint.active = true
        
        //rake image constraints
        self.rakeImageView.removeConstraints(self.rakeImageView.constraints)
        self.rakeImageView.translatesAutoresizingMaskIntoConstraints = false
        self.rakeHeightConstraint = self.rakeImageView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.25)
        self.rakeHeightConstraint.active = true
        self.rakeWidthConstraint = self.rakeImageView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.35)
        self.rakeWidthConstraint.active = true
        self.rakeTopConstraint = self.rakeImageView.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: CGFloat(arc4random_uniform(100)))
        self.rakeTopConstraint.active = true
        self.rakeLeftConstraint = self.rakeImageView.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor, constant: CGFloat(arc4random_uniform(200)))
        self.rakeLeftConstraint.active = true
        
        //shrub constraints
        self.shrubImageView.removeConstraints(self.shrubImageView.constraints)
        self.shrubImageView.translatesAutoresizingMaskIntoConstraints = false
        self.shrubHeightConstraint = self.shrubImageView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.15)
        self.shrubHeightConstraint.active = true
        self.shrubWidthConstraint = self.shrubImageView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.4)
        self.shrubWidthConstraint.active = true
        self.shrubTopConstraint = self.shrubImageView.topAnchor.constraintEqualToAnchor(self.view.topAnchor)
        self.shrubTopConstraint.active = true
        self.shrubLeftConstraint = self.shrubImageView.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor)
        self.shrubLeftConstraint.active = true
        
        //sword-in-rock constraints
        self.swordInRockImageView.removeConstraints(self.swordInRockImageView.constraints)
        self.swordInRockImageView.translatesAutoresizingMaskIntoConstraints = false
        self.swordInRockHeightConstraint = self.swordInRockImageView.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.3)
        self.swordInRockHeightConstraint.active = true
        self.swordInRockWidthConstraint = self.swordInRockImageView.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.5)
        self.swordInRockWidthConstraint.active = true
        self.swordInRockTopConstraint = self.swordInRockImageView.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: CGFloat(arc4random_uniform(250)))
        self.swordInRockTopConstraint.active = true
        self.swordInRockLeftConstraint = self.swordInRockImageView.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor, constant: CGFloat(arc4random_uniform(150)))
        self.swordInRockLeftConstraint.active = true
    }
    
    func resetForNewGame() {
        //rock image constraints
        
        self.rockHeightConstraint.active = false
        self.rockWidthConstraint.active = false
        self.rockTopConstraint.active = false
        self.rockLeftConstraint.active = false
        
        //rake image constraints
        self.rakeHeightConstraint.active = false
        self.rakeWidthConstraint.active = false
        self.rakeTopConstraint.active = false
        self.rakeLeftConstraint.active = false

        
        //shrub constraints
        self.shrubHeightConstraint.active = false
        self.shrubWidthConstraint.active = false
        self.shrubTopConstraint.active = false
        self.shrubLeftConstraint.active = false

        
        //sword-in-rock constraints
        self.swordInRockHeightConstraint.active = false
        self.swordInRockWidthConstraint.active = false
        self.swordInRockTopConstraint.active = false
        self.swordInRockLeftConstraint.active = false
        
        //set booleans
        self.rockInPlaceForWin = false;
        self.rakeAndShrubInPlaceForWin = false;
        self.swordInPlaceForWin = false;
        self.wasAlertShown = false
    }

}

