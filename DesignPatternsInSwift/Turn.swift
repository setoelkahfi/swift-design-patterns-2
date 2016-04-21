//
//  Turn.swift
//  DesignPatternsInSwift
//
//  Created by SDMobile on 4/21/16.
//  Copyright © 2016 RepublicOfApps, LLC. All rights reserved.
//

import Foundation

class Turn {
  
  let shapes: [Shape]
  var matched: Bool?
  
  init(shapes: [Shape]) {
    self.shapes = shapes
  }
  
  func turnCompletedWithTappedShape(tappedShape: Shape) {
    let maxArea = shapes.reduce(0) { $0 > $1.area ? $0 : $1.area }
    matched = tappedShape.area >= maxArea
  }
  
}