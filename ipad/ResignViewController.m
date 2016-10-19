//
//  ResignViewController.m
//  AiTour
//
//  Created by xbo on 2016/10/13.
//  Copyright © 2016年 xbo. All rights reserved.
//

#import "ResignViewController.h"
#import "NetRequest.h"
#import "MainViewController.h"
#import "SVProgressHUD.h"
#import<CommonCrypto/CommonDigest.h>
#import <QuartzCore/QuartzCore.h>
@interface ResignViewController ()
@property(nonatomic,copy)NSString *qqUseID;
@property(nonatomic,strong)UITextField *PasswordTx;
@property(nonatomic,strong)UITextField *NameTx;
@end

@implementation ResignViewController
-(void)setQquseID:(NSString *)qquseID
{
    _qqUseID=qquseID;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    titleView.backgroundColor=[UIColor colorWithRed:52/255.0 green:141/255.0  blue:161/255.0  alpha:1.0];
   [self.view addSubview:titleView];
    
    
    UIButton *backbut=[[UIButton alloc]initWithFrame:CGRectMake(10, 20, 50, 60)];
    [backbut setImage:[UIImage imageNamed:@"z"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:backbut];
    
    
    UILabel *titlelab=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 20, 200, 80)];
    titlelab.text=@"绑定账号";
    titlelab.textAlignment=NSTextAlignmentCenter;
    titlelab.backgroundColor=[UIColor clearColor];
    titlelab.textColor=[UIColor whiteColor];
    titlelab.font=[UIFont systemFontOfSize:30];
    [titleView addSubview:titlelab];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-140, 120, 280, 80)];
    lab.text=@"绑定账号密码登录";
    lab.textAlignment=NSTextAlignmentCenter;
    lab.textColor=[UIColor blackColor];
    lab.font=[UIFont systemFontOfSize:30];
    [self.view addSubview:lab];
    
    UILabel *leftline=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-140-130, 160, 120, 1)];
    leftline.backgroundColor=[UIColor blackColor];
    [self.view addSubview:leftline];
    
    UILabel *rightline=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+150, 160, 160, 1)];
    rightline.backgroundColor=[UIColor blackColor];
    [self.view addSubview:rightline];
    
    self.NameTx=[self textFiledFrame:CGRectMake(self.view.frame.size.width/2-300, 260, 600, 70) LeftText:@"账号 :"];
    self.PasswordTx=[self textFiledFrame:CGRectMake(self.view.frame.size.width/2-300, 380, 600, 70) LeftText:@"密码 :"];
    [self.view addSubview:self.NameTx];
    [self.view addSubview:self.PasswordTx];
    
    
  
    
    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-250, 500, 500, 80)];
    [but setImage:[UIImage imageNamed:@"ios_dlan1"] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:@"ios_dlan01"] forState:UIControlStateSelected];
    [but addTarget:self action:@selector(finished) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:but];


}

-(UITextField *)textFiledFrame:(CGRect)frame LeftText:(NSString *)text
{
    UITextField *nametx=[[UITextField alloc]initWithFrame:frame];
    nametx.layer.borderWidth=3;
    nametx.layer.masksToBounds=YES;
    nametx.layer.cornerRadius=6;
    nametx.textColor=[UIColor colorWithRed:182/255.0 green:183/255.0 blue:184/255.0 alpha:1.0];
    nametx.font=[UIFont systemFontOfSize:30];
    
    UILabel *leftview=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 70)];
    leftview.text=text;
    leftview.textAlignment=NSTextAlignmentCenter;
    leftview.font=[UIFont systemFontOfSize:30];
    leftview.textColor=[UIColor colorWithRed:182/255.0 green:183/255.0 blue:184/255.0 alpha:1.0];
    
    nametx.leftView=leftview;
    nametx.leftViewMode=UITextFieldViewModeAlways;
    
    
    
    nametx.layer.borderColor=[UIColor colorWithRed:182/255.0 green:183/255.0 blue:184/255.0 alpha:1.0].CGColor;
    
    return nametx;
}
-(void)finished
{
    
    
      [SVProgressHUD show];
      [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    
    if (self.view.tag==1) {
        [NetRequest BlindQQRequestID:_NameTx.text PassWord:[self setMD5] OpenId:_qqUseID Block:^(NSMutableArray *blockarry){
            
            NSLog(@"%@",blockarry[0]);
            
            [SVProgressHUD dismiss];
            if ([blockarry[0] isEqualToString:@"0"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码错误" message:@"请重新输入" preferredStyle:  UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //点击按钮的响应事件；
                }]];
                
                //弹出提示框；
                [self presentViewController:alert animated:true completion:nil];
                
            }
            
            if ([blockarry[0] isEqualToString:@"2"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"账号被已经绑定" message:@"请重新输入绑定的账号" preferredStyle:  UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //点击按钮的响应事件；
                }]];
                
                //弹出提示框；
                [self presentViewController:alert animated:true completion:nil];
                
            }
            
            if ([blockarry[0] isEqualToString:@"1"]) {
                
                MainViewController *main=[[MainViewController alloc]init];
                [main setStuID:_NameTx.text];
                
                [self presentViewController:main animated:YES completion:nil];
            }
            
            
            
        }];

    }
    
    
    if (self.view.tag==0) {
        [NetRequest BlindWeiboRequestID:_NameTx.text PassWord:[self setMD5] OpenId:_qqUseID Block:^(NSMutableArray *blockarry){
            
            NSLog(@"%@",blockarry[0]);
            
            [SVProgressHUD dismiss];
            if ([blockarry[0] isEqualToString:@"0"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码错误" message:@"请重新输入" preferredStyle:  UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //点击按钮的响应事件；
                }]];
                
                //弹出提示框；
                [self presentViewController:alert animated:true completion:nil];
                
            }
            
            if ([blockarry[0] isEqualToString:@"2"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"账号被已经绑定" message:@"请重新输入绑定的账号" preferredStyle:  UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //点击按钮的响应事件；
                }]];
                
                //弹出提示框；
                [self presentViewController:alert animated:true completion:nil];
                
            }
            
            if ([blockarry[0] isEqualToString:@"1"]) {
                
                MainViewController *main=[[MainViewController alloc]init];
                [main setStuID:_NameTx.text];
                
                [self presentViewController:main animated:YES completion:nil];
            }
            
            
            
        }];
        
    }





}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableString *)setMD5
{
    int i=[_PasswordTx.text intValue],code;
    code=i%10*100000+i/10+44444;
    NSMutableString *codestr=[self md5: [NSString stringWithFormat:@"%06d",code]] ;
    
    
    codestr = (NSMutableString *)[codestr substringToIndex:[codestr length] - 2];
    NSLog(@"%@",[codestr substringToIndex:[codestr length] - 2]);
    
    return codestr;

}
- (NSMutableString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
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
