//
//  FGLHardwareInfo.h
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FGLHardwareFamily) {
    FGLHardwareFamily_Unknown,
    FGLHardwareFamily_iPhone,
    FGLHardwareFamily_iPad,
    FGLHardwareFamily_iPodTouch,
};

typedef NS_ENUM(NSInteger, FGLHardwareType) {

    FGLHardwareType_NotAvailable,
    FGLHardwareType_Simulator,

    FGLHardwareType_iPhone_Unreleased,
    FGLHardwareType_iPodTouch_Unreleased,
    FGLHardwareType_iPad_Unreleased,

    FGLHardwareType_iPhone,
    FGLHardwareType_iPhone_3G,
    FGLHardwareType_iPhone_3G_China,
    FGLHardwareType_iPhone_3GS,
    FGLHardwareType_iPhone_3GS_China,
    FGLHardwareType_iPhone_4_GSM,
    FGLHardwareType_iPhone_4_GSM_2012,
    FGLHardwareType_iPhone_4_CDMA,
    FGLHardwareType_iPhone_4S,
    FGLHardwareType_iPhone_4S_China,
    FGLHardwareType_iPhone_5_GSM,
    FGLHardwareType_iPhone_5_Global,
    FGLHardwareType_iPhone_5C_GSM,
    FGLHardwareType_iPhone_5C_Global,
    FGLHardwareType_iPhone_5S_GSM,
    FGLHardwareType_iPhone_5S_Global,
    FGLHardwareType_iPhone_6,
    FGLHardwareType_iPhone_6_China,
    FGLHardwareType_iPhone_6Plus,
    FGLHardwareType_iPhone_6Plus_China,

    FGLHardwareType_iPodTouch_1Gen,
    FGLHardwareType_iPodTouch_2Gen,
    FGLHardwareType_iPodTouch_3Gen,
    FGLHardwareType_iPodTouch_4Gen,
    FGLHardwareType_iPodTouch_5Gen,

    FGLHardwareType_iPad,
    FGLHardwareType_iPad_Cellular,
    FGLHardwareType_iPad_2_WiFi,
    FGLHardwareType_iPad_2_GSM,
    FGLHardwareType_iPad_2_CDMA,
    FGLHardwareType_iPad_2_Mid_2012,
    FGLHardwareType_iPad_3_WiFi,
    FGLHardwareType_iPad_3_GSM,
    FGLHardwareType_iPad_3_CDMA,
    FGLHardwareType_iPad_4_WiFi,
    FGLHardwareType_iPad_4_GSM,
    FGLHardwareType_iPad_4_Global,
    FGLHardwareType_iPad_Air_WiFi,
    FGLHardwareType_iPad_Air_Cellular,
    FGLHardwareType_iPad_Air_2_WiFi,
    FGLHardwareType_iPad_Air_2_Cellular,
    FGLHardwareType_iPad_Air_China,
    FGLHardwareType_iPad_Mini_WiFi,
    FGLHardwareType_iPad_Mini_GSM,
    FGLHardwareType_iPad_Mini_Global,
    FGLHardwareType_iPad_Mini_Retina_WiFi,
    FGLHardwareType_iPad_Mini_Retina_Cellular,
    FGLHardwareType_iPad_Mini_Retina_China,
    FGLHardwareType_iPad_Mini_3_WiFi,
    FGLHardwareType_iPad_Mini_3_Cellular,
};


@interface FGLHardwareInfo : NSObject

+ (NSString *)hardwareIdentifier;
+ (FGLHardwareType)hardwareType;
+ (FGLHardwareFamily)hardwareFamily;
+ (NSString *)hardwareDisplayName;
+ (BOOL)airDropIsAvailable;

@end
