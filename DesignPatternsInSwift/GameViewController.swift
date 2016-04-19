//
//  GameViewController.swift
//  DesignPatternsInSwift
//
//  Created by Joel Shapiro on 9/23/14.
//  Copyright (c) 2014 RepublicOfApps, LLC. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    shapeViewFactory = SquareShapeViewFactory(size: gameView.sizeAvailableForShapes())
    
    shapeFactory = SquareShapeFactory(minProportion: 0.3, maxProportion: 0.8)
    
    beginNextTurn()
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }

  private func beginNextTurn() {
    let shapes = shapeFactory.createShapes()

    let shapeViews = shapeViewFactory.makeShapeViewsForShapes(shapes)

    shapeViews.0.tapHandler = {
      tappedView in
      let square1 = shapes.0 as! SquareShape, square2 = shapes.1 as! SquareShape
      
      self.gameView.score += square1.sideLength >= square2.sideLength ? 1 : -1
      self.beginNextTurn()
    }
    shapeViews.1.tapHandler = {
      tappedView in
      let square1 = shapes.0 as! SquareShape, square2 = shapes.1 as! SquareShape
      self.gameView.score += square2.sideLength >= square1.sideLength ? 1 : -1
      self.beginNextTurn()
    }

    gameView.addShapeViews(shapeViews)
  }

  private var gameView: GameView { return view as! GameView }
  
  private var shapeViewFactory: ShapeViewFactory!
  
  private var shapeFactory: ShapeFactory!
}
