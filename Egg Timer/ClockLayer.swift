//
//  ClockView.swift
//  Egg Timer
//
//  Created by 홍승현 on 2022/05/20.
//

import UIKit

import SnapKit
import Then

class ClockLayer: CALayer {
  
  // MARK: - CA Properties Part
  
  /// 타이머 animation ui
  let shapeLayer = CAShapeLayer().then {
    $0.strokeColor = Color.appPointColor.cgColor
    $0.fillColor = UIColor.clear.cgColor
    $0.strokeEnd = 0
  }
  
  /// 타이머 뒷 배경, animation 없는 decoration layer입니다.
  let trackLayer = CAShapeLayer().then {
    $0.strokeColor = UIColor.lightGray.cgColor
    $0.fillColor = UIColor.white.cgColor
  }
  
  // MARK: - Custom Properties Part
  
  let animation = CABasicAnimation(keyPath: "strokeEnd").then {
    $0.fromValue = 0 // 0부터
    $0.toValue = 1   // 1까지
    $0.isRemovedOnCompletion = false // 애니메이션 코드 재사용
    $0.fillMode = .forwards // 애니메이션 끝나고 다시 초기화되지 않게 함
  }
  
  var diameter: Double
  var lineWidth: CGFloat
  
  // MARK: - Initialize Part
  
  /// 시계 UI를 만들기 위한 CALayer로 생성되고 리턴합니다.
  ///
  /// - Parameters:
  ///   - diameter: 원의 지름
  ///   - lineWidth: 선의 너비
  init(diameter: Double, lineWidth: CGFloat) {
    self.diameter = diameter
    self.lineWidth = lineWidth
    super.init()
    
    shapeLayer.lineWidth = lineWidth
    trackLayer.lineWidth = lineWidth
    
    addSublayer(trackLayer)
    addSublayer(shapeLayer)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  /// 아날로그 시계 UI를 보여줍니다.
  func displayAnalogClock(center: CGPoint) {
    let path = UIBezierPath(
      arcCenter: center,
      radius: 0.5 * diameter,
      startAngle: -(.pi / 2),
      endAngle: .pi * 3 / 2,
      clockwise: true
    )
    
    
    shapeLayer.lineWidth = diameter
    shapeLayer.path = path.cgPath
    trackLayer.isHidden = true
  }
  
  
  /// 디지털 시계 UI를 보여줍니다.
  func displayDigitalClock(center: CGPoint) {
    let path = UIBezierPath(
      arcCenter: center,
      radius: diameter,
      startAngle: -(.pi / 2),
      endAngle: .pi * 3 / 2,
      clockwise: true
    )
    
    
    shapeLayer.lineWidth = lineWidth
    shapeLayer.path = path.cgPath
    trackLayer.path = path.cgPath
    trackLayer.isHidden = false
  }
  
  
  /// 시계 애니메이션을 진행합니다.
  func animate(duration: CFTimeInterval) {
    animation.duration = duration
    shapeLayer.add(animation, forKey: "clockAnimation")
  }
}
