import UIKit

/// Extension to support ARGB color format from Flutter
extension UIColor {
    /// Initialize UIColor from ARGB integer format (0xAARRGGBB)
    /// - Parameter argb: Color value in ARGB format where:
    ///   - Alpha: bits 24-31
    ///   - Red: bits 16-23
    ///   - Green: bits 8-15
    ///   - Blue: bits 0-7
    /// - Example: 0xFF00A96F represents fully opaque green (#00A96F)
    convenience init(argb: Int64) {
        let a = CGFloat((argb >> 24) & 0xFF) / 255.0
        let r = CGFloat((argb >> 16) & 0xFF) / 255.0
        let g = CGFloat((argb >> 8) & 0xFF) / 255.0
        let b = CGFloat(argb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
