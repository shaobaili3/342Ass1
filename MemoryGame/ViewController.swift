//
//  ViewController.swift
//  MemoryGame
//
//  Created by SABai on 2/04/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TileViewDelegator {

    
    var model: GameModel
    
    required init?(coder aDecoder: NSCoder) {
        let imgs: [UIImage] = [UIImage(named: "lake")!, UIImage(named: "cathedral")!, UIImage(named: "baldhill")!]
        model = GameModel(numTile: 16, imgs: imgs)
        super.init(coder: aDecoder)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        print(model) //debug the image struct
    }

    func didSelectTile(tileView: TileView) {
        print("haha")
        tileView.img = model.initialPic[tileView.tileIndex!].image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

