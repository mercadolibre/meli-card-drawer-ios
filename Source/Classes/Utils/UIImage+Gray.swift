//
//  UIImage+Gray.swift
//  MLCardDrawer
//
//  Created by Juan sebastian Sanzone on 5/24/19.
//

import UIKit

internal extension UIImage {
    func grayscale() -> UIImage? {
        if let currentFilter = CIFilter(name: "CIPhotoEffectMono") {
            let context = CIContext(options: nil)
            currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
            if let output = currentFilter.outputImage,
                let cgimg = context.createCGImage(output, from: output.extent) {
                let processedImage = UIImage(cgImage: cgimg)
                return processedImage
            }
        }
        return nil
    }

    func imageGreyScale() -> UIImage? {
        let imageRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)

        let greyContext = CGContext(
            data: nil, width: Int(self.size.width), height: Int(self.size.height),
            bitsPerComponent: 8, bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceGray(),
            bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue).rawValue
        )

        let alphaContext = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceGray(), bitmapInfo: CGImageAlphaInfo.none.rawValue
        )

        guard let cgImage = self.cgImage else { return nil }

        greyContext?.draw(cgImage, in: imageRect)
        alphaContext?.draw(cgImage, in: imageRect)

        if let maskImage = alphaContext?.makeImage(), let combinedImage = greyContext?.makeImage()?.masking(maskImage) {
            return UIImage(cgImage: combinedImage)
        }
        return nil
    }
    
    class func resize(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    class func scale(image: UIImage, by scale: CGFloat) -> UIImage? {
        let size = image.size
        let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)
        return UIImage.resize(image: image, targetSize: scaledSize)
    }
}
