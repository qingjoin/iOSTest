//
//  ViewController.h
//  weiboShareDemo
//
//  Created by qingyun on 7/23/13.
//  Copyright (c) 2013 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"

#define  weiboAppKey @"699244842"

@interface ViewController : UIViewController<WeiboSDKDelegate>

- (IBAction)testOBtnPress:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewW;

@end
