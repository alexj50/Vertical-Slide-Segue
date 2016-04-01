//
//  SplitViewShowSegue.m
//  Navigation contoller segue
//
//  Created by Alex Jacobson on 3/31/16.
//  Copyright © 2016 Alex Jacobson. All rights reserved.
//

#import "SplitViewShowSegue.h"

@implementation SplitViewShowSegue

static float animationDurration = 1.0;

-(void)perform{
    UIViewController *sourceVC      = self.sourceViewController;
    UIViewController *destinationVC = self.destinationViewController;
                                                                                // split the screen in half minus the nav bar
    NSArray *halfsOfScreen = [SplitViewShowSegue splitScreenInHalf:sourceVC:destinationVC];
                                                                                // assign the split images to image views to be animated
    UIImageView *leftImageView  = halfsOfScreen[0];
    UIImageView *rightImageView = halfsOfScreen[1];
                                                                                // fade out nav bar elements
    [SplitViewShowSegue fadeOutNavBar:YES view:sourceVC];
                                                                                // present next controller
    [sourceVC.navigationController pushViewController:destinationVC animated:NO];
                                                                                // fade in nav bar elements
    [SplitViewShowSegue fadeOutNavBar:NO view:destinationVC];
    
                                                                                // do the image animations
    [UIView animateWithDuration:animationDurration animations:^{
        leftImageView.frame  = CGRectMake(0, -leftImageView.frame.size.height, leftImageView.frame.size.width, leftImageView.frame.size.height);
        rightImageView.frame = CGRectMake(rightImageView.frame.size.width, rightImageView.frame.size.height, rightImageView.frame.size.width, rightImageView.frame.size.height);
    }];
}

+ (void) fadeOutNavBar : (BOOL) fade view:(UIViewController *) vc {             // Since nav bar elements are private find each one by class name and fade accordingly
    for (UIView* view in vc.navigationController.navigationBar.subviews) {
        NSString *class = [NSString stringWithFormat:@"%@", [view class]];
        if ([class isEqualToString:@"UINavigationItemView"] || [class isEqualToString:@"UINavigationItemButtonView"] || [class isEqualToString:@"UINavigationButton"]) {
            view.alpha = fade;
            [UIView animateWithDuration:animationDurration animations:^{
                view.alpha = !fade;
            }];
        }
    }
}

+ (UIImage*) takeScreenshotOfView : (UIView*) view {                            // take screenshot view
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.frame afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(NSArray *) splitScreenInHalf : (UIViewController *) sourceVC : (UIViewController *) destinationVC{
    UIImage *image = [SplitViewShowSegue takeScreenshotOfView:sourceVC.view];
    
    CGImageRef tmpImgRef = image.CGImage;                                       // convert image to cg then crop in half vertically
    CGImageRef leftImgRef = CGImageCreateWithImageInRect(tmpImgRef, CGRectMake(0, 0, CGImageGetWidth(tmpImgRef) / 2.0, CGImageGetHeight(tmpImgRef)));
    UIImage *leftImage = [UIImage imageWithCGImage:leftImgRef];
    CGImageRelease(leftImgRef);
    
    CGImageRef rightImgRef = CGImageCreateWithImageInRect(tmpImgRef, CGRectMake(CGImageGetWidth(tmpImgRef) / 2.0, 0,  CGImageGetWidth(tmpImgRef)/2.0, CGImageGetHeight(tmpImgRef)));                                                          // right image crop
    UIImage *rightImage = [UIImage imageWithCGImage:rightImgRef];
    CGImageRelease(rightImgRef);
                                                                                // create image views to hold images for animations
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height)];
    leftImageView.image        = leftImage;
    [destinationVC.view addSubview:leftImageView];
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height)];
    rightImageView.image        = rightImage;
    [destinationVC.view addSubview:rightImageView];
    
    return @[leftImageView, rightImageView];                                    // return array of the image views
}

@end
