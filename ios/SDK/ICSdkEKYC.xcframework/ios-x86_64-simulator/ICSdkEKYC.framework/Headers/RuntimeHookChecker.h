//
//  RuntimeHookChecker.h
//  ICSdkEKYC
//
//  Created by Lê Minh Hiếu on 6/8/25.
//  Copyright © 2025 iOS Team IC - Innovation Center. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeHookChecker : NSObject

/// Kiểm tra xem một phương thức đã bị hook hoặc thay đổi (swizzle/tamper) hay chưa.
///
/// @param className Tên lớp cần kiểm tra, ví dụ: @"ICFaceOvalViewController".
/// @param selectorName Tên selector (tên phương thức), ví dụ: @"captureOutput:didOutputSampleBuffer:fromConnection:".
/// @param isClassMethod YES nếu là phương thức lớp (class method), NO nếu là phương thức đối tượng (instance method).
/// @return NSDictionary chứa kết quả kiểm tra, có định dạng:
///         {
///             @"success": @(YES/NO),  // YES nghĩa là phương thức không bị can thiệp (pass),
///                                     // NO nghĩa là phát hiện bị hook hoặc thay đổi (fail)
///             @"message": @"Chuỗi mô tả chi tiết kết quả"
///         }
+ (NSDictionary<NSString *, id> *)checkMethodSwizzlingForClass:(NSString *)className
                                                      selector:(NSString *)selectorName
                                                 isClassMethod:(BOOL)isClassMethod;

/// Kiểm tra các thiết bị camera đáng ngờ (ví dụ: thiết bị đầu vào ảo, giả lập camera).
///
/// @return NSDictionary chứa kết quả kiểm tra, có định dạng:
///         {
///             @"success": @(YES/NO),  // YES nếu tất cả thiết bị camera hợp lệ (pass),
///                                     // NO nếu phát hiện thiết bị đáng ngờ (fail)
///             @"message": @"Chuỗi mô tả chi tiết kết quả"
///         }
+ (NSDictionary<NSString *, id> *)checkSuspiciousCameraDevices;

/// Lấy tên tất cả các module (thư viện/framework/dylib) đang được load vào tiến trình.
///
/// @return Một tập hợp (`NSSet`) chứa tên các module đã được load (không bao gồm phần mở rộng),
///         ví dụ: { "UIKit", "Foundation", "YourApp" }.
+ (NSSet<NSString *> *)getAllLoadedModuleNames;

/// Kiểm tra xem trong call stack hiện tại có xuất hiện module nào bất thường không
/// (không nằm trong danh sách các module đã được load hợp lệ).
///
/// @return NSDictionary chứa kết quả kiểm tra, có định dạng:
///         {
///             @"success": @(YES/NO),  // YES nếu call stack không chứa module lạ (pass),
///                                     // NO nếu có module bất thường trong call stack (fail)
///             @"message": @"Chuỗi mô tả chi tiết kết quả"
///         }
+ (NSDictionary<NSString *, id> *)checkSuspiciousModulesInCallstack;

@end

NS_ASSUME_NONNULL_END
