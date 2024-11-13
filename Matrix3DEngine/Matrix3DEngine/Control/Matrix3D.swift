//
//  Matrix3D.swift
//  Matrix3DEngine
//
//  Created by Mike Finimento on 13.11.24.
//

import Foundation

class Vector3D{
    var x: Int
    var y: Int
    var z: Int
    
    init(_ x: Int, _ y: Int, _ z: Int){
        self.x = x
        self.y = y
        self.z = z
    }
}
class Matrix3D: ObservableObject{
    @Published var matrix: [[Double]] = [
        [1.0, 0.0, 0.0, 0.0],
        [0.0, 1.0, 0.0, 0.0],
        [0.0, 0.0, 1.0, 0.0],
        [0.0, 0.0, 0.0, 1.0]
    ]
    
    enum Dimension {
        case x, y, z
    }

    // Translation
    func translate(dimension: Dimension, units: Double) {
        var translationMatrix: [[Double]] = [
            [1.0, 0.0, 0.0, 0.0],
            [0.0, 1.0, 0.0, 0.0],
            [0.0, 0.0, 1.0, 0.0],
            [0.0, 0.0, 0.0, 1.0]
        ]
        
        switch dimension {
        case .x:
            translationMatrix[0][3] = units
        case .y:
            translationMatrix[1][3] = units
        case .z:
            translationMatrix[2][3] = units
        }
        
        self.matrix = multiplyMatrices(m1: self.matrix, m2: translationMatrix)
    }

    // Rotation
    func rotate(dimension: Dimension, radians: Double) {
        objectWillChange.send() // Fügt diese Zeile hinzu
        var rotationMatrix: [[Double]] = [
            [1.0, 0.0, 0.0, 0.0],
            [0.0, 1.0, 0.0, 0.0],
            [0.0, 0.0, 1.0, 0.0],
            [0.0, 0.0, 0.0, 1.0]
        ]
        
        let cosAngle = cos(radians)
        let sinAngle = sin(radians)
        
        switch dimension {
        case .x:
            rotationMatrix = [
                [1.0, 0.0,     0.0,      0.0],
                [0.0, cosAngle, -sinAngle, 0.0],
                [0.0, sinAngle, cosAngle,  0.0],
                [0.0, 0.0,     0.0,      1.0]
            ]
        case .y:
            rotationMatrix = [
                [cosAngle,  0.0, sinAngle, 0.0],
                [0.0,       1.0, 0.0,      0.0],
                [-sinAngle, 0.0, cosAngle, 0.0],
                [0.0,       0.0, 0.0,      1.0]
            ]
        case .z:
            rotationMatrix = [
                [cosAngle, -sinAngle, 0.0, 0.0],
                [sinAngle, cosAngle,  0.0, 0.0],
                [0.0,      0.0,       1.0, 0.0],
                [0.0,      0.0,       0.0, 1.0]
            ]
        }
        
        self.matrix = multiplyMatrices(m1: self.matrix, m2: rotationMatrix)
    }

    // Scaling
    func scale(dimension: Dimension, units: Double) {
        var scalingMatrix: [[Double]] = [
            [1.0, 0.0, 0.0, 0.0],
            [0.0, 1.0, 0.0, 0.0],
            [0.0, 0.0, 1.0, 0.0],
            [0.0, 0.0, 0.0, 1.0]
        ]
        
        switch dimension {
        case .x:
            scalingMatrix[0][0] = units
        case .y:
            scalingMatrix[1][0] = units
        case .z:
            scalingMatrix[2][0] = units
        }
        
        self.matrix = multiplyMatrices(m1: self.matrix, m2: scalingMatrix)
    }

    // Helper function to multiply two 4x4 matrices
    func multiplyMatrices(m1: [[Double]], m2: [[Double]]) -> [[Double]] {
        var result: [[Double]] = Array(repeating: Array(repeating: 0.0, count: 4), count: 4)
        
        for i in 0..<4 {
            for j in 0..<4 {
                for k in 0..<4 {
                    result[i][j] += m1[i][k] * m2[k][j]
                }
            }
        }
        
        return result
    }
}
