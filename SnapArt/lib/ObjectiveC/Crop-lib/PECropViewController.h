//
//  PECropViewController.h
//  PhotoCropEditor
//
//  Created by kishikawa katsumi on 2013/05/19.
//  Copyright (c) 2013 kishikawa katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PECropView.h"
@protocol PECropViewControllerDelegate;

@interface PECropViewController : UIViewController

@property (nonatomic, weak) id<PECropViewControllerDelegate> delegate;
@property (nonatomic) UIImage *image;

@property (nonatomic) BOOL keepingCropAspectRatio;
@property (nonatomic) CGFloat cropAspectRatio;

@property (nonatomic) CGRect cropRect;
@property (nonatomic) CGRect imageCropRect;

@property (nonatomic) BOOL toolbarHidden;

@property (nonatomic, assign, getter = isRotationEnabled) BOOL rotationEnabled;

@property (nonatomic, readonly) CGAffineTransform rotationTransform;

@property (nonatomic, readonly) CGRect zoomedCropRect;

- (PECropView*)getCropView;
- (void)resetCropRect;
- (void)resetCropRectAnimated:(BOOL)animated;
- (void)croped;
-(NSString *)GETPELocalizedString:(NSString*)key WithComment:(NSString*)comment;
-(void)cropedImageSizeWithRatio:(CGFloat)w and:(CGFloat)h;
@end

@protocol PECropViewControllerDelegate <NSObject>
@optional
- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage;
- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect;
- (void)cropViewControllerDidCancel:(PECropViewController *)controller;

@end
