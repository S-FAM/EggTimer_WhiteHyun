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
  
  private enum Metrics {
    
    static let clockLineCount = 12
    static let borderLength = 25.0
    
  }
  
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
  
  /// 아날로그 시계선에 해당합니다.
  let clockLineLayers: [CAShapeLayer] = {
    var layerArray = [CAShapeLayer]()
    
    // 정해진 선의 개수만큼 처리
    for i in 0..<Metrics.clockLineCount {
      let lineLayer = CAShapeLayer()
      lineLayer.fillColor = UIColor.black.cgColor
      lineLayer.strokeColor = UIColor.black.cgColor
      lineLayer.lineWidth = 5
      layerArray.append(lineLayer)
    }
    return layerArray
  }()
  
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
    
    clockLineLayers.forEach { layer in
      addSublayer(layer)
    }
    
    addSublayer(shapeLayer)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  func setupLineStyle(center: CGPoint) {
    
    // 각도 (radian)
    var degree: CGFloat = 0
    
    clockLineLayers.forEach { layer in
      
      let path = UIBezierPath()
      
      let startX = cos(degree) * 1 * (diameter + Metrics.borderLength) + center.x
      let startY = sin(degree) * 1 * (diameter + Metrics.borderLength) + center.y
      
      let endX = cos(degree) * 1 * (diameter) + center.x
      let endY = sin(degree) * 1 * (diameter) + center.y
      
      // 선 그리기
      path.move(to: CGPoint(x: startX, y: startY))
      path.addLine(to: CGPoint(x: endX, y: endY))
      path.close()
      
      // line을 dash로 변경
      layer.path = path.cgPath
      layer.lineDashPattern = [10]
      layer.lineDashPhase = 10
      
      layer.lineWidth = 2
      
      // 2π ÷ 시계선 개수
      degree += 2 * .pi / CGFloat(clockLineLayers.count)
    }
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
    
    
    shapeLayer.path = path.cgPath
    trackLayer.path = path.cgPath
    
    
    shapeLayer.lineWidth = diameter
    trackLayer.lineWidth = diameter + Metrics.borderLength * 2 // 살짝 더 크게 (이뻐보이려고 ㅎ)
    
    trackLayer.strokeColor = UIColor.white.cgColor
    
    
    // 시계선 세팅이 되어있지 않다면
    if clockLineLayers[0].path == nil {
      setupLineStyle(center: center)
    }
    
    // 시계선이 보이도록 세팅
    clockLineLayers.forEach { layer in
      layer.isHidden = false
    }
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
    
    
    shapeLayer.path = path.cgPath
    trackLayer.path = path.cgPath
    
    
    
    trackLayer.lineWidth = lineWidth
    shapeLayer.lineWidth = lineWidth
    
    
    trackLayer.strokeColor = UIColor.lightGray.cgColor
    
    // 시계선이 보이지 않도록 세팅
    clockLineLayers.forEach { layer in
      layer.isHidden = true
    }
  }
  
  
  /// 시계 애니메이션을 진행합니다.
  func animate(duration: CFTimeInterval) {
    animation.duration = duration
    shapeLayer.add(animation, forKey: "clockAnimation")
  }
}
