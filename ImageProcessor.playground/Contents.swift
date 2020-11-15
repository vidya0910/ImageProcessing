//: Playground - noun: a place where people can play

import UIKit

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
    private var rgbaImage: RGBAImage
    
    init(image: UIImage) {
        self.image = image
        self.rgbaImage = RGBAImage(image: image)!
    }
    
    func applyFilter(filterName: String) -> Self {
        let filter = Filter(rgbaImage: rgbaImage)
        
        if filterName == "Alpha" {
            rgbaImage = filter.applyFiftyPercentageAlphaFilter()
            return self
        }
        
        if filterName == "Red" {
            rgbaImage = filter.applyFiftyPercentageRedFilter()
            return self
        }
        
        if filterName == "Blue" {
            rgbaImage = filter.applyFiftyPercentageBlueFilter()
            return self
        }
        
        if filterName == "Green" {
            rgbaImage = filter.applyFiftyPercentageGreenFilter()
            return self
        }
        
        //default condition is contrast filter
        rgbaImage = filter.applyFiftyPercentageContrastFilter()
        return self
    }
    
    func processedImage() -> UIImage? {
        return rgbaImage.toUIImage()
    }
}

let image = UIImage(named: "sample")!
let imageProcessor = ImageProcessor(image: image)
let newImage = imageProcessor.applyFilter(filterName: "Contrast").applyFilter(filterName: "Alpha").processedImage()

