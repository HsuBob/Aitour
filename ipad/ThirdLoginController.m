//
//  ThirdLoginController.m
//  ipad
//
//  Created by xbo on 16/8/8.
//  Copyright © 2016年 xbo. All rights reserved.
//

#import "ThirdLoginController.h"
#import "MainViewController.h"
#import "NetRequest.h"
#import "ResignViewController.h"
#import "UMSocial.h"

@interface ThirdLoginController ()

@end

@implementation ThirdLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dt"]];
    backimage.frame=self.view.frame;
    backimage.userInteractionEnabled=YES;
    [self.view addSubview:backimage];
    
    UIButton *backbut=[[UIButton alloc]initWithFrame:CGRectMake(10, 30, 50, 60)];
    [backbut setImage:[UIImage imageNamed:@"z"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backimage addSubview:backbut];
    
    
    UIButton *QQbut=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/2-300, 460, 300, 40)];
    [QQbut setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    [QQbut addTarget:self action:@selector(QQlogin) forControlEvents:UIControlEventTouchUpInside];
    [backimage addSubview:QQbut];
    
    UIButton *WBbut=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/2, 460, 300, 40)];
    [WBbut setImage:[UIImage imageNamed:@"wb"] forState:UIControlStateNormal];
    [WBbut addTarget:self action:@selector(Wblogin) forControlEvents:UIControlEventTouchUpInside];
    [backimage addSubview:WBbut];
    
    

}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)Wblogin
{
    
    
    
    
    
    // 1.创建UMSocialSnsPlatform对象
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    // 2.第三方登录
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        // 获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            [NetRequest ThirdLoginWeiboRequestOpenID:snsAccount.usid Block:^(NSMutableArray *blockarry){
                
                NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                
                NSLog(@"    ________________   %@",blockarry[0]);
                
                if ([[NSString stringWithFormat:@"%@",blockarry[0]] isEqualToString:@"1"]) {
                    MainViewController *main=[[MainViewController alloc]init];
                    [main setStuID:[NSString stringWithFormat:@"%@",blockarry[1]]];
                    
                    [self presentViewController:main animated:YES completion:nil];
                }
                else
                {
                    ResignViewController *Resign=[[ResignViewController alloc]init];
                    [Resign setQquseID:snsAccount.usid];
                    Resign.view.tag=0;
                    [self presentViewController:Resign animated:YES completion:nil];
                    
                }
                
                
            }];

            
            
        }});

}
-(void)QQlogin
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //  获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
           
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            [NetRequest ThirdLoginQQRequestOpenID:snsAccount.usid Block:^(NSMutableArray *blockarry){
                
                NSLog(@"%@",blockarry[0]);
                if ([[NSString stringWithFormat:@"%@",blockarry[0]] isEqualToString:@"1"]) {
                    MainViewController *main=[[MainViewController alloc]init];
                    [main setStuID:[NSString stringWithFormat:@"%@",blockarry[1]]];
                    
                    [self presentViewController:main animated:YES completion:nil];
                }
                else
                {
                    ResignViewController *Resign=[[ResignViewController alloc]init];
                    [Resign setQquseID:snsAccount.usid];
                    Resign.view.tag=1;
                    [self presentViewController:Resign animated:YES completion:nil];
                    
                }
            
            
            }];

        }});

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
