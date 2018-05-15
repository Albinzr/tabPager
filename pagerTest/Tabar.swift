//
//  TabBar.swift
//  pagerTest
//
//  Created by Albin CR on 5/6/18.
//  Copyright © 2018 CR-creation.Gem. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var menuTitle:UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()

    override var isSelected: Bool {
        didSet {
            menuTitle.textColor = isSelected ? UIColor.white : UIColor.black
        }
    }
    
    func setupViews() {
        self.backgroundColor = .green
        addSubview(menuTitle)
        NSLayoutConstraint.activate([
            menuTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            menuTitle.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            menuTitle.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            menuTitle.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            
            ])
    }
    
}



class Tabar: UIScrollView {
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    var horizontalBarWidthAnchorConstraint: NSLayoutConstraint?
     let horizontalBarView = UIView()
    
    func reload(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.tabarCollectionView.reloadData() })
        { _ in completion() }
    }
    
    
    
    public var tabCount:Int = 0 {
        didSet{
            reload {
                let indexPath = IndexPath(row: (self.tabPager?.initialControllerIndex)!, section: 0)
                
                self.tabarCollectionView.scrollToItem(at:indexPath, at: UICollectionViewScrollPosition.left, animated: false)
                 self.tabarCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.left)
                
                let currentCell = self.tabarCollectionView.cellForItem(at: indexPath)
               
                self.horizontalBarLeftAnchorConstraint = self.horizontalBarView.leftAnchor.constraint(equalTo: self.bottomView.leftAnchor, constant: (currentCell?.frame.minX)!)
                self.horizontalBarLeftAnchorConstraint?.isActive = true
                self.horizontalBarWidthAnchorConstraint = self.horizontalBarView.widthAnchor.constraint(equalToConstant: (currentCell?.frame.width)!)
                self.horizontalBarWidthAnchorConstraint?.isActive = true
                self.bottomView.widthAnchor.constraint(equalToConstant: self.tabarCollectionView.contentSize.width).isActive = true
            }
           
        }
    }
        lazy var currentIndex = tabPager?.initialControllerIndex
    
    
    var tabarCollectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .blue
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
    }()
    let bottomView:UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
//        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cellId = "cellId"
    
    var tabPager:TabPagerController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(tabarCollectionView)
        self.addSubview(bottomView)
        NSLayoutConstraint.activate([
            tabarCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tabarCollectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            tabarCollectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            tabarCollectionView.heightAnchor.constraint(equalToConstant: 30),
            //
            bottomView.topAnchor.constraint(equalTo: tabarCollectionView.bottomAnchor),
            bottomView.leftAnchor.constraint(equalTo: self.leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: self.rightAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 34),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            bottomView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1)
            
            ])
        
        tabarCollectionView.dataSource = self
        tabarCollectionView.delegate = self
        
        setupViews()
        setupHorizontalBar()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        tabarCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
    }
    func setupHorizontalBar() {
    
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        horizontalBarView.accessibilityLabel = "asdasd"
        horizontalBarView.backgroundColor = .white
        bottomView.addSubview(horizontalBarView)
        horizontalBarView.topAnchor.constraint(equalTo: self.bottomView.topAnchor).isActive = true
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomView.bottomAnchor).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        let view = UIView()
        self.tabarCollectionView.addSubview(view)
        view.fillSuperview()
    }
}

extension Tabar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let currentCell = cell as? MenuCell
        currentCell?.menuTitle.text = "albin"
        return currentCell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 100, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let currentCell = self.tabarCollectionView.cellForItem(at: indexPath)
        print(indexPath.row)
        self.horizontalBarLeftAnchorConstraint?.constant = (currentCell?.frame.minX)!
        self.horizontalBarWidthAnchorConstraint?.constant = (currentCell?.frame.width)!
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            UIView.animate(withDuration: 5) {
                self.layoutIfNeeded()
            }
            
        }, completion: nil)
        
        if let currentCellIndex = currentIndex{
            print("current:",currentCellIndex,"selected:",indexPath.row)
            if currentCellIndex > indexPath.row{
                tabPager?.pageController.setViewControllers([(tabPager?.orderedViewControllers[indexPath.row])!],
                                                            direction: .reverse,
                                                            animated: true,
                                                            completion: nil)


                currentIndex = indexPath.row
                
            }else if currentCellIndex < indexPath.row{
                tabPager?.pageController.setViewControllers([(tabPager?.orderedViewControllers[indexPath.row])!],
                                                            direction: .forward,
                                                            animated: true,
                                                            completion: nil)
                currentIndex = indexPath.row
            }
        }
    }
    
}

