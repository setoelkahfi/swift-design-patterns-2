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
    
    beginNextTurn()
  }

  override func prefersStatusBarHidden() -> Bool {
    return true
  }

  private func beginNextTurn() {
    let shape1 = SquareShape()
    shape1.sideLength = Utils.randomBetweenLower(0.3, andUpper: 0.8)
    let shape2 = SquareShape()
    shape2.sideLength = Utils.randomBetweenLower(0.3, andUpper: 0.8)

    let shapeViews = shapeViewFactory.makeShapeViewsForShapes((shape1, shape2))

    shapeViews.0.tapHandler = {
      tappedView in
      self.gameView.score += shape1.sideLength >= shape2.sideLength ? 1 : -1
      self.beginNextTurn()
    }
    shapeViews.1.tapHandler = {
      tappedView in
      self.gameView.score += shape2.sideLength >= shape1.sideLength ? 1 : -1
      self.beginNextTurn()
    }

    gameView.addShapeViews(shapeViews)
  }

  private var gameView: GameView { return view as! GameView }
  
  private var shapeViewFactory: ShapeViewFactory!
}
