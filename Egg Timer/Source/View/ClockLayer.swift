//
//  ClockView.swift
//  Egg Timer
//
//  Created by 홍승현 on 2022/05/20.
//

import UIKit

import SnapKit
import Then

final class ClockLayer: CALayer {
  
  private enum Metrics {
    
    static let clockLineCount = 12
    
    static let borderLength = 25.0
    
  }
  
  // MARK: - CA Properties Part
  
  /// 타이머 animation ui
  private let shapeLayer = CAShapeLayer().then {
    $0.strokeColor = Color.appPointColor.cgColor
    $0.fillColor = UIColor.clear.cgColor
  }
  
  /// 타이머 뒷 배경, animation 없는 decoration layer입니다.
  private let trackLayer = CAShapeLayer().then {
    $0.fillColor = UIColor.white.cgColor
  }
  
  /// 아날로그 시계선에 해당합니다.
  private let clockLineLayers: [CAShapeLayer] = {
    var layerArray = [CAShapeLayer]()
    
    // 정해진 선의 개수만큼 처리
    for i in 0..<Metrics.clockLineCount {
      
      let lineLayer = CAShapeLayer()
      lineLayer.fillColor = UIColor.black.cgColor
      lineLayer.strokeColor = UIColor.black.cgColor
      lineLayer.lineWidth = 2
      
      // line을 dash로 변경 (호에 붙어있지 않는 느낌을 주기 위함)
      lineLayer.lineDashPattern = [10]
      lineLayer.lineDashPhase = 10
      
      layerArray.append(lineLayer)
    }
    
    return layerArray
  }()
  
  /// 시계 가운데 동그라미입니다.
  private let centerCircleLayer = CALayer().then {
    $0.backgroundColor = UIColor.red.cgColor
    $0.frame = CGRect(x: -12, y: -12, width: 24, height: 24)
    $0.cornerRadius = $0.bounds.width * 0.5
  }
  
  /// 타이머 시계침입니다.
  private let handsLayer = CAShapeLayer().then {
    $0.lineWidth = 3
    $0.fillColor = UIColor.red.cgColor
    $0.strokeColor = UIColor.red.cgColor
    
    // 그림자 세팅
    $0.shadowColor = UIColor.clear.withAlphaComponent(0.5).cgColor
    $0.shadowOpacity = 1
    $0.shadowRadius = 3
    $0.shadowOffset = CGSize(width: 1, height: 0)
  }
  
  
  // MARK: - Custom Properties Part
  
  private let animation = CABasicAnimation(keyPath: "strokeStart").then {
    $0.fromValue = 0 // 0부터
    $0.toValue = 1   // 1까지
    $0.isRemovedOnCompletion = false // 애니메이션 초기화 안되게 함
    $0.fillMode = .forwards // 애니메이션이 끝난 결과를 그대로 유지
  }
  
  private let lineAnimation = CABasicAnimation(keyPath: "transform.rotation").then {
    $0.fromValue = 0
    $0.toValue = 2 * CGFloat.pi
    $0.isRemovedOnCompletion = false // 애니메이션 초기화 안되게 함
    $0.fillMode = .forwards // 애니메이션이 끝난 결과를 그대로 유지
  }
  
  private let diameter: Double
  
  // MARK: - Initialize Part
  
  /// 시계 UI를 만들기 위한 CALayer로 생성되고 리턴합니다.
  ///
  /// - Parameters:
  ///   - diameter: 원의 지름
  init(diameter: Double) {
    self.diameter = diameter
    super.init()
    setupLayouts()
    setupStyles()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /// sublayer를 세팅합니다.
  private func setupLayouts() {
    addSublayer(trackLayer)
    
    clockLineLayers.forEach { layer in
      addSublayer(layer)
    }
    
    addSublayer(shapeLayer)
    
    addSublayer(handsLayer)
    addSublayer(centerCircleLayer)
  }
  
  private func setupStyles() {
    
    // MARK: 시계선
    
    // 각도 (radian)
    var degree: CGFloat = 0
    
    clockLineLayers.forEach { layer in
      
      let path = UIBezierPath()
      
      let startX = cos(degree) * 1 * (diameter + Metrics.borderLength)
      let startY = sin(degree) * 1 * (diameter + Metrics.borderLength)
      
      let endX = cos(degree) * 1 * (diameter)
      let endY = sin(degree) * 1 * (diameter)
      
      // 선 그리기
      path.move(to: CGPoint(x: startX, y: startY))
      path.addLine(to: CGPoint(x: endX, y: endY))
      path.close()
      
      layer.path = path.cgPath
      
      // 2π ÷ 시계선 개수
      degree += 2 * .pi / CGFloat(clockLineLayers.count)
    }
    
    // MARK: 시계침
    
    let linePath = UIBezierPath()
    linePath.move(to: CGPoint(x: 0, y: 0))
    linePath.addLine(to: CGPoint(x: 0, y: -diameter)) // 12시를 바라보게 세팅
    handsLayer.path = linePath.cgPath
    
  }
  
  /// 아날로그 시계 UI를 보여줍니다.
  func displayAnalogClock() {
    
    let path = UIBezierPath(
      arcCenter: CGPoint(x: 0, y: 0),
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
    
    
    // 시계선이 보이도록 세팅
    clockLineLayers.forEach { layer in
      layer.isHidden = false
    }
    
    // 시계 가운데 동그라미 보여주기
    centerCircleLayer.isHidden = false
    handsLayer.isHidden = false
  }
  
  
  /// 디지털 시계 UI를 보여줍니다.
  func displayDigitalClock() {
    
    let path = UIBezierPath(
      arcCenter: CGPoint(x: 0, y: 0),
      radius: diameter,
      startAngle: -(.pi / 2),
      endAngle: .pi * 3 / 2,
      clockwise: true
    )
    
    
    shapeLayer.path = path.cgPath
    trackLayer.path = path.cgPath
    
    
    trackLayer.lineWidth = 15
    shapeLayer.lineWidth = 15
    
    trackLayer.strokeColor = UIColor.lightGray.cgColor
    
    
    // 시계선이 보이지 않도록 세팅
    clockLineLayers.forEach { layer in
      layer.isHidden = true
    }
    
    // 시계 가운데 동그라미, 시계침 숨기기
    centerCircleLayer.isHidden = true
    handsLayer.isHidden = true
  }
  
  
  /// 시계 애니메이션을 진행합니다.
  func animate(duration: CFTimeInterval) {
    animation.duration = duration
    lineAnimation.duration = duration
    shapeLayer.add(animation, forKey: "clockAnimation")
    handsLayer.add(lineAnimation, forKey: "moveHands")
  }
}
