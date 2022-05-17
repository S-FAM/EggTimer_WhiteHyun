//
//  ViewController.swift
//  Egg Timer
//
//  Created by 홍승현 on 2022/05/16.
//

import UIKit

import SnapKit
import Then

class ViewController: BaseViewController {
  
  private enum Metrics {
    
    static let cornerRadius = 35.0
  }
  
  
  //MARK: - UI Property Part
  
  let titleLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 51, weight: .bold)
    $0.text = "Egg Timer"
    $0.sizeToFit()
  }
  
  let settingsButton = UIButton(type: .system).then {
    $0.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
    $0.tintColor = Color.appPointColor
  }
  
  let subBackgroundView = UIView().then {
    $0.backgroundColor = Color.appSubBackgroundColor
    $0.layer.cornerRadius = Metrics.cornerRadius
    $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
  }
  
  let softEggImageView = UIImageView().then {
    $0.image = UIImage(named: "soft")
    $0.contentMode = .scaleAspectFit
  }
  
  let mediumEggImageView = UIImageView().then {
    $0.image = UIImage(named: "medium")
    $0.contentMode = .scaleAspectFit
  }
  
  let hardEggImageView = UIImageView().then {
    $0.image = UIImage(named: "hard")
    $0.contentMode = .scaleAspectFit
  }
  
  let softButton = UIButton(type: .system).then {
    $0.setTitle("Soft", for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    $0.contentVerticalAlignment = .bottom
    $0.tintColor = UIColor.black
  }
  
  let mediumButton = UIButton(type: .system).then {
    $0.setTitle("Medium", for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    $0.contentVerticalAlignment = .bottom
    $0.tintColor = UIColor.black
  }
  
  let hardButton = UIButton(type: .system).then {
    $0.setTitle("Hard", for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
    $0.contentVerticalAlignment = .bottom
    $0.tintColor = UIColor.black
  }
  
  let softViewContainer = UIView(frame: .zero)
  let mediumViewContainer = UIView(frame: .zero)
  let hardViewContainer = UIView(frame: .zero)
  
  let eggButtonStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.alignment = .fill
    $0.distribution = .fillEqually
    $0.spacing = 25
    $0.layer.cornerRadius = Metrics.cornerRadius
    $0.backgroundColor = Color.appPointColor.withAlphaComponent(0.5)
  }
  
  //MARK: - UI Setting Part
  
  override func setupLayout() {
    super.setupLayout()
    
    softViewContainer.addSubview(softEggImageView)
    softViewContainer.addSubview(softButton)
    
    mediumViewContainer.addSubview(mediumEggImageView)
    mediumViewContainer.addSubview(mediumButton)
    
    hardViewContainer.addSubview(hardEggImageView)
    hardViewContainer.addSubview(hardButton)
    
    [softViewContainer, mediumViewContainer, hardViewContainer].forEach {
      eggButtonStackView.addArrangedSubview($0)
      
    }
    
    view.addSubview(titleLabel)
    view.addSubview(settingsButton)
    view.addSubview(subBackgroundView)
    view.addSubview(eggButtonStackView)
    
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    
    // MARK: Title Constraints
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(80)
      make.centerX.equalTo(view.center.x)
    }
    
    //MARK: - Settings Button Constraints
    
    settingsButton.snp.makeConstraints { make in
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
      make.width.height.equalTo(38)
    }
    
    // MARK: SubBackground View Constraints
    
    subBackgroundView.snp.makeConstraints { make in
      make.edges.equalTo(UIEdgeInsets(top: 176, left: 0, bottom: 0, right: 0))
    }
    
    // MARK: Egg Stack View Constraints
    
    eggButtonStackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(20)
      make.bottom.equalToSuperview().inset(60)
      make.height.equalTo(158)
    }
    
    // MARK: Egg ImageView Constraints
    
    softEggImageView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview().inset(20)
    }
    
    mediumEggImageView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview().inset(20)
    }
    
    hardEggImageView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview().inset(20)
    }
    
    // MARK: Button Constraints
    
    softButton.snp.makeConstraints { make in
      make.leading.trailing.top.equalToSuperview()
      make.bottom.equalToSuperview().inset(5)
    }
    
    mediumButton.snp.makeConstraints { make in
      make.leading.trailing.top.equalToSuperview()
      make.bottom.equalToSuperview().inset(5)
    }
    
    hardButton.snp.makeConstraints { make in
      make.leading.trailing.top.equalToSuperview()
      make.bottom.equalToSuperview().inset(5)
    }
  }
  
  override func setupStyle() {
    navigationController?.isNavigationBarHidden = true
    view.backgroundColor = Color.appBackgroundColor
  }
}
