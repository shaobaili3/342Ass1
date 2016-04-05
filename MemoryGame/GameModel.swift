//
//  GameModel.swift
//  memoryGame
//
//  Created by SABai on 2/04/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import Foundation
import UIKit

struct TileData{
    var image: UIImage?
    var imageIdentifer: Int
    
}

//add shuffle fucntion to swift array




class GameModel: CustomStringConvertible{
    var lastTap: Int?
    //An integer representing the index of the last tile tapped (integer)
    
    var secLastTap: Int?
    //An integer representing the index of the second last tile tapped (integer)
    
    var initialPic:[TileData] = []
    //An array of TileData structures (representing our initial game state) (use ArrayList<...> on Android)
    
    var flag: Bool = false
    //A flag indicating whether it’s the first or second turn (Boolean)
    
    var counter: Int = 0
    //A counter for the number of matched tiles (so we can determine when the game has completed)
    
    var delegator: modelDelegator?
    //A delegate (iOS) / interface reference (Android) ????
    
    var score: Int
    //A variable to keep track of the game’s score
    
    init(numTile: Int, imgs: [UIImage])
    {
        lastTap = nil
        secLastTap = nil
        initialPic = []
        flag = false
        counter = 0
        score = 0
        self.reset(numTile, imgs: imgs)
    }
    
    
    func reset(numTile: Int, imgs: [UIImage])
    {
        //Reset all game state variable
        lastTap = -1
        secLastTap = -1
        initialPic = []
        flag = false
        counter = 0
        score = 0
        
        var count = 0 //for below while loop
        while initialPic.count != numTile
        {
            
            if count == imgs.count{
                count = 0
            }
            initialPic.append( TileData(image: imgs[count] , imageIdentifer: count))
            initialPic.append( TileData(image: imgs[count] , imageIdentifer: count))
            count++
        }
        
        for var index = initialPic.count - 1; index > 0; index--
        {
            // Random int from 0 to index-1
            let j = Int(arc4random_uniform(UInt32(index-1)))
            
            // Swap two array elements
            // Notice '&' required as swap uses 'inout' parameters
            swap(&initialPic[index], &initialPic[j])
        }

    }
    
    var description: String{
        var discript: String = ""
        for pic in initialPic{
            discript += String(pic.imageIdentifer)
        }
        return discript
    }
    
    func pushTileIndex(indexer: Int){
        if flag == false
        {
            lastTap = indexer
            flag = true
        }
        else
        {
            secLastTap = lastTap
            lastTap = indexer
            flag = false
        }
    
    }
}

protocol modelDelegator{
    func gameDidComplete()
    func didMatchTile(gameodel: GameModel, tileView: TileView)
    func didFailToMatchTile()
    func scoreDidUpdate(newScore: Int)
}
