//
//  AppDelegate.h
//  weiboShareDemo
//
//  Created by qingyun on 7/23/13.
//  Copyright (c) 2013 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#import "ViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
