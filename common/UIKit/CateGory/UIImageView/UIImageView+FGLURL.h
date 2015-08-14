//
//  UIImageView+FGLURL.h
//  question
//
//  Created by 陈昕 on 15/7/29.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCache.h>

@interface UIImageView (FGLURL)

- (void)fgl_setImageWithURL:(NSURL *)url;

- (void)fgl_setImageWithURL:(NSURL *)url usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;

- (void)fgl_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;

- (void)fgl_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                    options:(SDWebImageOptions)options
usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;

- (void)fgl_setImageWithURL:(NSURL *)url
                  completed:(SDWebImageCompletionBlock)completedBlock
usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;

- (void)fgl_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                  completed:(SDWebImageCompletionBlock)completedBlock
usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;

- (void)fgl_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                    options:(SDWebImageOptions)options
                  completed:(SDWebImageCompletionBlock)completedBlock
usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;

- (void)fgl_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                    options:(SDWebImageOptions)options
                   progress:(SDWebImageDownloaderProgressBlock)progressBlock
                  completed:(SDWebImageCompletionBlock)completedBlock
usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle;

- (void)fgl_removeActivityIndicator;

@end
