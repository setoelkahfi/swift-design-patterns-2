//
//  TurnController.swift
//  DesignPatternsInSwift
//
//  Created by SDMobile on 4/21/16.
//  Copyright © 2016 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

class TurnController {
  
  var currentTurn: Turn?
  var pastTurns: [Turn] = [Turn]()
  
  init(turnStrategy: TurnStrategy) {
    self.turnStrategy = turnStrategy
    self.scorer = MatchScorer()
  }
  
  func beginNewTurn() -> (ShapeView, ShapeView) {
    let shapeViews = turnStrategy.makeShapeViewsForNextTurnGivenPastTurns(pastTurns)
    currentTurn = Turn(shapes: [shapeViews.0.shape, shapeViews.1.shape])
    return shapeViews
  }
  
  func endTurnWithTappedShape(tappedShape: Shape) -> Int {
    currentTurn!.turnCompletedWithTappedShape(tappedShape)
    pastTurns.append(currentTurn!)
    
    var scoreIncrement = scorer.computeScoreIncrement(pastTurns.reverse())
    return scoreIncrement
  }
  
  private let turnStrategy: TurnStrategy
  
  private let scorer: Scorer
  
}