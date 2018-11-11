//
//  QDHeaderTabbarViewController.swift
//  QD
//
//  Created by QD on 2018/10/29.
//  Copyright © 2018 QD. All rights reserved.
//

import UIKit
import SnapKit

public class QDHeaderTabbarViewController: UIViewController {
    /// 数据源
    public var dataSources: [(String, UIViewController)]? {
        didSet {
            for (title, vc) in dataSources ?? [] {
                titles.append(title)
                viewContrllers.append(vc)
            }
            
            headerItemWidth = CGFloat.screenWidth / CGFloat(titles.count)
        }
    }
    
    /// title height 默认 屏幕均分
    public var headerItemWidth: CGFloat = 0
    
    /// title height 默认40
    public var headerHeight: CGFloat = .headerHeight
    
    public var selectedTintColor: UIColor = .red
    
    public var unSelectedTintColor: UIColor = .black
    
    public var unSelectedTitleFont = UIFont.systemFont(ofSize: 15)
    
    public var selectedTitleFont = UIFont.systemFont(ofSize: 15)
    
    public var lineViewColor = UIColor.lineViewColor
    
    fileprivate var titles = [String]()
    fileprivate var viewContrllers = [UIViewController]()
    
    fileprivate var headerCollectionView: UICollectionView?
    fileprivate var bottomCollectionView: UICollectionView?
    
    fileprivate var selectedIndex = 0
    fileprivate var lastSelectedIndex = 0

    override public func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }
    
    func setupSubviews() {
        QDConfiguration.shared.headerSelectedColor = selectedTintColor
        QDConfiguration.shared.headerUnselectedColor = unSelectedTintColor
        QDConfiguration.shared.unSelectedTitleFont = unSelectedTitleFont
        QDConfiguration.shared.selectedTitleFont = selectedTitleFont
        QDConfiguration.shared.lineViewColor = lineViewColor
        view.backgroundColor = UIColor.white
        
        let headerLayout = UICollectionViewFlowLayout()
        headerLayout.estimatedItemSize = CGSize(width: self.headerItemWidth, height: self.headerHeight)
        headerLayout.scrollDirection = .horizontal
        headerLayout.minimumLineSpacing = 0
        headerLayout.minimumInteritemSpacing = 0
        let bottomLayout = UICollectionViewFlowLayout()
        bottomLayout.estimatedItemSize = CGSize(width: view.frame.width, height: 612 - .headerHeight)
        bottomLayout.scrollDirection = .horizontal
        bottomLayout.minimumLineSpacing = 0
        bottomLayout.minimumInteritemSpacing = 0
        
        headerCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: headerLayout)
        headerCollectionView?.register(HeaderCell.self, forCellWithReuseIdentifier: "cell")
        headerCollectionView?.showsHorizontalScrollIndicator = false
        headerCollectionView?.backgroundColor = .white
        headerCollectionView?.bounces = false
        bottomCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: bottomLayout)
        for (index, _) in viewContrllers.enumerated() {
            bottomCollectionView?.register(BottomCell.self, forCellWithReuseIdentifier: "bottomCell\(index)")
        }
        bottomCollectionView?.isPagingEnabled = true
        bottomCollectionView?.backgroundColor = UIColor.white
        bottomCollectionView?.showsHorizontalScrollIndicator = false
        guard let headerCollectionView = self.headerCollectionView else { return  }
        guard let bottomCollectionView = self.bottomCollectionView else { return  }
        view.addSubview(headerCollectionView)
        view.addSubview(bottomCollectionView)
        
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self

        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        
        headerCollectionView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.top)
            }
            make.left.right.equalTo(self.view)
            make.height.equalTo(self.headerHeight)
        }
        bottomCollectionView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.view)
            make.top.equalTo(headerCollectionView.snp.bottom)
        }
        
        headerCollectionView.reloadData()
        bottomCollectionView.reloadData()
    }
   
}

extension QDHeaderTabbarViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == headerCollectionView {let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HeaderCell
           
            cell.titlelabel.text = titles[indexPath.row]
            if selectedIndex == indexPath.row {
                cell.state = true
            } else {
                cell.state = false
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell\(indexPath.row)", for: indexPath) as! BottomCell
            cell.contentView.backgroundColor = UIColor.white
            let vc = viewContrllers[indexPath.row]
            if !children.contains(vc) {
                addChild(vc)
            }
            cell.view = vc.view
            
            return cell
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == headerCollectionView {
            selectedIndex = indexPath.item
            collectionView.reloadData()
            
            var animated = true
            if abs(selectedIndex - lastSelectedIndex) > 1 {
                animated = false
            }
            lastSelectedIndex = selectedIndex
            
            bottomCollectionView?.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: animated)
        
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == headerCollectionView {
            return CGSize(width: self.headerItemWidth, height: self.headerHeight)
        }
        let width = view.frame.width
        let height =  bottomCollectionView?.frame.height ?? 0
        
        let cellSize = CGSize(width: width, height: height)
        return cellSize
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == bottomCollectionView {
            guard let bottomCollectionView = self.bottomCollectionView else { return }
            
            var visibleRect = CGRect()
            visibleRect.origin = bottomCollectionView.contentOffset
            visibleRect.size = bottomCollectionView.bounds.size
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.maxY)
            guard let indexPath = bottomCollectionView.indexPathForItem(at: visiblePoint) else { return }
            
            selectedIndex = indexPath.row
            headerCollectionView?.reloadData()
            
            headerCollectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
   
}
// MARK: - views -
fileprivate class HeaderCell: UICollectionViewCell {
    var state: Bool? {
        didSet {
            if state == true {
                titlelabel.font = QDConfiguration.shared.selectedTitleFont
                titlelabel.textColor = QDConfiguration.shared.headerSelectedColor
                hintView.backgroundColor = QDConfiguration.shared.headerSelectedColor
            } else {
                titlelabel.font = QDConfiguration.shared.unSelectedTitleFont
                titlelabel.textColor = QDConfiguration.shared.headerUnselectedColor
                hintView.backgroundColor = .clear
            }
        }
    }
    
    let titlelabel = UILabel()
    let hintView = UIView()
    let lineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(titlelabel)
        contentView.addSubview(lineView)
        contentView.addSubview(hintView)
        
        lineView.backgroundColor = QDConfiguration.shared.lineViewColor
        titlelabel.font = UIFont.systemFont(ofSize: 15)
        
        layoutCellViews()
    }
    func layoutCellViews() {
        titlelabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(1)
        }
        hintView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(2)
        }
    }
    
    
}
fileprivate class BottomCell: UICollectionViewCell {
    var view: UIView?{
        didSet {
            if view != nil {
                contentView.addSubview(view!)
                layoutMainView()
            }
        }
    }
    
    func layoutMainView() {
        view?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
    }
    
}

fileprivate struct QDConfiguration {
    static var shared = QDConfiguration()
    
    var headerSelectedColor = UIColor.red
    
    var headerUnselectedColor = UIColor.black
    
    var unSelectedTitleFont = UIFont.systemFont(ofSize: 15)
    
    var selectedTitleFont = UIFont.systemFont(ofSize: 15)
    
    var lineViewColor = UIColor.lineViewColor
}

fileprivate extension UIColor {
    static let lineViewColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
}

fileprivate extension CGFloat {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    
    static let headerHeight = CGFloat(40)
    static let headerItemWidth = CGFloat(screenWidth/4.0)
}
