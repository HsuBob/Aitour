//
//  PersonlViewController.m
//  ipad
//
//  Created by xbo on 16/8/8.
//  Copyright © 2016年 xbo. All rights reserved.
//

#import "PersonlViewController.h"
#import "ViewController.h"
#import "SVProgressHUD.h"
#import "NetRequest.h"
#import "Model.h"

@interface PersonlViewController()

@property(nonatomic,strong) NSMutableArray *arry;
@property(nonatomic,strong) UITableView *persontable;
@property(nonatomic,strong) UILabel *namelab;
@property(nonatomic,copy)NSString *stuID;
@end
@implementation PersonlViewController

static CGRect frame;

-(void)setStuID:(NSString *)stuID
{
    _stuID=stuID;
}


-(void)viewWillAppear:(BOOL)animated
{
    [self getData];
    
    
    
}
-(void)viewDidLoad
{
    self.arry=[NSMutableArray array];
    
    [self getData];
    
    UIImageView *backimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
    backimage.frame=self.view.frame;
    backimage.userInteractionEnabled=YES;
    [self.view addSubview:backimage];
    
    UIButton *backbut=[[UIButton alloc]initWithFrame:CGRectMake(10, 30, 50, 60)];
    [backbut setImage:[UIImage imageNamed:@"z"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backimage addSubview:backbut];
    
    
    UIImageView *titleimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"个人成绩排行"]];
    titleimage.frame=CGRectMake((self.view.frame.size.width)/2-180, (self.view.frame.size.height)/2-330, 320, 50);
    [backimage addSubview:titleimage];
    
    _persontable=[[UITableView alloc]initWithFrame:CGRectMake(100, (self.view.frame.size.height)/2-120, self.view.frame.size.width-200, self.view.frame.size.height-350) style:UITableViewStylePlain];
    _persontable.delegate=self;
    _persontable.dataSource=self;
    

    
    frame=_persontable.frame;
    [backimage addSubview:_persontable];
    
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(100, (self.view.frame.size.height)/2-270, self.view.frame.size.width-200, 150)];
    headerView.backgroundColor=[UIColor colorWithRed:126/255.0 green:195/255.0 blue:201/255.0 alpha:1.0];
    
   
    
    _namelab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,headerView.frame.size.width/2 , 90)];
   
    _namelab.textColor=[UIColor whiteColor];
    _namelab.textAlignment=NSTextAlignmentCenter;
    _namelab.font=[UIFont systemFontOfSize:25];
    _namelab.backgroundColor=[UIColor colorWithRed:126/255.0  green:195/255.0  blue:201/255.0  alpha:1.0];
    [headerView addSubview:_namelab];
    
    
    UILabel *gradelab=[[UILabel alloc]initWithFrame:CGRectMake(headerView.frame.size.width/2, 0,headerView.frame.size.width/2 , 90)];
    gradelab.text=@"个人成绩";
    gradelab.textAlignment=NSTextAlignmentCenter;
    gradelab.font=[UIFont systemFontOfSize:25];
    gradelab.backgroundColor=[UIColor colorWithRed:126/255.0 green:195/255.0  blue:201/255.0  alpha:1.0];
    gradelab.textColor=[UIColor whiteColor];
    
    [headerView addSubview:gradelab];
    
    
    UILabel *prolab=[[UILabel alloc]initWithFrame:CGRectMake(0, 90,headerView.frame.size.width/3 , 60)];
    prolab.text=@"项目";
    prolab.textAlignment=NSTextAlignmentCenter;
    prolab.textColor=[UIColor blackColor];
    prolab.backgroundColor=[UIColor colorWithRed:248/255.0 green:195/255.0 blue:40/255.0 alpha:1.0];
    prolab.font=[UIFont systemFontOfSize:25];

    [headerView addSubview:prolab];
    
    
    UILabel *scorelab=[[UILabel alloc]initWithFrame:CGRectMake(headerView.frame.size.width/3, 90,headerView.frame.size.width/3 , 60)];
    scorelab.text=@"分数";
    scorelab.textAlignment=NSTextAlignmentCenter;
    scorelab.textColor=[UIColor blackColor];
    scorelab.font=[UIFont systemFontOfSize:25];
    scorelab.backgroundColor=[UIColor colorWithRed:254/255.0 green:224/255.0 blue:51/255.0 alpha:1.0];

    [headerView addSubview:scorelab];

    
    UILabel *timelab=[[UILabel alloc]initWithFrame:CGRectMake(2*headerView.frame.size.width/3, 90,headerView.frame.size.width/3 , 60)];
    timelab.text=@"时间";
    timelab.textAlignment=NSTextAlignmentCenter;
    timelab.textColor=[UIColor blackColor];
    timelab.font=[UIFont systemFontOfSize:25];
    timelab.backgroundColor=[UIColor colorWithRed:248/255.0 green:195/255.0 blue:40/255.0 alpha:1.0];

    [headerView addSubview:timelab];
    [backimage addSubview:headerView];
    
  
    _persontable.tableHeaderView.backgroundColor=[UIColor clearColor];
    _persontable.scrollEnabled =1;
    _persontable.contentSize=CGSizeMake(100, self.view.frame.size.height-400);

}

-(void)getData
{
    ViewController *vc=[[ViewController alloc]init];
    [vc setStutID:^(NSString *stuID){
    
        NSLog(@"%@",stuID);
        
        if (_stuID != nil) {
            stuID=_stuID;
        }
        
        [SVProgressHUD show];
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        
        [NetRequest PersonalRequestID:stuID Block:^(NSMutableArray *blockarry){
            
            [self.arry addObjectsFromArray:blockarry];
            
            
         //   NSLog(@"%@",self.arry);
            if (self.arry.count<1) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"成绩为空" message:@"请在参加考试后再进行查询" preferredStyle:  UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //点击按钮的响应事件；
                }]];
                
                //弹出提示框；
                [self presentViewController:alert animated:true completion:nil];

            }
            else
            {
            Model *model=self.arry[0];
            _namelab.text=[ NSString stringWithFormat:@"学生姓名:  %@",model.name];
            
            
            [self.persontable reloadData ];
            }
            
            [SVProgressHUD dismiss];
        } ];
    }];
    
   
   
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     [self.persontable reloadData ];
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arry.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (frame.size.height)/5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Model *model=self.arry[indexPath.row];
    
    return  [self setProjectname:model.scenicspotName Score:model.score  Time:model.testTime];


}

-(UITableViewCell *)setProjectname:(NSString *)name Score:(NSString *)score Time:(NSString *)time
{
    
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width/3, (frame.size.height-150)/5)];
    lab1.text=name;
    lab1.textAlignment=NSTextAlignmentCenter;
    lab1.font=[UIFont systemFontOfSize:23];
    [cell addSubview:lab1];
    
    
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/3, 0, frame.size.width/3, (frame.size.height-150)/5)];
    lab2.text=score;
    lab2.textAlignment=NSTextAlignmentCenter;
    lab2.font=[UIFont systemFontOfSize:23];
    [cell addSubview:lab2];
    
    
    UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/3*2, 0, frame.size.width/3, (frame.size.height-150)/5)];
    lab3.text=time;
    lab3.textAlignment=NSTextAlignmentCenter;
    lab3.font=[UIFont systemFontOfSize:23];
    [cell addSubview:lab3];
    
    return cell;

}

@end
