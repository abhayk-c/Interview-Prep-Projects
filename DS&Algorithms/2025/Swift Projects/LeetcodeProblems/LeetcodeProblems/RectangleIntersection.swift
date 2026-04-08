//
//  RectangleIntersection.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 9/22/25.
//

import Foundation

public func cgRectIntersectRect(_ rectOne: CGRect, _ rectTwo: CGRect) -> Bool
{
    let rectOneStartX = rectOne.origin.x
    let rectOneEndX = rectOne.origin.x + rectOne.size.width
    let rectTwoStartX = rectTwo.origin.x
    let rectTwoEndX = rectTwo.origin.x + rectTwo.size.width
    let rectOneStartY = rectOne.origin.y - rectOne.size.height
    let rectOneEndY = rectOne.origin.y
    let rectTwoStartY = rectTwo.origin.y - rectTwo.size.height
    let rectTwoEndY = rectTwo.origin.y
    let intersectsX = rectOneStartX < rectTwoEndX && rectOneEndX > rectTwoStartX
    let intersectsY = rectOneStartY < rectTwoEndY && rectOneEndY > rectTwoStartY
    return intersectsX && intersectsY
}

func isRectangleOverlap(_ recA: [Int], _ recB: [Int]) -> Bool {
    let rectOne = CGRect(origin: CGPoint(x: Double(recA[0]), y: Double(recA[3])),
                         size: CGSize(width: Double(recA[2]) - Double(recA[0]), height: Double(recA[3]) - Double(recA[1])))
    let rectTwo = CGRect(origin: CGPoint(x: Double(recB[0]), y: Double(recB[3])),
                         size: CGSize(width: Double(recB[2]) - Double(recB[0]), height: Double(recB[3]) - Double(recB[1])))
    return cgRectIntersectRect(rectOne, rectTwo)
}
