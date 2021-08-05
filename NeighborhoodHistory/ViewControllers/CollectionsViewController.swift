//
//  CollectionsViewController.swift
//  NeighborhoodHistory
//
//  Created by Kelly Mei on 7/30/21.
//

import UIKit

struct CustomData {
    var title: String
    var image: UIImage
}

class CollectionsViewController: UIViewController {
    
    let data = [
        CustomData(title: "youthcenter", image: #imageLiteral(resourceName: "prototypeImage1")),
        CustomData(title: "pingtom", image: #imageLiteral(resourceName: "prototypeImage3")),
        CustomData(title: "haines", image: #imageLiteral(resourceName: "prototypeImage2")),
    ]
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
        
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    

}

extension CollectionsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.backgroundColor = .red
        cell.data = self.data[indexPath.row]
        return cell
    }
    
    
}

class CustomCell: UICollectionViewCell {
    
    var data: CustomData? {
        didSet {
            guard let dta = data else { return }
            bg.image = data?.image
        }
    }
    
    fileprivate let bg: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "prototypeImage1")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
        
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bg)
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
