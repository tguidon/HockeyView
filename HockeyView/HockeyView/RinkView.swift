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
    
    // UI
    
    // rinkView holds the rink's UI elements
    // dataView holds potential data overlays
    let rinkView = UIView()
    let dataView = UIView()
    
    // Views for rink elements
    // Lines
    let homeGoalLine = UIView()
    let awayGoalLine = UIView()
    let homeBlueLine = UIView()
    let awayBlueLine = UIView()
    
    // Faceoff Circles
    let homeTopCircle = UIView()
    let homeBottomCircle = UIView()
    let awayTopCircle = UIView()
    let awayBottomCircle = UIView()
    let homeTopCircleDot = UIView()
    let homeBottomCircleDot = UIView()
    let awayTopCircleDot = UIView()
    let awayBottomCircleDot = UIView()
    
    // Center Ice
    let centerIceLine = UIView()
    let centerIceCircle = UIView()
    let centerIceDot = UIView()
    
    // Neutral Zone
    let homeTopNeutralDot = UIView()
    let homeBottomNeutralDot = UIView()
    let awayTopNeutralDot = UIView()
    let awayBottomNeutralDot = UIView()
    
    // View Arrays
    var faceoffCircles: [UIView] = []
    var faceoffCircleDots: [UIView] = []
    var neutralZoneDots: [UIView] = []
    
    // VARS
    
    // Value must match the width of your view in Storyboard or in code
    let rinkViewWidth: CGFloat = 300.0
    // Set in setupConstants
    var rinkViewHeight: CGFloat = 0
    
    // Don't change this constant, used for ratios
    let kRealRinkWidth: CGFloat = 200.0
    let kRealRinkHeight: CGFloat = 85.0
    // Ratios based on real rink values
    var rinkCornerRatio: CGFloat = 0
    var boardWidthRatio: CGFloat = 0
    
    var goalLineOffset: CGFloat = 0
    var blueLineOffset: CGFloat = 0
    var neutralDotOffset: CGFloat = 0
    var faceoffHorizontalOffset: CGFloat = 0
    var faceoffVerticalOffset: CGFloat = 0
    
    var boardWidth: CGFloat = 1
    var minorLineWidth: CGFloat = 1
    var majorLineWidth: CGFloat = 1
    var circleWidth: CGFloat = 1
    var dotWidth: CGFloat = 1
    var centerDotWidth: CGFloat = 1
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        faceoffCircles = [homeTopCircle, homeBottomCircle, awayTopCircle, awayBottomCircle, centerIceCircle]
        faceoffCircleDots = [homeTopCircleDot, homeBottomCircleDot, awayTopCircleDot, awayBottomCircleDot]
        neutralZoneDots = [homeTopNeutralDot, homeBottomNeutralDot, awayTopNeutralDot, awayBottomNeutralDot]
        
        self.backgroundColor = .clear
        
        setupConstants()
        drawRink()
    }
    
    func setupConstants() {
        rinkViewHeight = rinkViewWidth * (17 / 40)
        
        rinkCornerRatio = 28.0 / kRealRinkWidth
        boardWidthRatio = 2 / kRealRinkWidth
        
//        var creaseWidthRatio: CGFloat = 8 / kRealRinkWidth
        
        let minorLineWidthRatio: CGFloat = 1.5 / kRealRinkWidth
        let majorLineWidthRatio: CGFloat = 2.0 / kRealRinkWidth
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
        
        let dotSizeRatio: CGFloat = 2 / kRealRinkWidth
        dotWidth = rinkViewWidth * dotSizeRatio
        
        let centerDotSizeRatio: CGFloat = 1.5 / kRealRinkWidth
        centerDotWidth = rinkViewWidth * centerDotSizeRatio
        print(centerDotWidth)
        
        let faceoffCircleRatio: CGFloat = 22 / kRealRinkWidth
        faceoffHorizontalOffset = rinkViewWidth * faceoffCircleRatio
        let faceOffGapRatio: CGFloat = 44 / kRealRinkHeight
        faceoffVerticalOffset = (rinkViewHeight * faceOffGapRatio) / 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Give the rink it's corners and scaled border
        rinkView.layer.cornerRadius = rinkView.bounds.width * rinkCornerRatio
        rinkView.layer.borderWidth = rinkView.bounds.width * boardWidthRatio
        
        // Faceoff Circle radius
        for circle in faceoffCircles {
            circle.layer.cornerRadius = circleWidth / 2
            circle.layer.borderWidth = minorLineWidth
        }
        centerIceCircle.layer.borderColor = UIColor.blue.cgColor
        
        // Dot radius
        for dot in faceoffCircleDots {
            dot.layer.cornerRadius = dotWidth / 2
        }
        for dot in neutralZoneDots {
            dot.layer.cornerRadius = dotWidth / 2
        }
        centerIceDot.layer.cornerRadius = centerDotWidth / 2
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
            make.centerX.equalTo(homeGoalLine.snp.right).offset(blueLineOffset)
        }
        awayBlueLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(majorLineWidth)
            make.centerX.equalTo(awayGoalLine.snp.left).offset(-blueLineOffset)
        }
        centerIceLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(majorLineWidth)
            make.centerX.equalToSuperview()
        }
        centerIceLine.layer.zPosition = 100
        
        // Add all of the faceoff circles, corners handled in layoutSubviews
        for circle in faceoffCircles {
            circle.backgroundColor = .clear
            circle.layer.borderColor = UIColor.red.cgColor
            circle.translatesAutoresizingMaskIntoConstraints = false
            rinkView.addSubview(circle)
        }
        
        homeTopCircle.snp.makeConstraints { (make) in
            make.height.equalTo(circleWidth)
            make.width.equalTo(circleWidth)
            make.centerX.equalTo(homeGoalLine.snp.right).offset(faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.top).offset(faceoffVerticalOffset)
        }
        
        homeBottomCircle.snp.makeConstraints { (make) in
            make.height.equalTo(circleWidth)
            make.width.equalTo(circleWidth)
            make.centerX.equalTo(homeGoalLine.snp.right).offset(faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.bottom).offset(-faceoffVerticalOffset)
        }
        
        awayTopCircle.snp.makeConstraints { (make) in
            make.height.equalTo(circleWidth)
            make.width.equalTo(circleWidth)
            make.centerX.equalTo(awayGoalLine.snp.left).offset(-faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.top).offset(faceoffVerticalOffset)
        }
        
        awayBottomCircle.snp.makeConstraints { (make) in
            make.height.equalTo(circleWidth)
            make.width.equalTo(circleWidth)
            make.centerX.equalTo(awayGoalLine.snp.left).offset(-faceoffHorizontalOffset)
            make.centerY.equalTo(self.snp.bottom).offset(-faceoffVerticalOffset)
        }
        
        centerIceCircle.snp.makeConstraints { (make) in
            make.height.equalTo(circleWidth)
            make.width.equalTo(circleWidth)
            make.center.equalToSuperview()
        }
        
        // Add the faceoff dots to the circles
        // go to index of 3 to skip center ice
        for index in 0...3 {
            faceoffCircleDots[index].backgroundColor = .red
            faceoffCircleDots[index].translatesAutoresizingMaskIntoConstraints = false
            faceoffCircles[index].addSubview(faceoffCircleDots[index])
            
            faceoffCircleDots[index].snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.equalTo(dotWidth)
                make.height.equalTo(dotWidth)
            }
        }
        
        // Add cener ice dot
        centerIceDot.backgroundColor = .blue
        centerIceDot.translatesAutoresizingMaskIntoConstraints = false
        rinkView.addSubview(centerIceDot)
        
        centerIceDot.snp.makeConstraints { (make) in
            make.height.equalTo(centerDotWidth)
            make.width.equalTo(centerDotWidth)
            make.center.equalToSuperview()
        }
        centerIceDot.layer.zPosition = 101
        
        for dot in neutralZoneDots {
            dot.backgroundColor = .red
            dot.translatesAutoresizingMaskIntoConstraints = false
            rinkView.addSubview(dot)
        }
        
        homeTopNeutralDot.snp.makeConstraints { (make) in
            make.height.equalTo(dotWidth)
            make.width.equalTo(dotWidth)
            make.centerX.equalTo(homeBlueLine.snp.right).offset(neutralDotOffset)
            make.centerY.equalTo(homeTopCircleDot)
        }
        
        homeBottomNeutralDot.snp.makeConstraints { (make) in
            make.height.equalTo(dotWidth)
            make.width.equalTo(dotWidth)
            make.centerX.equalTo(homeBlueLine.snp.right).offset(neutralDotOffset)
            make.centerY.equalTo(homeBottomCircleDot)
        }
        
        awayTopNeutralDot.snp.makeConstraints { (make) in
            make.height.equalTo(dotWidth)
            make.width.equalTo(dotWidth)
            make.centerX.equalTo(awayBlueLine.snp.left).offset(-neutralDotOffset)
            make.centerY.equalTo(homeTopCircleDot)
        }
        
        awayBottomNeutralDot.snp.makeConstraints { (make) in
            make.height.equalTo(dotWidth)
            make.width.equalTo(dotWidth)
            make.centerX.equalTo(awayBlueLine.snp.left).offset(-neutralDotOffset)
            make.centerY.equalTo(homeBottomCircleDot)
        }
        
        
    }
}
