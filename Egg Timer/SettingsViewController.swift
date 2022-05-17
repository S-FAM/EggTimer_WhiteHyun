import UIKit

class SettingsViewController: BaseViewController {
  
  typealias Setting = (labelText: String, tag: Int)
  
  
  let settings: [Setting] = [
    ("Digital/Analog", 0)
  ]
  
  // MARK: - UI Property Part
  
  let titleLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 51, weight: .bold)
    $0.text = "Settings"
    $0.sizeToFit()
  }
  
  let tableView = UITableView().then {
    $0.register(
      SettingTableViewCell.self,
      forCellReuseIdentifier: SettingTableViewCell.cellIdentifier
    )
    $0.backgroundColor = .clear
  }
  
  let subBackgroundView = UIView().then {
    $0.backgroundColor = Color.appSubBackgroundColor
    $0.layer.cornerRadius = 35
    $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
  }
  
  let backButton = UIButton().then {
    $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    $0.tintColor = Color.appPointColor
  }
  
  //MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
  }
  
  override func setupLayout() {
    super.setupLayout()
    
    view.addSubview(subBackgroundView)
    view.addSubview(tableView)
    view.addSubview(titleLabel)
    view.addSubview(backButton)
    
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    // MARK: Title Constraints
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(80)
      make.centerX.equalTo(view.center.x)
    }
    
    // MARK: SubBackground View Constraints
    
    subBackgroundView.snp.makeConstraints { make in
      make.edges.equalTo(UIEdgeInsets(top: 176, left: 0, bottom: 0, right: 0))
    }
    
    // MARK: Table View Constraints
    tableView.snp.makeConstraints { make in
      make.top.equalTo(subBackgroundView.snp.top).offset(50)
      make.leading.trailing.equalToSuperview().inset(20)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
    
    // MARK: Button Constraints
    
    backButton.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
    }
    
  }
  
  override func setupStyle() {
    super.setupStyle()
    navigationController?.isNavigationBarHidden = true
    view.backgroundColor = Color.appBackgroundColor
  }
}

extension SettingsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return settings.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: SettingTableViewCell.cellIdentifier,
      for: indexPath
    ) as? SettingTableViewCell else {
      return UITableViewCell()
    }
    
    cell.label.text = settings[indexPath.row].labelText
    
    return cell
  }
  
  
}
