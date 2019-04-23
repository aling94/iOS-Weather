//
//  ForecastVC.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit

class ForecastVC: UIViewController {
    
    @IBOutlet weak var overheadWeather: WeatherInfoView!
    @IBOutlet weak var currWeather: WeatherInfoView!
    
    @IBOutlet weak var overheadBottom: NSLayoutConstraint!
    @IBOutlet weak var bgBottom: NSLayoutConstraint!
    
    var forecastVM: ForecastVM!
    var forecastCard: ForecastCardVC!
    
    // Card animation variables
    var handleHgt: CGFloat = 0
    var cardHgt: CGFloat = 0
    var animations: [UIViewPropertyAnimator] = []
    var animationProgress: CGFloat = 0
    var cardExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        currWeather.set(forecastVM.current)
        overheadWeather.set(forecastVM.current)
        setupCard()
        loadForecasts()
        setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func loadForecasts() {
        forecastVM.fetchForecasts { (error) in
            if let error = error?.localizedDescription {
                self.showAlert(title: "Error", msg: error)
                return
            }
            DispatchQueue.main.async {
                self.forecastCard.forecastVM = self.forecastVM
            }
        }
    }
    
    func setupCard() {
        forecastCard = ForecastCardVC(nibName: "ForecastCardVC", bundle: nil)
        addChild(forecastCard)
        view.addSubview(forecastCard.view)
        handleHgt = forecastCard.handle.frame.height - 10
        cardHgt = forecastCard.height
        forecastCard.view.frame = CGRect(x: 0, y: view.frame.height - handleHgt, width: view.frame.width, height: cardHgt)
        forecastCard.view.layer.cornerRadius = 8
//        forecastCard.view.clipsToBounds = true
    }
    
    func setupGestures() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        forecastCard.handle.addGestureRecognizer(pan)
        forecastCard.handle.addGestureRecognizer(tap)
    }
}

// MARK: - Gesture Animations

extension ForecastVC {
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began: startTransition(duration: 0.9)
        case .changed:
            let translation = sender.translation(in: forecastCard.handle)
            var fracCompleted = translation.y / cardHgt
            fracCompleted = cardExpanded ? fracCompleted : -fracCompleted
            updateTransiation(progress: fracCompleted)
        case .ended: continueTransition()
        default: break
        }
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended: animateTransition(duration: 1)
        default: break
        }
    }
    
    func animateTransition(duration: TimeInterval) {
        guard animations.isEmpty else { return }
        let hgtOffset = cardExpanded ? handleHgt : cardHgt
        let frameAnimator: UIViewPropertyAnimator = {
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                self.forecastCard.view.frame.origin.y = self.view.frame.height - hgtOffset
            }
            
            animator.addCompletion { (position) in
                self.cardExpanded = !self.cardExpanded
                self.animations.removeAll()
            }
            return animator
        }()
        
        frameAnimator.startAnimation()
        animations.append(frameAnimator)
        
        let handleAnimator: UIViewPropertyAnimator = {
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                if self.cardExpanded {
                    self.forecastCard.resetHandle()
                    
                } else {
                    self.forecastCard.shrinkHandle(by: 20)
                    self.forecastCard.shiftHandleUp(by: 40)
                }
                self.forecastCard.view.layoutIfNeeded()
            }
            return animator
        }()
        
        handleAnimator.startAnimation()
        animations.append(handleAnimator)
        
        let bgAnimator: UIViewPropertyAnimator = {
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                self.bgBottom.constant = self.cardExpanded ? 0 : self.cardHgt - 10
                self.view.layoutIfNeeded()
            }
            return animator
        }()
        
        bgAnimator.startAnimation()
        animations.append(bgAnimator)
        
        let overheadAnimator: UIViewPropertyAnimator = {
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                let offset = self.overheadWeather.frame.height + self.navbarHeight + 10
                self.overheadBottom.constant = self.cardExpanded ? 0 : offset
                self.overheadWeather.alpha = self.cardExpanded ? 0: 1
                self.view.layoutIfNeeded()
            }
            return animator
        }()
        
        overheadAnimator.startAnimation()
        animations.append(overheadAnimator)
    }
    
    func startTransition(duration: TimeInterval) {
        if animations.isEmpty {
            animateTransition(duration: duration)
        }
        for animator in animations {
            animator.pauseAnimation()
            animationProgress = animator.fractionComplete
        }
    }
    
    func updateTransiation(progress: CGFloat) {
        for animator in animations {
            animator.fractionComplete = progress + animationProgress
        }
    }
    
    func continueTransition() {
        for animator in animations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}
