//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!
//let rgbaImage = RGBAImage(image: image)!

//
//for y in 0 ..< rgbaImage.height {
//    for x in 0 ..< rgbaImage.width {
//        let index = y * rgbaImage.width + x
//        var pixel = rgbaImage.pixels[index]
//
////        let redDiff = Int(pixel.red) - 122
////        if redDiff > 0 {
////            pixel.red = UInt8(max(0, min(255, 122+redDiff*5)))
////        }
//
//        let existingAlpha = pixel.alpha
//        let newAlpha = existingAlpha/2
//        pixel.alpha = newAlpha
//
//        rgbaImage.pixels[index] = pixel
//
//    }
//}




class Filter {
    private let rgbaImage: RGBAImage
    
    init(rgbaImage: RGBAImage) {
        self.rgbaImage = rgbaImage
    }
    
    func applyFiftyPercentageAlphaFilter() -> RGBAImage {
        return applyFilter(alpha: 0.5, red: 1, green: 1, blue: 1)
    }
    
    func applyFiftyPercentageRedFilter() -> RGBAImage {
        return applyFilter(alpha: 1, red: 0.5, green: 1, blue: 1)
    }
    
    func applyFiftyPercentageGreenFilter() -> RGBAImage {
        return applyFilter(alpha: 1, red: 1, green: 0.5, blue: 1)
    }
    
    func applyFiftyPercentageBlueFilter() -> RGBAImage {
        return applyFilter(alpha: 1, red: 1, green: 1, blue: 0.5)
    }
    
    func applyFiftyPercentageContrastFilter() -> RGBAImage {
        return applyFilter(alpha: 1, red: 0.5, green: 0.5, blue: 0.5)
    }
    
    private func applyFilter(alpha: Double, red: Double, green: Double, blue:Double) -> RGBAImage {
        
        for y in 0 ..< rgbaImage.height {
            for x in 0 ..< rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                pixel.alpha = UInt8(Double(pixel.alpha) * alpha)
                pixel.red = UInt8(Double(pixel.red) * red)
                pixel.blue = UInt8(Double(pixel.blue) * blue)
                pixel.green = UInt8(Double(pixel.green) * green)
                rgbaImage.pixels[index] = pixel
            }
        }
        return rgbaImage
    }
}

class ImageProcessor {
    private let image: UIImage
    var newRGBAImage: RGBAImage
    
    init(image: UIImage) {
        self.image = image
        self.newRGBAImage = RGBAImage(image: image)!
    }
    
    func applyFilter(filterName: String) -> Self {
        let rgbaImage = RGBAImage(image: image)!
        let filter = Filter(rgbaImage: rgbaImage)
        
        if filterName == "Alpha" {
            newRGBAImage = filter.applyFiftyPercentageAlphaFilter()
            return self
        }
        
        if filterName == "Red" {
            newRGBAImage = filter.applyFiftyPercentageRedFilter()
            return self
        }
        
        if filterName == "Blue" {
            newRGBAImage = filter.applyFiftyPercentageBlueFilter()
            return self
        }
        
        if filterName == "Green" {
            newRGBAImage = filter.applyFiftyPercentageGreenFilter()
            return self
            //return newRGBAImage.toUIImage()!
        }
        
        //default condition is contrast filter
        newRGBAImage = filter.applyFiftyPercentageContrastFilter()
        return self
        //return newRGBAImage.toUIImage()!
    }
}

let imageProcessor = ImageProcessor(image: image)
let newImage = imageProcessor.applyFilter(filterName: "Contrast").newRGBAImage.toUIImage()

