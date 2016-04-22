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
  
  var nextScorer: Scorer? { get set }

}

class MatchScorer: Scorer {
  
  var nextScorer: Scorer? = nil
  
  func computeScoreIncrement<S : SequenceType where Turn == S.Generator.Element>(pastTurnReserved: S) -> Int {
    var scoreIncrement: Int?
    
    for turn in pastTurnReserved {
      if scoreIncrement == nil {
        scoreIncrement = turn.matched! ? 1 : -1
        break
      }
    }
    
    return (scoreIncrement ?? 0) + (nextScorer?.computeScoreIncrement(pastTurnReserved) ?? 0)
  }
}

class StreakScorer: Scorer {
  
  var nextScorer: Scorer? = nil
  
  func computeScoreIncrement<S : SequenceType where Turn == S.Generator.Element>(pastTurnReserved: S) -> Int {
    
    var streakLength = 0
    for turn in pastTurnReserved {
      if turn.matched! {
        ++streakLength
      } else {
        break
      }
    }
    
    let streakBonus = streakLength >= 5 ? 10 : 0
    return streakBonus + (nextScorer?.computeScoreIncrement(pastTurnReserved) ?? 0)
  }
}