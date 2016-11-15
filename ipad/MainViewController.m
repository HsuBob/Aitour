//
//  MainViewController.m
//  ipad
//
//  Created by xbo on 16/8/8.
//  Copyright © 2016年 xbo. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"
#import "PersonlViewController.h"
#import "ProjectViewController.h"
#import "RankViewController.h"
@interface MainViewController ()
@property(nonatomic,copy)NSString *stuID;


@end
@implementation MainViewController


-(void)setStuID:(NSString *)stuID
{
    _stuID=stuID;
}

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
    
    
    UIButton *choicebut=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/2-200, (self.view.frame.size.height)/2-75, 150, 150)];
    
    [choicebut setImage:[UIImage imageNamed:@"xmgl"] forState:UIControlStateNormal];
    [choicebut addTarget:self action:@selector(projectchoice) forControlEvents:UIControlEventTouchUpInside];
    
    [backimage addSubview:choicebut];
    
    UIButton *rankbut=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width)/2+50, (self.view.frame.size.height)/2-75, 150, 150)];
    
    [rankbut setImage:[UIImage imageNamed:@"phb"] forState:UIControlStateNormal];
    [rankbut addTarget:self action:@selector(ranklist) forControlEvents:UIControlEventTouchUpInside];
    
    [backimage addSubview:rankbut];
    
    
    UIButton *personbut =[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width)-200, (self.view.frame.size.height)-80, 150, 70)];
    
    [personbut setImage:[UIImage imageNamed:@"gr"] forState:UIControlStateNormal];
    [personbut addTarget:self action:@selector(personlist) forControlEvents:UIControlEventTouchUpInside];
    [backimage addSubview:personbut];

}
-(void)personlist
{
    PersonlViewController *personVc=[[PersonlViewController alloc]init];

    [personVc setStuID:_stuID];
    
    [self presentViewController:personVc animated:YES completion:nil];
}
-(void)ranklist
{
    RankViewController *rankVc=[[RankViewController alloc]init];
    
    [self presentViewController:rankVc animated:YES completion:nil];
}
-(void)projectchoice
{
    ProjectViewController *projectVc=[[ProjectViewController alloc]init];
    
    [self presentViewController:projectVc animated:YES completion:nil];
    
}

-(void)back
{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要退出登录吗？" preferredStyle:  UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              //点击按钮的响应事件；
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        ViewController *vc=[ViewController new];
        
        [self presentViewController:vc animated:YES completion:nil];
        //点击按钮的响应事件；
    }]];
    
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
   
}

@end
