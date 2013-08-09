//
//  ViewController.m
//  weiboShareDemo
//
//  Created by qingyun on 7/23/13.
//  Copyright (c) 2013 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "WeiboSDK.h"

//mac address
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

//device 
#include <sys/types.h>
#include <sys/sysctl.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewLoad");
    
    NSLog(@"Macaddress:%@",[self macaddress]);
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testOBtnPress:(id)sender
{
    
    /*
    UIImage *snapshot;
    CGImageRef cgScreen = UIGetScreenImage();
    if (cgScreen) {
        snapshot = [UIImage imageWithCGImage:cgScreen];
        CGImageRelease(cgScreen);
    }
    
    CGRect rect = CGRectMake(0,125, 640, 750);//创建要剪切的矩形框 这里你可以自己修改
    UIImage *res = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([snapshot CGImage], rect)];
    
    NSLog(@"ssf:%@",res );
    _imageViewW.image = res;
    */
   //did you sove the problem? has everyone can soved this problem 
    /*
    WBProvideMessageForWeiboResponse *response = [WBProvideMessageForWeiboResponse responseWithMessage:[self messageToShare] ];
    
    if ([WeiboSDK sendResponse:response])
    {
        [self dismissModalViewControllerAnimated:YES];
    }
 
    */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 280, 20)];
    label.text = [@"systemName : " stringByAppendingString:[[UIDevice currentDevice] systemName]];
    label.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 280, 20)];
    label.text = [@"systemVersion : " stringByAppendingString:[[UIDevice currentDevice] systemVersion]];
    label.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, 20)];
    label.text = [@"model : " stringByAppendingString:[[UIDevice currentDevice] model]];
    label.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:label];
    
    /*
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, 20)];
    label.text = [@"deviceId : " stringByAppendingString:[[UIDevice currentDevice] ]];
    label.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:label];
    */
     
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 20)];
    label.text = [@"deviceName : " stringByAppendingString:[[UIDevice currentDevice] name]];
    label.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 280, 20)];
    label.text = [@"localizedModel : " stringByAppendingString:[[UIDevice currentDevice] localizedModel]];
    label.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:label];

    
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 190, 280, 20)];
    label.text = [@"platform : " stringByAppendingString:[self platform]];
    label.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:label];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 280, 20)];
    label.text = [@"platformString : " stringByAppendingString:[self platformString]];
    label.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:label];

    
    //NSLog(@"dd:%@  %@",[self platform], [self platformString]);
}


- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
     message.text = @"测试通过WeiboSDK发送文字到微博!";
        
    return message;
}






//device 
- (NSString *) platform{
    
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *machine = malloc(size);
    
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    
    return platform;
    
}

- (NSString *) platformString{
    
    NSString *platform = [self platform];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])         return @"iPhone Simulator";
    
    return platform;
    
}






//mac address
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list            
// Accidentally munged during previous update. Fixed thanks to erica sadun & mlamb.
- (NSString *)macaddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}




@end
