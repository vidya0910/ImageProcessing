//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!

let rgbaImage = RGBAImage(image: image)!


for y in 0 ..< rgbaImage.height {
    for x in 0 ..< rgbaImage.width {
        let index = y * rgbaImage.width + x
        var pixel = rgbaImage.pixels[index]
        
//        let redDiff = Int(pixel.red) - 122
//        if redDiff > 0 {
//            pixel.red = UInt8(max(0, min(255, 122+redDiff*5)))
//        }
        
        let existingAlpha = pixel.alpha
        let newAlpha = existingAlpha/2
        pixel.alpha = newAlpha
        
        rgbaImage.pixels[index] = pixel

    }
}

let newImage = rgbaImage.toUIImage()


