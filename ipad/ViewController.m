//
//  ViewController.m
//  ipad
//
//  Created by xbo on 16/8/5.
//  Copyright © 2016年 xbo. All rights reserved.
//

#import "ViewController.h"
#import "ThirdLoginController.h"
#import "SVProgressHUD.h"
#import "MainViewController.h"
#import<CommonCrypto/CommonDigest.h>
#import "NetRequest.h"

@interface ViewController ()

@property(nonatomic,strong) UITextField *nametx;
@property(nonatomic,strong) UITextField *codetx;
@property(nonatomic,strong) NSMutableArray *arry;

@end
static NSString *stuID;
@implementation ViewController
@synthesize nametx,codetx;

-(void)setStutID:(valueBlock)block
{
    block(stuID);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *backimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dt"]];
    backimage.frame=self.view.frame;
    backimage.userInteractionEnabled=YES;
    [self.view addSubview:backimage];
    
    
    
    UITextField *inputview = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];

    inputview.backgroundColor = [UIColor whiteColor];

    
    //监听键盘出现和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    nametx=[[UITextField alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/2-200, 410, 400, 40)];
    nametx.placeholder=@"请输入用户名";
    nametx.textAlignment=NSTextAlignmentCenter;
    
//    inputview.text=@"2222";
//    nametx.inputAccessoryView=inputview;
    
    nametx.borderStyle = UITextBorderStyleRoundedRect;
    UIImageView *accLeftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zh"]];
    accLeftView.contentMode = UIViewContentModeCenter;
    accLeftView.frame=CGRectMake(0, 0, 55, 0);
    // 添加到左侧视图中
    nametx.leftView = accLeftView;
    
    nametx.leftViewMode =UITextFieldViewModeAlways;
    [nametx setValue:[UIColor colorWithRed:126/255.0  green:195/255.0  blue:201/255.0  alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    nametx.adjustsFontSizeToFitWidth = YES;
    [backimage addSubview:nametx];
    
    
    
    
    codetx=[[UITextField alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/2-200, 460, 400, 40)];
    codetx.placeholder=@"请输入密码";
    codetx.textAlignment=NSTextAlignmentCenter;
    codetx.borderStyle = UITextBorderStyleRoundedRect;
    
    UIImageView *accLeftView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mm"]];
    accLeftView1.contentMode = UIViewContentModeCenter;
    accLeftView1.frame=CGRectMake(0, 0, 55, 0);
    codetx.leftView = accLeftView1;
    codetx.leftViewMode =UITextFieldViewModeAlways;
    codetx.secureTextEntry=YES;
    codetx.textColor=[UIColor colorWithRed:126/255.0  green:195/255.0  blue:201/255.0  alpha:1.0];
    codetx.keyboardType=UIKeyboardTypeNumberPad;
    codetx.adjustsFontSizeToFitWidth = YES;
    
     [codetx setValue:[UIColor colorWithRed:126/255.0  green:195/255.0  blue:201/255.0  alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    [backimage addSubview:codetx];
    
    
    UIButton *loginbut=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/2-200, 520, 400, 40)];
    
    [loginbut setImage:[UIImage imageNamed:@"dl"] forState:UIControlStateNormal];
    [loginbut addTarget:self action:@selector(setMD5) forControlEvents:UIControlEventTouchUpInside];
    
    [backimage addSubview:loginbut];
    
    
    
    UIButton *thridbut=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/2-200, 570, 400, 40)];
    [thridbut setTitle:@"第三方登录" forState:UIControlStateNormal ];
    
    thridbut.backgroundColor=[UIColor clearColor];
    
    [thridbut addTarget:self action:@selector(thridlogin) forControlEvents:UIControlEventTouchUpInside];
    
    [backimage addSubview:thridbut];
    
    
   

}
#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    nametx.frame=CGRectMake((self.view.frame.size.width)/2-200, self.view.frame.size.height-keyBoardRect.size.height-90, 400, 40);
    codetx.frame=CGRectMake((self.view.frame.size.width)/2-200, self.view.frame.size.height-keyBoardRect.size.height-40, 400, 40);
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    nametx.frame=CGRectMake((self.view.frame.size.width)/2-200, 410, 400, 40);
    codetx.frame=CGRectMake((self.view.frame.size.width)/2-200, 460, 400, 40);

}
-(void)setMD5
{
  //   [self setMySQL];
    
    int i=[codetx.text intValue],code;
    code=i%10*100000+i/10+44444;
    NSMutableString *codestr=[self md5: [NSString stringWithFormat:@"%06d",code]] ;
    
  
//    NSLog(@"%@",codestr);
 static   BOOL flag;
    //  [codestr appendString:@"fa"];
   codestr = (NSMutableString *)[codestr substringToIndex:[codestr length] - 2];
    NSLog(@"%@",[codestr substringToIndex:[codestr length] - 2]);
    
    [SVProgressHUD show];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [NetRequest LoginRequestID:nametx.text PassWorsd:codestr Block:^(NSMutableArray *blockarry)
     {
         flag=[blockarry[0] integerValue];
         
         [SVProgressHUD dismiss];
         if (!flag){
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码错误" message:@"点击重新输入" preferredStyle:  UIAlertControllerStyleAlert];
             [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 //点击按钮的响应事件；
             }]];
             
             //弹出提示框；
             [self presentViewController:alert animated:true completion:nil];
             
         }
         else
         {
             stuID=nametx.text;
             MainViewController *main=[[MainViewController alloc]init];
             [self presentViewController:main animated:YES completion:nil];
         }

         
         
        
         
     }];
    
    
    
 /*   for(i=0;i<self.arry.count;i++)
        
    
    {
        NSArray *aryy=self.arry[i];
        
        
        if ( [  [NSString stringWithFormat:@" %@", nametx.text]  isEqualToString:[NSString stringWithFormat:@" %@", aryy[0]]])
        {
        
            NSMutableString *Mutstr=[NSMutableString stringWithFormat:@"%@",aryy[5]];
           
            ;
            if (Mutstr.length<=codestr.length) {
                [Mutstr appendString:@"fa"];
            }
            else
            {
                [codestr appendString:@"fa"];
            }
            
          if ([codestr isEqual: Mutstr]) {
                
                flag=YES;

                MainViewController *main=[[MainViewController alloc]init];
                [self presentViewController:main animated:YES completion:nil];
                               break;
            }
        }
        
       
    }       */
    
    
    
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

//-(void)setMySQL
//{
//    
//    MySQLdb *db=[[MySQLdb alloc]init];
//    [db connectHost:@"192.168.1.26" connectPort:3356 connectUser:@"test1" connectPassword:@"123" connectDbName:@"test"];
//    self.arry=[db query:@"select * from student;"];
//    
//    
// //   NSLog(@"%@",self.arry);
//    
//    
//    [db disconnect];
//
//}
-(void)thridlogin
{
    ThirdLoginController *login=[[ThirdLoginController alloc ]init];
    
    
    [self presentViewController:login animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
