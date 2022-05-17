//
//  ViewController.swift
//  Egg Timer
//
//  Created by 홍승현 on 2022/05/16.
//

import UIKit

import SnapKit
import Then

final class ViewController: BaseViewController {
  
  private enum Metrics {
    
    static let cornerRadius = 35.0
  }
  
  private let eggTimes = ["Soft": 4.0, "Medium": 7.0, "Hard": 12.0]
  
  var timer = Timer()
  var secondPassed = 0.0
  
  
  //MARK: - CALayer Part
  
  let shape = CAShapeLayer().then {
    $0.strokeColor = Color.appPointColor.cgColor
    $0.fillColor = UIColor.clear.cgColor
    $0.strokeEnd = 0
    $0.lineWidth = 15
  }
  
  let trackShape = CAShapeLayer().then {
    $0.strokeColor = UIColor.lightGray.cgColor
    $0.fillColor = UIColor.white.cgColor
    $0.lineWidth = 15
  }
  
  //MARK: - UI Property Part
  
  let timeLabel = UILabel().then {
    $0.textAlignment = .center
    $0.text = "00:00"
    $0.font = .systemFont(ofSize: 60, weight: .regular)
    $0.sizeToFit()
  }
  
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
    
    view.layer.addSublayer(trackShape)
    view.layer.addSublayer(shape)
    view.addSubview(timeLabel)
    
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
      make.height.equalTo(view.frame.height / 5.8)
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
    
    timeLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(subBackgroundView.snp.top).offset(167)
    }
  }
  
  override func setupStyle() {
    navigationController?.isNavigationBarHidden = true
    view.backgroundColor = Color.appBackgroundColor
    
    softButton.addTarget(self, action: #selector(eggButtonDidTaps(_:)), for: .touchUpInside)
    mediumButton.addTarget(self, action: #selector(eggButtonDidTaps(_:)), for: .touchUpInside)
    hardButton.addTarget(self, action: #selector(eggButtonDidTaps(_:)), for: .touchUpInside)
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupTimerClocks()
  }
  
  //MARK: - Function Part
  
  func setupTimerClocks() {
    let ringPath = UIBezierPath(
      arcCenter: timeLabel.center,
      radius: 150,
      startAngle: -(.pi / 2),
      endAngle: .pi * 2,
      clockwise: true
    )
    shape.path = ringPath.cgPath
    trackShape.path = ringPath.cgPath
  }
  
  func setTimer(seconds time: Double) {
    
    // 값 초기화
    timer.invalidate()
    secondPassed = time
    
    // Animate
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    animation.toValue = 1
    animation.duration = time
    animation.isRemovedOnCompletion = false
    animation.fillMode = .forwards
    shape.add(animation, forKey: "animation")
    
    
    
    // `분:초`로 보여지도록 하기 위해 formatter를 사용
    let dateFormatter = DateFormatter().then {
      $0.dateFormat = "mm:ss"
    }
    
    self.timeLabel.text = dateFormatter.string(
      from: Date(timeIntervalSince1970: TimeInterval(self.secondPassed))
    )
    
    
    // 타이머 설정
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
      if self.secondPassed > 0 {
        
        self.secondPassed -= 1
        let leftTime = Date(timeIntervalSince1970: TimeInterval(self.secondPassed))
        self.timeLabel.text = dateFormatter.string(from: leftTime)
        
      } else {
        
        $0.invalidate()
        self.timeLabel.text = "Done!"
        
      }
      
    }
    
    
  }
  
  @objc func eggButtonDidTaps(_ sender: UIButton) {
    
    guard let hardness = sender.currentTitle,
          let minute = eggTimes[hardness] else {
      
      let alert = UIAlertController(
        title: "오류!",
        message: "버튼에 문제가 있네요.",
        preferredStyle: .alert
      )
      
      alert.addAction(UIAlertAction(title: "확인", style: .default))
      present(alert, animated: true)
      return
    }
    
    setTimer(seconds: minute * 60.0)
  }
}
