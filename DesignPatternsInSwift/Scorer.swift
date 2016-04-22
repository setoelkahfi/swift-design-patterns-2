//
//  Scorer.swift
//  DesignPatternsInSwift
//
//  Created by SDMobile on 4/22/16.
//  Copyright © 2016 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

protocol Scorer {
  func computeScoreIncrement<S: SequenceType where Turn == S.Generator.Element>(pastTurnReserved: S) -> Int
}

class MatchScorer: Scorer {
  
  func computeScoreIncrement<S : SequenceType where Turn == S.Generator.Element>(pastTurnReserved: S) -> Int {
    var scoreIncrement: Int?
    
    for turn in pastTurnReserved {
      if scoreIncrement == nil {
        scoreIncrement = turn.matched! ? 1 : -1
        break
      }
    }
    
    return scoreIncrement ?? 0
  }
}