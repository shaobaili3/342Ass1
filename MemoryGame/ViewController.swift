//
//  ViewController.swift
//  MemoryGame
//
//  Created by SABai on 2/04/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TileViewDelegator, modelDelegator {

    var model: GameModel
    var tileViews: [TileView] = []
    let numTile:Int = 12 // the number of tiles
    let imgs: [UIImage]
    @IBOutlet weak var score: UILabel!
    required init?(coder aDecoder: NSCoder) {
        imgs = [UIImage(named: "lake")!, UIImage(named: "cathedral")!, UIImage(named: "baldhill")!]
        model = GameModel(numTile: numTile, imgs: imgs)
        super.init(coder: aDecoder)
          print(model) //debug the image struct

        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 0..<13{
            if let cast = self.view.viewWithTag(i) as? TileView{
            tileViews.append(cast)
            cast.tileDelegator = self
            
            }
        }
      
    }

    func didSelectTile(tileView: TileView) {
        model.pushTileIndex(tileView.tileIndex! - 1)
        didMatchTile(model, tileView: tileView)
    }
    
    
    func gameDidComplete() {
        model.counter++
        if model.counter == numTile/2
        {
            let message = "Your score: " + String(model.score);
            let alertController = UIAlertController(title: "Game Done", message:
                message, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "RETRY", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            model.reset(numTile, imgs: imgs)
            for views in tileViews
            {
                views.addGestureR()
                views.imgView.image = UIImage(named: "question")
            }
        }
        
    }
    
    func didMatchTile(gamemodel: GameModel, tileView: TileView) {
        tileView.img = model.initialPic[tileView.tileIndex! - 1].image
        tileView.Reveal()
        if model.lastTap! != model.secLastTap! && model.flag == false && model.initialPic[model.lastTap!].imageIdentifer == model.initialPic[model.secLastTap!].imageIdentifer
        {
            scoreDidUpdate(200)
            let delay = 0.5 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                
            
            self.tileViews[gamemodel.lastTap!].Hide()
            self.tileViews[gamemodel.secLastTap!].Hide()
            self.model.initialPic[gamemodel.secLastTap!].image = nil
            self.model.initialPic[gamemodel.lastTap!].image = nil
            self.gameDidComplete()
            }
        }
        else
        {
            didFailToMatchTile()
        }

        
    }
    
    
    func didFailToMatchTile() {
        
        if model.flag == false
        {
            scoreDidUpdate(-100)
            let delay = 0.5 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue())
                {
                    self.tileViews[self.model.lastTap!].Cover()
                    self.tileViews[self.model.secLastTap!].Cover()
            }
        }
    }
    
    func scoreDidUpdate(newScore: Int) {
        model.score += newScore
        score.text = "Score: " + String(model.score)
    }


}

