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
  
  func setupLayout() {
    
  }
  
  
  func setupConstraints() {
    
  }
  
  
  func setupStyle() {
    view.backgroundColor = .white
  }
}
