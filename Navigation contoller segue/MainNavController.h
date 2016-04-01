//
//  MainNavController.h
//  Navigation controller segue
//
//  Created by Alex Jacobson on 3/31/16.
//  Copyright © 2016 Alex Jacobson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>
@optional
-(BOOL)navigationShouldPopOnBackButton;                                         // optional, if you want to control the navigation back button in view controller
@end

@interface UIViewController (BackButtonHandler) <BackButtonHandlerProtocol>

@end


@interface MainNavController : UINavigationController

@end
