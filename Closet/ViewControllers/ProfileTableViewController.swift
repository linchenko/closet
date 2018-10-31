//
//  ProfileTableViewController.swift
//  Closet
//
//  Created by Levi Linchenko on 29/10/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class ProfileTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
   
    
    
    @IBOutlet weak var myTableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        setUpSwipe()
    }
    
    


    // MARK: - Table view data source


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
        return ClosetController.shared.tagCount
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return UITableViewCell()
    }
    
    
    //MARK: -Animations
    
    private let sideViewOffset: CGFloat = 200
    private var currentState: State = .closed{
        didSet{
            print(currentState)
            switch currentState {
            case .closed:
                self.myTableView.isUserInteractionEnabled = true
            case .open:
                self.myTableView.isUserInteractionEnabled = false
            }
        }
    }
    private var runningAnimator = UIViewPropertyAnimator()
    private var animationProgress = CGFloat()
    
    var trayHandler = InstantPanGestureRecognizer()
    
    func setUpSwipe(){
        trayHandler = InstantPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        view.addGestureRecognizer(trayHandler)
        trayHandler.delegate = self

    }
    

    
    
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
//            let translation = panGestureRecognizer.translation(in: view)
//            print(translation)
//            if abs(translation.x) > abs(translation.y) {
//                return true
//            }
//            return false
//        }
//        return false
//    }

    var scrollIsScrolling = false

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollIsScrolling = true

    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollIsScrolling = false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    
    private func animateTransition(to state: State) {
        let animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1) {
            switch state {
            case .open:
                self.view.transform = CGAffineTransform(translationX: -200, y: 0)
            case .closed:
                self.view.transform = .identity
            }
            self.view.layoutIfNeeded()
        }
        animator.addCompletion { (position) in
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            }
        }
        self.runningAnimator = animator
        animator.startAnimation()
    }
    
    @objc private func handlePan(recognizer: UIPanGestureRecognizer){
        
        if recognizer.translation(in: view).x > recognizer.translation(in: view).y && currentState == .closed{
//            print("X bigger than y")
            return
        }
        
        
        
        switch recognizer.state {
        case .began:
            animateTransition(to: currentState.opposite)
            runningAnimator.pauseAnimation()
            animationProgress = runningAnimator.fractionComplete
        case .changed:
            let tranlation = recognizer.translation(in: view)
            var fraction = -tranlation.x / sideViewOffset
            if currentState == .open { fraction *= -1 }
            if runningAnimator.isReversed { fraction *= -1 }
            
            runningAnimator.fractionComplete = fraction + animationProgress

        case .ended:
            let xVelocity = recognizer.velocity(in: view).x
            let shouldClose = xVelocity > 0
            
            if xVelocity == 0 {
                runningAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                break
            }
            
            switch currentState {
            case .open:
                if !shouldClose && !runningAnimator.isReversed {
                    runningAnimator.isReversed = !runningAnimator.isReversed
                }
                if shouldClose && runningAnimator.isReversed{
                    runningAnimator.isReversed = !runningAnimator.isReversed
                }
            case .closed:
                if shouldClose && !runningAnimator.isReversed {
                    runningAnimator.isReversed = !runningAnimator.isReversed
                }
                if !shouldClose && runningAnimator.isReversed {
                    runningAnimator.isReversed = !runningAnimator.isReversed
                }
            }
            
            runningAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            
        default:
            ()
        }
    }
    
    

    
    @IBAction func settingsTapped(_ sender: Any) {
        
        switch currentState {
        case .closed:
            currentState = currentState.opposite
            UIView.animate(withDuration: 0.1) {
                self.view.transform = CGAffineTransform(translationX: -200, y: 0)
            }
        case .open:
            currentState = currentState.opposite
            UIView.animate(withDuration: 0.1) {
                self.view.transform = .identity
            }
        }
    }
    
}


private enum State {
    case closed
    case open
    
    var opposite: State {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}

    // Tells the recognizer to go straight to began when touched
class InstantPanGestureRecognizer: UIPanGestureRecognizer {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == .began) {return}
        super.touchesBegan(touches, with: event)
        self.state = .began
    }
    
//    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
//            let translation = panGestureRecognizer.translation(in: view)
//            if abs(translation.x) > abs(translation.y) {
//                return true
//            }
//            return false
//        }
//        return false
//    }
//

    
}
