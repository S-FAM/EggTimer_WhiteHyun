//
//  BaseViewController.swift
//  Egg Timer
//
//  Created by 홍승현 on 2022/05/17.
//

import UIKit

class BaseViewController: UIViewController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    setupConstraints()
    setupStyle()
  }
  
  //MARK: - Constraint, Style, Action Configuration
  
  /// layout을 설정합니다.
  /// `addSubview(_:)`와 같은 코드를 이 함수에서 적용시킵니다.
  func setupLayout() {
    
  }
  
  
  /// 세팅한 layout의 constraint를 설정합니다.
  func setupConstraints() {
    
  }
  
  
  func setupStyle() {
    view.backgroundColor = .white
  }
}
