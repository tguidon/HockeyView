//
//  RinkView.swift
//  HockeyView
//
//  Created by Taylor Guidon on 1/16/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit
import SnapKit

class RinkView: UIView {
    
    // rinkView holds the rink's UI elements
    // dataView holds potential data overlays
    let rinkView = UIView()
    let dataView = UIView()
    
    // Views for rink elements
    let homeGoalLine = UIView()
    let awayGoalLine = UIView()
    let homeBlueLine = UIView()
    let awayBlueLine = UIView()
    let homeTopCircle = UIView()
    let homeBottomCircle = UIView()
    let awayTopCircle = UIView()
    let awayBottomCircle = UIView()
    
    let centerIceLine = UIView()
    let centerIceCircle = UIView()
    
    let homeTopNeutralDot = UIView()
    let homeBottomNeutralDot = UIView()
    let awayTopNeutralDot = UIView()
    let awayBottomNeutralDot = UIView()
    
    var faceoffCirlces: [UIView] = []
    
    // Value must match the width of your view in Storyboard or in code
    let rinkViewWidth: CGFloat = 300.0
    
    // Don't change this constant, used for ratios
    let kRealRinkWidth: CGFloat = 200.0
    // Ratios based on real rink values
    var rinkCornerRatio: CGFloat = 0
    var boardWidthRatio: CGFloat = 0
    
    var goalLineOffset: CGFloat = 0
    var blueLineOffset: CGFloat = 0
    var neutralDotOffset: CGFloat = 0
    
    var boardWidth: CGFloat = 1
    var minorLineWidth: CGFloat = 1
    var majorLineWidth: CGFloat = 1
    var circleWidth: CGFloat = 1
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        faceoffCirlces = [homeTopCircle, homeBottomCircle, awayTopCircle, awayBottomCircle, centerIceCircle]
        self.backgroundColor = .clear
        
        setupConstants()
        drawRink()
    }
    
    func setupConstants() {
        rinkCornerRatio = 28.0 / kRealRinkWidth
        boardWidthRatio = 2 / kRealRinkWidth
        
//        var creaseWidthRatio: CGFloat = 8 / kRealRinkWidth
        
        let minorLineWidthRatio: CGFloat = 1.5 / kRealRinkWidth
        let majorLineWidthRatio: CGFloat = 2.5 / kRealRinkWidth
        minorLineWidth = rinkViewWidth * minorLineWidthRatio
        majorLineWidth = rinkViewWidth * majorLineWidthRatio
        
        let goalLineOffsetRatio: CGFloat = 11 / kRealRinkWidth
        goalLineOffset = rinkViewWidth * goalLineOffsetRatio
        
        let blueLineOffsetRatio: CGFloat = 64 / kRealRinkWidth
        blueLineOffset = rinkViewWidth * blueLineOffsetRatio
        
        let neutralDotRatio: CGFloat = 5 / kRealRinkWidth
        neutralDotOffset = rinkViewWidth * neutralDotRatio
        
        let circleSizeRatio: CGFloat = 30 / kRealRinkWidth
        circleWidth = rinkViewWidth * circleSizeRatio
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Give the rink it's corners and scaled border
        rinkView.layer.cornerRadius = rinkView.bounds.width * rinkCornerRatio
        rinkView.layer.borderWidth = rinkView.bounds.width * boardWidthRatio
        
        for circle in faceoffCirlces {
            circle.layer.cornerRadius = circleWidth / 2
            circle.layer.borderWidth = minorLineWidth
        }
    }
    
    func drawRink() {
        // Draw the base rink with border for bords
        rinkView.backgroundColor = UIColor(red:0.85, green:0.91, blue:0.95, alpha:1.00)
        rinkView.translatesAutoresizingMaskIntoConstraints = false
        rinkView.layer.borderColor = UIColor.black  .cgColor
        rinkView.clipsToBounds = true
        self.addSubview(rinkView)
        
        rinkView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalToSuperview()
        }
        
        // Add the two goal lines
        homeGoalLine.backgroundColor = .red
        homeGoalLine.translatesAutoresizingMaskIntoConstraints = false
        awayGoalLine.backgroundColor = .red
        awayGoalLine.translatesAutoresizingMaskIntoConstraints = false
        rinkView.addSubview(homeGoalLine)
        rinkView.addSubview(awayGoalLine)
        
        homeGoalLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(minorLineWidth)
            make.centerX.equalTo(self.snp.left).offset(goalLineOffset)
        }
        awayGoalLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(minorLineWidth)
            make.centerX.equalTo(self.snp.right).offset(-goalLineOffset)
        }
        
        // Add the blue lines and red line
        homeBlueLine.backgroundColor = .blue
        awayBlueLine.backgroundColor = .blue
        centerIceLine.backgroundColor = .red
        homeBlueLine.translatesAutoresizingMaskIntoConstraints = false
        awayBlueLine.translatesAutoresizingMaskIntoConstraints = false
        centerIceLine.translatesAutoresizingMaskIntoConstraints = false
        rinkView.addSubview(homeBlueLine)
        rinkView.addSubview(awayBlueLine)
        rinkView.addSubview(centerIceLine)
        
        homeBlueLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(majorLineWidth)
            make.centerX.equalTo(self.snp.left).offset(blueLineOffset)
        }
        awayBlueLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(majorLineWidth)
            make.centerX.equalTo(self.snp.right).offset(-blueLineOffset)
        }
        centerIceLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(majorLineWidth)
            make.centerX.equalToSuperview()
        }
        
        // Add all of the faceoff circles, corners handled in layoutSubviews
        for circle in faceoffCirlces {
            circle.backgroundColor = .clear
            circle.layer.borderColor = UIColor.red.cgColor
            circle.translatesAutoresizingMaskIntoConstraints = false
            rinkView.addSubview(circle)
        }
        
        homeTopCircle.snp.makeConstraints { (make) in
            make.height.equalTo(circleWidth)
            make.width.equalTo(circleWidth)
        }
        
        homeBottomCircle.snp.makeConstraints { (make) in
            make.height.equalTo(circleWidth)
            make.width.equalTo(circleWidth)
        }
        
        awayTopCircle.snp.makeConstraints { (make) in
            make.height.equalTo(circleWidth)
            make.width.equalTo(circleWidth)
        }
        
        awayBottomCircle.snp.makeConstraints { (make) in
            make.height.equalTo(circleWidth)
            make.width.equalTo(circleWidth)
        }
        
        centerIceCircle.snp.makeConstraints { (make) in
            make.height.equalTo(circleWidth)
            make.width.equalTo(circleWidth)
            make.center.equalToSuperview()
        }
        
        
    }
    
   
    
}
