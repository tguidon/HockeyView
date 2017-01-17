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
    
    // Creases
    let homeCrease = UIView()
    let awayCrease = UIView()
    
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
    var creases: [UIView] = []
    
    // VARS
    
//    let iceColor: UIColor = UIColor(red:0.85, green:0.91, blue:0.95, alpha:1.00)
//    var iceColor: UIColor = UIColor(red:0.85, green:0.91, blue:0.94, alpha:1.00)
    var iceColor: UIColor = .white
    var rinkRed: UIColor = UIColor(red:0.91, green:0.36, blue:0.45, alpha:1.00)
    var rinkBlue: UIColor = UIColor(red:0.32, green:0.63, blue:0.82, alpha:1.00)
    var rinkBlack: UIColor = UIColor(red:0.27, green:0.27, blue:0.32, alpha:1.00)
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
    var creaseWidth: CGFloat = 1
    var creaseHeight: CGFloat = 1
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        faceoffCircles = [homeTopCircle, homeBottomCircle, awayTopCircle, awayBottomCircle, centerIceCircle]
        faceoffCircleDots = [homeTopCircleDot, homeBottomCircleDot, awayTopCircleDot, awayBottomCircleDot]
        neutralZoneDots = [homeTopNeutralDot, homeBottomNeutralDot, awayTopNeutralDot, awayBottomNeutralDot]
        creases = [homeCrease, awayCrease]
        
        self.backgroundColor = .clear
        
        setupConstants()
        drawRink()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Give the rink it's corners and scaled border
        rinkView.layer.cornerRadius = rinkView.bounds.width * rinkCornerRatio
        rinkView.layer.borderWidth = rinkView.bounds.width * boardWidthRatio
    }
    
    func drawRink() {
        // Draw the base rink with border for bords
        rinkView.backgroundColor = iceColor
        rinkView.translatesAutoresizingMaskIntoConstraints = false
        rinkView.layer.borderColor = rinkBlack.cgColor
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
        homeGoalLine.backgroundColor = rinkRed
        homeGoalLine.translatesAutoresizingMaskIntoConstraints = false
        awayGoalLine.backgroundColor = rinkRed
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
        homeBlueLine.backgroundColor = rinkBlue
        awayBlueLine.backgroundColor = rinkBlue
        centerIceLine.backgroundColor = rinkRed
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
        
        
        // Add all of the faceoff circles, lines, and dots
        for circle in faceoffCircles {
            circle.backgroundColor = iceColor
            circle.layer.borderColor = rinkRed.cgColor
            circle.translatesAutoresizingMaskIntoConstraints = false
            
            circle.layer.cornerRadius = circleWidth / 2
            circle.layer.borderWidth = minorLineWidth
            
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
        centerIceCircle.layer.borderColor = rinkBlue.cgColor
        
        
        // Add the dashes to the circles
        for index in 0...3 {
            let leftLine = UIView()
            let rightLine = UIView()
            let lines: [UIView] = [leftLine, rightLine]
            for line in lines {
                line.backgroundColor = rinkRed
                line.translatesAutoresizingMaskIntoConstraints = false
                faceoffCircles[index].addSubview(line)
            }
            leftLine.snp.makeConstraints({ (make) in
                make.height.equalToSuperview().multipliedBy(1.2)
                make.width.equalTo(minorLineWidth)
                make.centerX.equalToSuperview().offset(-5)
                make.centerY.equalToSuperview()
            })
            rightLine.snp.makeConstraints({ (make) in
                make.height.equalToSuperview().multipliedBy(1.2)
                make.width.equalTo(minorLineWidth)
                make.centerX.equalToSuperview().offset(5)
                make.centerY.equalToSuperview()
            })
        }
        
        // Mask it with a view, I was lazy here and couldnt get a proper mask later to work
        for index in 0...3 {
            let v = UIView()
            v.backgroundColor = iceColor
            v.translatesAutoresizingMaskIntoConstraints = false
            faceoffCircles[index].addSubview(v)
            
            v.snp.makeConstraints({ (make) in
                make.top.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
            })
            v.layer.cornerRadius = circleWidth / 2
        }
        
        // Add the faceoff dots to the circles
        // go to index of 3 to skip center ice
        for index in 0...3 {
            faceoffCircleDots[index].backgroundColor = rinkRed
            faceoffCircleDots[index].translatesAutoresizingMaskIntoConstraints = false
            faceoffCircles[index].addSubview(faceoffCircleDots[index])
            
            faceoffCircleDots[index].snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.equalTo(dotWidth)
                make.height.equalTo(dotWidth)
            }
            faceoffCircleDots[index].layer.cornerRadius = dotWidth / 2
        }
        
        
        // Add center ice dot
        centerIceDot.backgroundColor = rinkBlue
        centerIceDot.translatesAutoresizingMaskIntoConstraints = false
        rinkView.addSubview(centerIceDot)
        centerIceDot.snp.makeConstraints { (make) in
            make.height.equalTo(centerDotWidth)
            make.width.equalTo(centerDotWidth)
            make.center.equalToSuperview()
        }
        centerIceDot.layer.zPosition = 101
        centerIceDot.layer.cornerRadius = centerDotWidth / 2
        
        
        // Add the neutral zone dots
        for dot in neutralZoneDots {
            dot.backgroundColor = rinkRed
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
        for dot in neutralZoneDots {
            dot.layer.cornerRadius = dotWidth / 2
        }
        
        // Add the two goal creases
        for crease in creases {
            crease.backgroundColor = UIColor.clear
            crease.translatesAutoresizingMaskIntoConstraints = false
            rinkView.addSubview(crease)
        }
        homeCrease.snp.makeConstraints { (make) in
            make.height.equalTo(creaseHeight)
            make.width.equalTo(creaseWidth)
            make.centerY.equalToSuperview()
            make.left.equalTo(homeGoalLine.snp.right).offset(-minorLineWidth * 0.5)
        }
        awayCrease.snp.makeConstraints { (make) in
            make.height.equalTo(creaseHeight)
            make.width.equalTo(creaseWidth)
            make.centerY.equalToSuperview()
            make.right.equalTo(awayGoalLine.snp.left).offset(minorLineWidth * 0.5)
        }
        
        // Bezier path to get that curve on the crease
        let homeGoalShapeLayer = CAShapeLayer()
        let awayGoalShapeLayer = CAShapeLayer()
        let goalShapeLayers: [CAShapeLayer] = [homeGoalShapeLayer, awayGoalShapeLayer]
        
        for goal in goalShapeLayers {
            goal.path = returnGoalBezierPath().cgPath
            goal.strokeColor = rinkRed.cgColor
            goal.fillColor = UIColor.blue.withAlphaComponent(0.2).cgColor
            goal.position = CGPoint(x: 0, y: 0)
            goal.lineWidth = minorLineWidth * 0.5
        }
        
        homeCrease.layer.addSublayer(homeGoalShapeLayer)
        awayCrease.layer.addSublayer(awayGoalShapeLayer)
        awayCrease.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
    }
    
    func returnGoalBezierPath() -> UIBezierPath {
        let goalPath = UIBezierPath()
        goalPath.move(to: CGPoint(x: 0, y: 0))
        goalPath.addLine(to: CGPoint(x: creaseWidth * (2/3), y: 0))
        goalPath.addCurve(to: CGPoint(x: creaseWidth, y: creaseHeight / 2), controlPoint1: CGPoint(x: creaseWidth * (2/3), y: 0), controlPoint2: CGPoint(x: creaseWidth, y: creaseHeight * (1/4)))
        goalPath.addCurve(to: CGPoint(x: creaseWidth * (2/3), y: creaseHeight), controlPoint1: CGPoint(x: creaseWidth, y: creaseHeight * (3/4)), controlPoint2: CGPoint(x: creaseWidth * (2/3), y: creaseHeight))
        goalPath.addCurve(to: CGPoint(x: 0, y: creaseHeight), controlPoint1: CGPoint(x: creaseWidth / 2, y: creaseHeight), controlPoint2: CGPoint(x: 0, y: creaseHeight))
        goalPath.addLine(to: CGPoint(x: 0, y: 0))
        goalPath.close()
        
        return goalPath
    }
    
    func setupConstants() {
        rinkViewHeight = rinkViewWidth * (17 / 40)
        
        rinkCornerRatio = 28.0 / kRealRinkWidth
        boardWidthRatio = 1.5 / kRealRinkWidth
        
        let minorLineWidthRatio: CGFloat = 1.0 / kRealRinkWidth
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
        
        let dotSizeRatio: CGFloat = 2.5 / kRealRinkWidth
        dotWidth = rinkViewWidth * dotSizeRatio
        
        let centerDotSizeRatio: CGFloat = 1.5 / kRealRinkWidth
        centerDotWidth = rinkViewWidth * centerDotSizeRatio
        
        let faceoffCircleRatio: CGFloat = 22 / kRealRinkWidth
        let faceOffGapRatio: CGFloat = 44 / kRealRinkHeight
        faceoffHorizontalOffset = rinkViewWidth * faceoffCircleRatio
        faceoffVerticalOffset = (rinkViewHeight * faceOffGapRatio) / 2
        
        let creaseWidthRatio: CGFloat = 6 / kRealRinkWidth
        let creaseHeightRatio: CGFloat = 8 / kRealRinkHeight
        creaseWidth = rinkViewWidth * creaseWidthRatio
        creaseHeight = rinkViewHeight * creaseHeightRatio
    }
}
