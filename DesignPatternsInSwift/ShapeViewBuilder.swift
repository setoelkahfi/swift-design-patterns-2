//
//  ShapeViewBuilder.swift
//  DesignPatternsInSwift
//
//  Created by SDMobile on 4/21/16.
//  Copyright © 2016 RepublicOfApps, LLC. All rights reserved.
//

import Foundation
import UIKit

class ShapeViewBuilder {
  
  var showFill = true
  var fillColor = UIColor.orangeColor()
  
  var showOutline = true
  var outLine = UIColor.grayColor()
  
  init(shapeViewFactory: ShapeViewFactory) {
    self.shapeViewFactory = shapeViewFactory
  }
  
  func buildShapeViewsForShapes(shapes: (Shape, Shape)) -> (ShapeView, ShapeView) {
    let shapeViews = shapeViewFactory.makeShapeViewsForShapes(shapes)
    configureShapeView(shapeViews.0)
    configureShapeView(shapeViews.1)
    return shapeViews
  }
  
  private func configureShapeView(shapeView: ShapeView) {
    shapeView.showFill = showFill
    shapeView.fillColor = fillColor
    shapeView.showOutline = showOutline
    shapeView.outlineColor = outLine
  }
  
  private var shapeViewFactory: ShapeViewFactory
}
