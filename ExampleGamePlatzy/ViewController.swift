//
//  ViewController.swift
//  ExampleGamePlatzy
//
//  Created by Doyle on 11/01/18.
//  Copyright © 2018 Doyle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var board: UIView!
    var tileWidth: CGFloat = 0.0
    var tileCenterX: CGFloat = 0.0
    var tileCenterY: CGFloat = 0.0
    var tileArray: NSMutableArray = []
    var tileCenterArray: NSMutableArray = []
    var tileEmpyCenter: CGPoint = CGPoint(x:0, y:0)
    var tileNumber : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeTile()
        randomTiles()
        //self.board.frame.size.width = self.board.frame.width - 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnRandom(_ sender: Any) {
        randomTiles()
    }
    
    func makeTile(){
        self.tileArray = []
        self.tileCenterArray = []
        let boardWidth = self.board.frame.width
        self.tileWidth = boardWidth / 4
        self.tileCenterX = self.tileWidth / 2
        self.tileCenterY = self.tileWidth / 2
        for _ in 0..<4 {
            for _ in 0..<4 {
                let titleFrame: CGRect = CGRect(x: 0, y: 0, width: tileWidth-2, height: tileWidth-2)
                let tile: CustonLabel = CustonLabel(frame: titleFrame)
                
                let currentCenter = CGPoint(x:self.tileCenterX, y: self.tileCenterY)
                tile.center = currentCenter
                tile.originCenter = currentCenter
                tileNumber = tileNumber + 1
                tile.text = String(tileNumber)
                tile.textAlignment = NSTextAlignment.center
                tile.isUserInteractionEnabled = true
                self.tileCenterArray.add(currentCenter)
                tile.backgroundColor = UIColor.red
                self.board.addSubview(tile)
                
                
                self.tileArray.add(tile)
                
                self.tileCenterX = self.tileCenterX + self.tileWidth
            }
            self.tileCenterX = self.tileWidth / 2
            self.tileCenterY = self.tileCenterY + self.tileWidth
        }
        let lastTile: CustonLabel = self.tileArray.lastObject as! CustonLabel
        lastTile.removeFromSuperview()
        self.tileArray.removeObject(at: 15)
    }
    
    func randomTiles(){
        let tempTileCenterArray : NSMutableArray = self.tileCenterArray.mutableCopy() as! NSMutableArray
        for anyTile in self.tileArray{
            let randomIndex : Int = Int(arc4random()) % tempTileCenterArray.count
            let randomCenter : CGPoint = tempTileCenterArray[randomIndex] as! CGPoint
            
            (anyTile as! CustonLabel).center = randomCenter
            tempTileCenterArray.removeObject(at: randomIndex)
        }
        self.tileEmpyCenter = tempTileCenterArray[0] as! CGPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let currentTouch: UITouch = touches.first!
        if (self.tileArray.contains(currentTouch.view as Any))
        {
            //currentTouch.view?.alpha = 0
            let touchLabel: CustonLabel = currentTouch.view as! CustonLabel
            let xDif: CGFloat = touchLabel.center.x - self.tileEmpyCenter.x
            let yDif: CGFloat = touchLabel.center.y - self.tileEmpyCenter.y
            let distance: CGFloat = sqrt(pow(xDif,2)+pow(yDif,2))
            if distance == self.tileWidth
            {
                let tempCenter:CGPoint = touchLabel.center
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.2)
                touchLabel.center = self.tileEmpyCenter
                self.tileEmpyCenter = tempCenter
            }
        }
    }
}

class CustonLabel: UILabel{
    var originCenter: CGPoint = CGPoint(x:0, y :0)
}

