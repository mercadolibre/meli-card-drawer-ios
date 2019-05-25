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
}
