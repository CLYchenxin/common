//
//  UIDevice+FGLHardware.m
//  question
//
//  Created by 陈昕 on 15/7/13.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "UIDevice+FGLHardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>

#import <sys/socket.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <sys/stat.h>
#import <sys/utsname.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <mach/processor_info.h>

static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone = @"iPhone1,1";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_3G = @"iPhone1,2";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_3G_China = @"iPhone1,2*";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_3GS = @"iPhone2,1";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_3GS_China = @"iPhone2,1*";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_4_GSM = @"iPhone3,1";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_4_GSM_2012 = @"iPhone3,2";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_4_CDMA = @"iPhone3,3";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_4S = @"iPhone4,1";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_4S_China = @"iPhone4,1*";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_5_GSM = @"iPhone5,1";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_5_Global = @"iPhone5,2";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_5C_GSM = @"iPhone5,3";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_5C_Global = @"iPhone5,4";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_5S_GSM = @"iPhone6,1";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_5S_Global = @"iPhone6,2";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_6Plus_China = @"iPhone7,1*";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_6Plus = @"iPhone7,1";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_6_China = @"iPhone7,2*";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPhone_6 = @"iPhone7,2";

static NSString *FGLHardwareInfo_HardwareIdentifier_iPad = @"iPad1,1";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_Cellular = @"iPad1,2";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_2_WiFi = @"iPad2,1";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_2_GSM = @"iPad2,2";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_2_CDMA = @"iPad2,3";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_2_MID_2012 = @"iPad2,4";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_Mini_WiFi = @"iPad2,5";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_Mini_GSM = @"iPad2,6";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_Mini_Global = @"iPad2,7";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_3_WiFi = @"iPad3,1";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_3_CDMA = @"iPad3,2";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_3_GSM = @"iPad3,3";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_4_WiFi = @"iPad3,4";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_4_GSM = @"iPad3,5";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_4_Global = @"iPad3,6";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_Air_WiFi = @"iPad4,1";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_Air_Cellular = @"iPad4,2";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_Air_China = @"iPad4,3";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_Air_2_WiFi = @"iPad5,3";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_Air_2_Cellular = @"iPad5,4";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_Mini_Retina_WiFi = @"iPad4,4";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_Mini_Retina_Cellular = @"iPad4,5";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_Mini_Retina_China = @"iPad4,6";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_Mini_3_WiFi = @"iPad4,7";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPad_Mini_3_Cellular = @"iPad4,8";

static NSString *FGLHardwareInfo_HardwareIdentifier_iPodTouch_1G = @"iPod1,1";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPodTouch_2G = @"iPod2,1";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPodTouch_3G = @"iPod3,1";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPodTouch_4G = @"iPod4,1";
static NSString *FGLHardwareInfo_HardwareIdentifier_iPodTouch_5G = @"iPod5,1";

@implementation UIDevice (FGLHardware)

+ (FGLHardwareFamily)fgl_hardwareFamily
{

    static dispatch_once_t once;
    static FGLHardwareFamily family;

    dispatch_once(&once, ^{
        NSString *deviceName = [UIDevice currentDevice].name;
        if ([deviceName hasPrefix:@"iPhone"]) {
            family = FGLHardwareFamily_iPhone;
        } else if ([deviceName hasPrefix:@"iPad"]) {
            family = FGLHardwareFamily_iPad;
        } else if ([deviceName hasPrefix:@"iPod"]) {
            family = FGLHardwareFamily_iPodTouch;
        } else {
            family = FGLHardwareFamily_Unknown;
        }
    });

    return family;
}

+ (FGLHardwareType)fgl_hardwareType
{
    static dispatch_once_t once;
    static FGLHardwareType type;
    dispatch_once(&once, ^{
        type = [self fgl_getCurrentHardwareType];
    });
    return type;
}

+ (NSString *)fgl_hardwareIdentifier
{
    static dispatch_once_t once;
    static NSString *hardware;
    dispatch_once(&once, ^{
        size_t size = 100;
        char *hw_machine = malloc(size);
        int name[] = {CTL_HW, HW_MACHINE};
        sysctl(name, 2, hw_machine, &size, NULL, 0);
        hardware = [NSString stringWithUTF8String:hw_machine];
        free(hw_machine);
    });
    return hardware;
}

+ (FGLHardwareType)fgl_getCurrentHardwareType
{

    NSString *hardware = [self fgl_hardwareIdentifier];

    if ([hardware hasPrefix:@"iPhone"]) {
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_6_China])
            return FGLHardwareType_iPhone_6_China;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_6]) return FGLHardwareType_iPhone_6;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_6Plus_China])
            return FGLHardwareType_iPhone_6Plus_China;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_6Plus])
            return FGLHardwareType_iPhone_6Plus;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_5S_Global])
            return FGLHardwareType_iPhone_5S_Global;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_5S_GSM])
            return FGLHardwareType_iPhone_5S_GSM;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_5C_Global])
            return FGLHardwareType_iPhone_5C_Global;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_5C_GSM])
            return FGLHardwareType_iPhone_5C_GSM;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_5_Global])
            return FGLHardwareType_iPhone_5_Global;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_5_GSM])
            return FGLHardwareType_iPhone_5_GSM;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_4S_China])
            return FGLHardwareType_iPhone_4S_China;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_4S]) return FGLHardwareType_iPhone_4S;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_4_CDMA])
            return FGLHardwareType_iPhone_4_CDMA;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_4_GSM_2012])
            return FGLHardwareType_iPhone_4_GSM_2012;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_4_GSM])
            return FGLHardwareType_iPhone_4_GSM;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_3GS_China])
            return FGLHardwareType_iPhone_3GS_China;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_3GS]) return FGLHardwareType_iPhone_3GS;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_3G_China])
            return FGLHardwareType_iPhone_3G_China;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone_3G]) return FGLHardwareType_iPhone_3G;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPhone]) return FGLHardwareType_iPhone;
        return FGLHardwareType_iPhone_Unreleased;
    } else if ([hardware hasPrefix:@"iPad"]) {
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_Mini_3_Cellular])
            return FGLHardwareType_iPad_Mini_3_Cellular;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_Mini_3_WiFi])
            return FGLHardwareType_iPad_Mini_3_WiFi;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_Mini_Retina_China])
            return FGLHardwareType_iPad_Mini_Retina_China;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_Mini_Retina_Cellular])
            return FGLHardwareType_iPad_Mini_Retina_Cellular;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_Mini_Retina_WiFi])
            return FGLHardwareType_iPad_Mini_Retina_WiFi;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_Mini_Global])
            return FGLHardwareType_iPad_Mini_Global;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_Mini_GSM])
            return FGLHardwareType_iPad_Mini_GSM;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_Mini_WiFi])
            return FGLHardwareType_iPad_Mini_WiFi;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_Air_2_Cellular])
            return FGLHardwareType_iPad_Air_2_Cellular;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_Air_2_WiFi])
            return FGLHardwareType_iPad_Air_2_WiFi;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_Air_China])
            return FGLHardwareType_iPad_Air_China;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_Air_Cellular])
            return FGLHardwareType_iPad_Air_Cellular;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_Air_WiFi])
            return FGLHardwareType_iPad_Air_WiFi;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_4_Global])
            return FGLHardwareType_iPad_4_Global;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_4_GSM]) return FGLHardwareType_iPad_4_GSM;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_4_WiFi])
            return FGLHardwareType_iPad_4_WiFi;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_3_CDMA])
            return FGLHardwareType_iPad_3_CDMA;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_3_GSM]) return FGLHardwareType_iPad_3_GSM;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_3_WiFi])
            return FGLHardwareType_iPad_3_WiFi;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_2_MID_2012])
            return FGLHardwareType_iPad_2_Mid_2012;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_2_CDMA])
            return FGLHardwareType_iPad_2_CDMA;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_2_GSM]) return FGLHardwareType_iPad_2_GSM;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_2_WiFi])
            return FGLHardwareType_iPad_2_WiFi;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad_Cellular])
            return FGLHardwareType_iPad_Cellular;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPad]) return FGLHardwareType_iPad;
        return FGLHardwareType_iPad_Unreleased;
    } else if ([hardware hasPrefix:@"iPod"]) {
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPodTouch_5G])
            return FGLHardwareType_iPodTouch_5Gen;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPodTouch_4G])
            return FGLHardwareType_iPodTouch_4Gen;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPodTouch_3G])
            return FGLHardwareType_iPodTouch_3Gen;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPodTouch_2G])
            return FGLHardwareType_iPodTouch_2Gen;
        if ([hardware isEqualToString:FGLHardwareInfo_HardwareIdentifier_iPodTouch_1G])
            return FGLHardwareType_iPodTouch_1Gen;
        return FGLHardwareType_iPodTouch_Unreleased;
    }

    if ([hardware isEqualToString:@"i386"]) return FGLHardwareType_Simulator;
    if ([hardware isEqualToString:@"x86_64"]) return FGLHardwareType_Simulator;

    return FGLHardwareType_NotAvailable;
}

+ (BOOL)fgl_hasCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (NSUInteger)fgl_totalMemoryBytes
{
    return [self fgl_getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)fgl_freeMemoryBytes
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;

    host_page_size(host_port, &pagesize);
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        return 0;
    }
    unsigned long mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}

+ (long long)fgl_freeDiskSpaceBytes
{
    struct statfs buf;
    long long freespace;
    freespace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        freespace = (long long)buf.f_bsize * buf.f_bfree;
    }
    return freespace;
}

+ (long long)fgl_totalDiskSpaceBytes
{
    struct statfs buf;
    long long totalspace;
    totalspace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        totalspace = (long long)buf.f_bsize * buf.f_blocks;
    }
    return totalspace;
}

+ (NSUInteger)fgl_getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}


@end
