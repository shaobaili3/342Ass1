//
//  TileView.swift
//  MemoryGame
//
//  Created by SABai on 4/04/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit

class TileView: UIView {

    var img: UIImage
    var imgView: UIImageView
    var tileDelegator: TileViewDelegator?
    var tileIndex: Int?
    
    required init?(coder aDecoder: NSCoder) {
        img = UIImage(named: "lake")! //set stored image
        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 69, height: 69))
        imgView.image = UIImage(named: "question")!
        super.init(coder: aDecoder)
        tileIndex = self.tag
        addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        let width = NSLayoutConstraint(item: imgView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
        
        let height = NSLayoutConstraint(item: imgView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
        
        let top = NSLayoutConstraint(item: imgView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        
        let left = NSLayoutConstraint(item: imgView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        
        //Add the constraints:
        self.addConstraints([width, height, top, left])
        let tapGesture = UITapGestureRecognizer(target: self, action: "Tap")
        addGestureRecognizer(tapGesture)

    }
    
    
    func Reveal(){
        imgView.image = img
    }
    
    func Cover(){
        imgView.image = UIImage(named: "question")!
    }

    func Hide(){
        imgView.image = nil
        imgView.backgroundColor = UIColor.whiteColor()
    }
    
    func Tap(){
        self.Reveal()
        //tileViewDelegator.didSelectTile(self)
    }
}


protocol TileViewDelegator{
    func didSelectTile(tileView: TileView)
}