//
//  NetRequest.m
//  AiTour
//
//  Created by xbo on 2016/10/10.
//  Copyright © 2016年 xbo. All rights reserved.
//

#import "NetRequest.h"
#import "AFNetworking.h"
#import "GDataXMLNode.h"
#import "Model.h"
#import <UIKit/UIKit.h>

@implementation NetRequest


+(void)PersonalRequestID:(NSString *)Id Block:(ModelBlock)block
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval=30;
       
    [manager GET:[NSString stringWithFormat:@"http://121.42.62.235:8093/MyWebService.asmx/GetScoreByStuID?stuID=%@",Id ] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arry=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",arry);
        
        NSMutableArray *mutarry=[NSMutableArray array];
        
       
        
        for (int i=0; i<arry.count; i++) {
            NSDictionary *dic=arry[i];
            Model *model=[Model new];
            model.name=dic[@"name"];
            model.score=[NSString stringWithFormat:@"%@",dic[@"score"]];
            model.testTime=dic[@"testTime"];
            model.scenicspotName=dic[@"scenicspotName"];
            
            [mutarry addObject:model];
            
        }

        block(mutarry);
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"\n*****************%@",error);
    }];
    
    
}

+(void)ProjectRequestTag:(NSInteger)tag Block:(ModelBlock)block
{
    NSArray *arry=[NSArray arrayWithObjects:@"武当山",@"留园",@"故宫",@"三峡",@"丽江", nil];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
   
    
    [manager GET:[[NSString stringWithFormat:@"http://121.42.62.235:8093/MyWebService.asmx//GetScoreByScenicspotID?scenicspotID=%d",tag]  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arry=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        
        NSMutableArray *mutarry=[NSMutableArray array];
        
        for (int i=0; i<arry.count; i++) {
            NSDictionary *dic=arry[i];
            Model *model=[Model new];
            model.name=dic[@"name"];
            model.score=[NSString stringWithFormat:@"%@",dic[@"score"]];
            model.testTime=dic[@"testTime"];
            
            [mutarry addObject:model];
            
           
            
        }

        block(mutarry);

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n*****************%@",error);
    }];
    
    
}
+(void)BlindQQRequestID:(NSString *)Id PassWord:(NSString *)password OpenId:(NSString *)openid Block:(ModelBlock)block
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval=30;
    
    [manager GET:[NSString stringWithFormat:@"http://121.42.62.235:8093/MyWebService.asmx/QQBind_IOS?QQOpenID_IOS=%@&stuID=%@&password=%@",openid,Id ,password] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseObject options:0 error:nil];
        
        //        [doc.rootElement.stringValue intValue];
        
        NSMutableArray  *arry=[NSMutableArray arrayWithObjects:doc.rootElement.stringValue, nil];
//        NSLog(@"*************** %@",arry);
        
        block(arry);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n*****************%@",error);
    }];

    
}
+(void)ThirdLoginQQRequestOpenID:(NSString *)openid Block:(ModelBlock)block
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval=30;
    
    [manager GET:[NSString stringWithFormat:@"http://121.42.62.235:8093/MyWebService.asmx/QQLogin_IOS?QQOpenID_IOS=%@",openid] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        NSMutableArray *mutarry=[NSMutableArray array];
        [mutarry addObject:dic[@"isLogin"]];
        [mutarry addObject:dic[@"stuID"]];
        block(mutarry);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n*****************%@",error);
    }];

}
+(void)BlindWeiboRequestID:(NSString *)Id PassWord:(NSString *)password OpenId:(NSString *)openid Block:(ModelBlock)block
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval=30;
    
    [manager GET:[NSString stringWithFormat:@"http://121.42.62.235:8093/MyWebService.asmx/WeiboBind?WeiboUID=%@&stuID=%@&password=%@",openid,Id ,password] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseObject options:0 error:nil];
        
        //        [doc.rootElement.stringValue intValue];
        
        NSMutableArray  *arry=[NSMutableArray arrayWithObjects:doc.rootElement.stringValue, nil];
        //        NSLog(@"*************** %@",arry);
        
        block(arry);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n*****************%@",error);
    }];
    
    
}
+(void)ThirdLoginWeiboRequestOpenID:(NSString *)openid Block:(ModelBlock)block
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval=30;
    
    [manager GET:[NSString stringWithFormat:@"http://121.42.62.235:8093/MyWebService.asmx/WeiboLogin?WeiboUID=%@",openid] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        NSMutableArray *mutarry=[NSMutableArray array];
        [mutarry addObject:dic[@"isLogin"]];
        [mutarry addObject:dic[@"stuID"]];
        block(mutarry);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n*****************%@",error);
    }];
    
}

+(void)LoginRequestID:(NSString *)Id PassWorsd:(NSString *)password Block:(ModelBlock)block
{
 
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    [manager GET:[NSString stringWithFormat:@"http://121.42.62.235:8093/MyWebService.asmx/CheckLogin?stuID=%@&password=%@",Id,password] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseObject options:0 error:nil];
        
        NSLog(@"%@",[NSString stringWithFormat:@"http://121.42.62.235:8093//MyWebService.asmx/CheckLogin?stuID=%@&password=%@",Id,password]);
        
       
//        [doc.rootElement.stringValue intValue];
        
       
        
        NSMutableArray  *arry=[NSMutableArray arrayWithObjects:doc.rootElement.stringValue, nil];
        
        
        block(arry);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"\n*****************%@",error);
    }];

    
    
    
}
BOOL flag;
int i;
+(BOOL)AFNetworkingReality
{
    
    
    AFNetworkReachabilityManager *manager=[AFNetworkReachabilityManager manager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                i=111111;
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
               i=1;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                i=2;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                i=3;
                break;
            default:
                break;
        }
         NSLog(@"%d",i);
    }];
    [manager startMonitoring];
    
    
   
    if (!flag) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"警告" message:@"网络错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];}

    
    return flag;
}

@end

