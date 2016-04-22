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
    
    // 1
    let squareShapeViewFactory = SquareShapeViewFactory(size: gameView.sizeAvailableForShapes())
    let squareShapeFactory = SquareShapeFactory(minProportion: 0.0, maxProportion: 0.8)
    let squareShapeViewBuilder = shapeViewBuilderForFactory(squareShapeViewFactory)
    let squareTurnStrategy = BasicTurnStrategy(shapeFactory: squareShapeFactory, shapeViewBuilder: squareShapeViewBuilder)
    
    // 2
    let circleShapeViewFactory = CircleShapeViewFactory(size: gameView.sizeAvailableForShapes())
    let circleShapeFactory = CircleShapeFactory(minProportion: 0.0, maxProportion: 0.8)
    let circleShapeViewBuilder = shapeViewBuilderForFactory(circleShapeViewFactory)
    let circleTurnStrategy = BasicTurnStrategy(shapeFactory: circleShapeFactory, shapeViewBuilder: circleShapeViewBuilder)
    
    // 3
    let randomTurnStrategy = RandomTurnStrategy(firstStrategy: squareTurnStrategy, secondStrategy: circleTurnStrategy)
    
    // 4
    turnController = TurnController(turnStrategy: randomTurnStrategy)
    
    beginNextTurn()
  }
                    
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  private func shapeViewBuilderForFactory(shapeViewFactory: ShapeViewFactory) -> ShapeViewBuilder {
    let shapeViewBuilder = ShapeViewBuilder(shapeViewFactory: shapeViewFactory)
    shapeViewBuilder.fillColor = UIColor.brownColor()
    shapeViewBuilder.outLine = UIColor.orangeColor()
    return shapeViewBuilder
  }

  private func beginNextTurn() {
    
    let shapeViews = turnController.beginNewTurn()
    
    shapeViews.0.tapHandler = {
      tappedView in
      
      self.gameView.score += self.turnController.endTurnWithTappedShape(tappedView.shape)
      self.beginNextTurn()
    }
    
    shapeViews.1.tapHandler = shapeViews.0.tapHandler
    
    gameView.addShapeViews(shapeViews)
  }

  private var gameView: GameView { return view as! GameView }
  
  private var turnController: TurnController!
}
