//
//  StarRatingLogicView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/14.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class StarRatingLogicView: CustomIBView {
    let starImageSelected:UIImage = R.image.ic_star_selected()!
    let starImageUnSelected:UIImage = R.image.ic_star_unSelected()!
    
    @IBInspectable var score:Score = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var isEnabled:Bool = false {
        didSet {
            self.isUserInteractionEnabled = isEnabled
        }
    }
    var stackView:UIStackView?
    
    var maxStarCount:Int = 5 {
        didSet {
            updateImageViewArray()
        }
    }
    fileprivate var imageViewArray = [ImageView]()
    lazy fileprivate var percentLayer:CALayer = {
        let layer = CALayer()
        layer.contents = self.starImageSelected.cgImage
        layer.masksToBounds = true
        return layer
    }()
    
    override func configInit() {
        super.configInit()
        self.isUserInteractionEnabled = isEnabled
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImageViewArray()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let scoreValue = self.score.value
        let selectScore = scoreValue.floor().toInt
        let percentScore = scoreValue.truncatingRemainder(dividingBy: 1.0)
        for (index,imageView) in imageViewArray.enumerated() {
            if index < selectScore {
                imageView.image = self.starImageSelected
            }else {
                imageView.image = self.starImageUnSelected
                if index == selectScore {
                    self.setImagePercent(percentScore: percentScore.toCGFloat, imageView: imageView)
                }
            }
        }
    }
    func setImagePercent(percentScore:CGFloat,imageView:ImageView) {
        if percentScore > 0 {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            imageView.layer.addSublayer(self.percentLayer)
            self.percentLayer.frame = imageView.bounds
            self.percentLayer.frame.size.width *= percentScore
            self.percentLayer.contentsRect = CGRect(x: 0, y: 0, width: percentScore, height: 1)
            CATransaction.commit()
        }else {
            self.percentLayer.removeFromSuperlayer()
        }
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 70, height: 20)
    }
}
extension StarRatingLogicView {
    func resetStackView(imageViewArray:[ImageView]) {
        self.removeAllSubviews()
        let stackView = UIStackView(arrangedSubviews:imageViewArray)
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        self.addSubview(stackView)
        stackView.edgesToView()
        self.stackView = stackView
    }
    func updateImageViewArray() {
        self.imageViewArray.countIsEqual(maxStarCount) {return ImageView(image: self.starImageUnSelected)}
        self.resetStackView(imageViewArray: self.imageViewArray)
    }
}
// MARK: - 手势
extension StarRatingLogicView {
    func actionHandle() {
        func gestureRecognizerHandle(gestureRecognizer:UIGestureRecognizer) {
            if isEnabled {
                let positionX = gestureRecognizer.location(in: self).x
                self.score.value = (positionX / self.width * 5).toDouble
            }
        }
        let panObservable = self.getPan().rx.event
        let tapObservable = self.getTap().rx.event
        
        _ = panObservable.subscribe(onNext: { (pan) in
            gestureRecognizerHandle(gestureRecognizer: pan)
        })
        _ = tapObservable.subscribe(onNext: { (tap) in
            gestureRecognizerHandle(gestureRecognizer: tap)
        })
    }
}
