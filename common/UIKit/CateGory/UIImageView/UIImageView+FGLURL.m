//
//  UIImageView+FGLURL.m
//  question
//
//  Created by 陈昕 on 15/7/29.
//  Copyright (c) 2015年 陈昕. All rights reserved.
//

#import "UIImageView+FGLURL.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

static char TAG_ACTIVITY_INDICATOR;

@implementation UIImageView (FGLURL)

- (UIActivityIndicatorView *)activityIndicator
{
    return (UIActivityIndicatorView *)objc_getAssociatedObject(self, &TAG_ACTIVITY_INDICATOR);
}

- (void)setActivityIndicator:(UIActivityIndicatorView *)activityIndicator
{
    objc_setAssociatedObject(self, &TAG_ACTIVITY_INDICATOR, activityIndicator, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - Public

- (void)fgl_setImageWithURL:(NSURL *)url
{
    [self sd_setImageWithURL:url];
}

- (void)fgl_setImageWithURL:(NSURL *)url usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle
{
    [self fgl_setImageWithURL:url
                   placeholderImage:nil
                            options:0
                           progress:nil
                          completed:nil
        usingActivityIndicatorStyle:activityStyle];
}

- (void)fgl_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStye
{
    [self fgl_setImageWithURL:url
                   placeholderImage:placeholder
                            options:0
                           progress:nil
                          completed:nil
        usingActivityIndicatorStyle:activityStye];
}

- (void)fgl_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                    options:(SDWebImageOptions)options
usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle
{
    [self fgl_setImageWithURL:url
                   placeholderImage:placeholder
                            options:options
                           progress:nil
                          completed:nil
        usingActivityIndicatorStyle:activityStyle];
}

- (void)fgl_setImageWithURL:(NSURL *)url
                  completed:(SDWebImageCompletionBlock)completedBlock
usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle
{
    [self fgl_setImageWithURL:url
                   placeholderImage:nil
                            options:0
                           progress:nil
                          completed:completedBlock
        usingActivityIndicatorStyle:activityStyle];
}

- (void)fgl_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                  completed:(SDWebImageCompletionBlock)completedBlock
usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle
{
    [self fgl_setImageWithURL:url
                   placeholderImage:placeholder
                            options:0
                           progress:nil
                          completed:completedBlock
        usingActivityIndicatorStyle:activityStyle];
}

- (void)fgl_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                    options:(SDWebImageOptions)options
                  completed:(SDWebImageCompletionBlock)completedBlock
usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle
{
    [self fgl_setImageWithURL:url
                   placeholderImage:placeholder
                            options:options
                           progress:nil
                          completed:completedBlock
        usingActivityIndicatorStyle:activityStyle];
}

- (void)fgl_setImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                    options:(SDWebImageOptions)options
                   progress:(SDWebImageDownloaderProgressBlock)progressBlock
                  completed:(SDWebImageCompletionBlock)completedBlock
usingActivityIndicatorStyle:(UIActivityIndicatorViewStyle)activityStyle
{

    [self fgl_addActivityIndicatorWithStyle:activityStyle];

    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                     options:options
                    progress:progressBlock
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageUrl) {
                       if (completedBlock) {
                           completedBlock(image, error, cacheType, imageUrl);
                       }
                       [weakSelf fgl_removeActivityIndicator];
                   }];
}

#pragma mark - Private

- (void)fgl_addActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)activityStyle
{

    if (!self.activityIndicator) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:activityStyle];

        self.activityIndicator.autoresizingMask = UIViewAutoresizingNone;

        [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(0);
        }];

        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self addSubview:self.activityIndicator];
        });
    }

    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self.activityIndicator startAnimating];
    });
}

- (void)fgl_removeActivityIndicator
{
    if (self.activityIndicator) {
        [self.activityIndicator removeFromSuperview];
        self.activityIndicator = nil;
    }
}

@end
