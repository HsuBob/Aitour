//
//  NetReachability.m
//  AiTour
//
//  Created by xbo on 2016/11/8.
//  Copyright © 2016年 xbo. All rights reserved.
//

#import "NetReachability.h"
#import "Reachability.h"
@implementation NetReachability

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(BOOL)isNetNetReachability
{
    Reachability *reach=[Reachability reachabilityForInternetConnection];
    NetworkStatus status=[reach currentReachabilityStatus];
    
    if (status==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:[self stringFromStatus:status] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
    }
    
    return status;
}

-(NSString *)stringFromStatus:(NetworkStatus)status
{
    NSString *string;
    switch (status) {
        case NotReachable:
            string=@"网络未连接";
            break;
        case ReachableViaWWAN:
            string=@"已连接移动网络";
            break;
        case ReachableViaWiFi:
            string=@"已连接WiFi网络";
            break;

            
        default:
            break;
    }
    return string;
}


+(void)NetWatching
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"] ;
    
    [reach startNotifier];
}
-(void)reachabilityChanged:(NSNotification *)notification
{
    
    Reachability *reach = [notification object];
    
    if([reach isKindOfClass:[Reachability class]]){
        
        NetworkStatus status = [reach currentReachabilityStatus];
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:[self stringFromStatus:status] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
    }
    
}
+ (BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch([reachability currentReachabilityStatus]){
        case NotReachable: isExistenceNetwork = FALSE;
            break;
        case ReachableViaWWAN: isExistenceNetwork = TRUE;
            break;
        case ReachableViaWiFi: isExistenceNetwork = TRUE;
            break;
    }
    return isExistenceNetwork;
}

@end
