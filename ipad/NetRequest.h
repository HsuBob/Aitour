//
//  NetRequest.h
//  AiTour
//
//  Created by xbo on 2016/10/10.
//  Copyright © 2016年 xbo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ModelBlock)(NSMutableArray *arry);
@interface NetRequest : NSObject
@property(nonatomic,assign)BOOL flag;
+(void)PersonalRequestID:(NSString *)Id Block:(ModelBlock)block;
+(void)LoginRequestID:(NSString *)Id PassWorsd:(NSString *)password Block:(ModelBlock)block;
+(void)ProjectRequestTag:(NSInteger)tag Block:(ModelBlock)block;
+(void)ThirdLoginQQRequestOpenID:(NSString *)openid Block:(ModelBlock)block;
+(void)BlindQQRequestID:(NSString *)Id PassWord:(NSString *)password OpenId:(NSString *)openid Block:(ModelBlock)block;
+(void)ThirdLoginWeiboRequestOpenID:(NSString *)openid Block:(ModelBlock)block;
+(void)BlindWeiboRequestID:(NSString *)Id PassWord:(NSString *)password OpenId:(NSString *)openid Block:(ModelBlock)block;
+(BOOL)AFNetworkingReality;
@end
