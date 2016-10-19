//
//  ViewController.h
//  ipad
//
//  Created by xbo on 16/8/5.
//  Copyright © 2016年 xbo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^valueBlock)(NSString *stuID);
@interface ViewController : UIViewController
-(void )setStutID:(valueBlock)block;

@end

