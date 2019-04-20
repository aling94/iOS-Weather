//
//  ForecastVC.swift
//  Weather
//
//  Created by Alvin Ling on 4/18/19.
//  Copyright © 2019 iOSPlayground. All rights reserved.
//

import UIKit

class ForecastVC: UIViewController {
    
    @IBOutlet weak var currWeather: WeatherInfoView!
    @IBOutlet weak var todayWeather: WeatherInfoView!
    @IBOutlet weak var tmrwWeather: WeatherInfoView!
    
    var forecastVM: ForecastVM!
    var forecastCard: ForecastCardVC!
    var handleHgt: CGFloat = 0
    var cardHgt: CGFloat = 600
    
    var animations: [UIViewPropertyAnimator] = []
    var animationProgress: CGFloat = 0
    var cardExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        currWeather.set(forecastVM.current)
        setupCard()
        loadForecasts()
        
        setupGestures()
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
        handleHgt = forecastCard.handle.frame.height
        forecastCard.view.frame = CGRect(x: 0, y: view.frame.height - handleHgt, width: view.frame.width, height: cardHgt)
        forecastCard.view.layer.cornerRadius = 8
        forecastCard.view.clipsToBounds = true
    }
    
    func setupGestures() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        forecastCard.handle.addGestureRecognizer(pan)
//        forecastCard.handle.addGestureRecognizer(tap)
    }

    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            startTransition(duration: 0.9)
        case .changed:
            let translation = sender.translation(in: forecastCard.handle)
            var fracCompleted = translation.y / cardHgt
            fracCompleted = cardExpanded ? fracCompleted : -fracCompleted
            updateTransiation(progress: fracCompleted)
        case .ended:
            continueTransition()
        default: break
        }
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
    }
    
    func animateTransition(duration: TimeInterval) {
        guard animations.isEmpty else { return }
        let hgtOffset = cardExpanded ? cardHgt : handleHgt
        let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
            self.forecastCard.view.frame.origin.y = self.view.frame.height - hgtOffset
        }
        frameAnimator.addCompletion { (position) in
            self.cardExpanded = !self.cardExpanded
            self.animations.removeAll()
        }
        frameAnimator.startAnimation()
        animations.append(frameAnimator)
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
