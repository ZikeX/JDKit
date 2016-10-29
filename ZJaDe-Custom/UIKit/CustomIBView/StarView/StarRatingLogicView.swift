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
    @IBInspectable var score:CGFloat = 0.0 {
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
    fileprivate var imageViewArray = [UIImageView]()
    lazy fileprivate var percentLayer:CALayer = {
        let layer = CALayer()
        layer.contents = self.starImageSelected.cgImage
        layer.masksToBounds = true
        return layer
    }()
    
    override func configInit() {
        super.configInit()
        updateImageViewArray()
        self.isUserInteractionEnabled = isEnabled
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let selectScore = Int(self.score)
        let percentScore = self.score - CGFloat(selectScore)
        for (index,imageView) in imageViewArray.enumerated() {
            if index < selectScore {
                imageView.image = self.starImageSelected
            }else {
                imageView.image = self.starImageUnSelected
                if index == selectScore {
                    self.setImagePercent(percentScore: percentScore, imageView: imageView)
                }
            }
        }
    }
    func setImagePercent(percentScore:CGFloat,imageView:UIImageView) {
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
    func resetStackView(imageViewArray:[UIImageView]) {
        self.removeAllSubviews()
        let stackView = UIStackView(arrangedSubviews:imageViewArray)
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        self.addSubview(stackView)
        stackView.edgesToView()
        self.stackView = stackView
    }
    func updateImageViewArray() {
        self.imageViewArray.countIsEqual(maxStarCount) {return UIImageView(image: self.starImageUnSelected)}
        self.resetStackView(imageViewArray: self.imageViewArray)
    }
}
// MARK: - 手势
extension StarRatingLogicView {
    func actionHandle() {
        func gestureRecognizerHandle(gestureRecognizer:UIGestureRecognizer) {
            if isEnabled {
                let positionX = gestureRecognizer.location(in: self).x
                self.score = positionX / self.width * 5
            }
        }
        let panObservable = self.getPan().rx.event
        let tapObservable = self.getTap().rx.event
        
        _ = panObservable.subscribe { (event) in
            gestureRecognizerHandle(gestureRecognizer: event.element!)
        }
        _ = tapObservable.subscribe { (event) in
            gestureRecognizerHandle(gestureRecognizer: event.element!)
        }
    }
}
