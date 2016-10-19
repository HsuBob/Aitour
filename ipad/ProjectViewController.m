//
//  ProjectViewController.m
//  ipad
//
//  Created by xbo on 16/8/8.
//  Copyright © 2016年 xbo. All rights reserved.
//

#import "ProjectViewController.h"


@interface ProjectViewController ()


@property(nonatomic,strong)UIImageView *choiceimage;

@end
@implementation ProjectViewController




-(void)viewDidLoad
{
    UIImageView *backimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
    backimage.frame=self.view.frame;
    backimage.userInteractionEnabled=YES;
    [self.view addSubview:backimage];
    
    UIButton *backbut=[[UIButton alloc]initWithFrame:CGRectMake(10, 30, 50, 60)];
    [backbut setImage:[UIImage imageNamed:@"z"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backimage addSubview:backbut];
    
    
    
    UIButton *lybut=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/2-75, (self.view.frame.size.height)/2-75, 150, 150)];
    
    [lybut setImage:[UIImage imageNamed:@"ly"] forState:UIControlStateNormal];
    [lybut addTarget:self action:@selector(ranklist:) forControlEvents:UIControlEventTouchUpInside];
     lybut.tag=3;
    [backimage addSubview:lybut];
    
    UIButton *wdsbut=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/2-235, (self.view.frame.size.height)/2-75, 150, 150)];
     wdsbut.tag=2;
    [wdsbut setImage:[UIImage imageNamed:@"wds"] forState:UIControlStateNormal];
    [wdsbut addTarget:self action:@selector(ranklist:) forControlEvents:UIControlEventTouchUpInside];
    [backimage addSubview:wdsbut];
    
    
    UIButton *ggsbut=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/2-395, (self.view.frame.size.height)/2-75, 150, 150)];
    ggsbut.tag=1;
    [ggsbut setImage:[UIImage imageNamed:@"gg"] forState:UIControlStateNormal];
    [ggsbut addTarget:self action:@selector(ranklist:) forControlEvents:UIControlEventTouchUpInside];
    [backimage addSubview:ggsbut];
    
    
    UIButton *sxbut=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/2+85, (self.view.frame.size.height)/2-75, 150, 150)];
    [sxbut setImage:[UIImage imageNamed:@"sxrj"] forState:UIControlStateNormal];
    [sxbut addTarget:self action:@selector(ranklist:) forControlEvents:UIControlEventTouchUpInside];
     sxbut.tag=4;
    [backimage addSubview:sxbut];
    
    UIButton *ljbut=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/2+245, (self.view.frame.size.height)/2-75, 150, 150)];
    
    [ljbut setImage:[UIImage imageNamed:@"lj"] forState:UIControlStateNormal];
    [ljbut addTarget:self action:@selector(ranklist:) forControlEvents:UIControlEventTouchUpInside];
     ljbut.tag=5;
    [backimage addSubview:ljbut];
    
    self.choiceimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jd"]];
    self.choiceimage.frame=CGRectMake((self.view.frame.size.width)/2-75, (self.view.frame.size.height)/2-180, 150, 80);
    [backimage addSubview:self.choiceimage];
    
    

}

-(void)ranklist:(UIButton *)sender
{
    CGRect buttonframe=sender.frame;
    CGRect labelframe=self.choiceimage.frame;
    labelframe.origin.x=buttonframe.origin.x;
    [UIView beginAnimations:@"name" context:nil ];
    [UIView setAnimationDuration:0.2];
    self.choiceimage.frame=labelframe;
      [UIView commitAnimations];
    
    if (sender.tag==1) {
        NSURL * myURL_APP_A = [NSURL URLWithString:@"Testgg://01"];
        if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
            NSLog(@"canOpenURL  01");
            [[UIApplication sharedApplication] openURL:myURL_APP_A];
        }

    }
    if (sender.tag==2) {
        NSURL * myURL_APP_A = [NSURL URLWithString:@"Testwds://02"];
        if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
            NSLog(@"canOpenURL  02");
            [[UIApplication sharedApplication] openURL:myURL_APP_A];
        }
        
    }
    if (sender.tag==3) {
        NSURL * myURL_APP_A = [NSURL URLWithString:@"Testly://03"];
        if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
            NSLog(@"canOpenURL  03");
            [[UIApplication sharedApplication] openURL:myURL_APP_A];
        }
        
    }
    if (sender.tag==4) {
        NSURL * myURL_APP_A = [NSURL URLWithString:@"Testsx://04"];
        if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
            NSLog(@"canOpenURL  04");
            [[UIApplication sharedApplication] openURL:myURL_APP_A];
        }
        
    }
    if (sender.tag==5) {
        NSURL * myURL_APP_A = [NSURL URLWithString:@"Testlj://05"];
        if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
            NSLog(@"canOpenURL  05");
            [[UIApplication sharedApplication] openURL:myURL_APP_A];
        }
        
    }



}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if (!url) {  return NO; }
    NSString *URLString = [url absoluteString];
    NSLog(@"%@",URLString);
    //[[NSUserDefaults standardUserDefaults] setObject:URLString forKey:@"url"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
        NSLog(@"didFinishLaunchingWithOptions---B");
        return YES;
}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
