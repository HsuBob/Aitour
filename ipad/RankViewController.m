//
//  RankViewController.m
//  ipad
//
//  Created by xbo on 16/8/8.
//  Copyright © 2016年 xbo. All rights reserved.
//

#import "RankViewController.h"
#import "SVProgressHUD.h"
#import "NetRequest.h"
#import "Model.h"

@interface RankViewController()


@property(nonatomic,strong) UITableView *persontable;
@property(nonatomic,strong)  NSMutableArray *arry;
@end

static CGRect frame;
@implementation RankViewController

@synthesize persontable,arry;


-(void)viewWillAppear:(BOOL)animated
{
//    arry=[self setMySQL:@"武当山"];
    UIButton *but=[[UIButton alloc]init];
    but.tag=0;
    [self ranklist:but];
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
    
    
    UIImageView *titleimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cj"]];
    titleimage.frame=CGRectMake((self.view.frame.size.width)/2-180, (self.view.frame.size.height)/2-330, 320, 50);
    [backimage addSubview:titleimage];
    
    
    
    
    UIButton *lybut=[[UIButton alloc]initWithFrame:CGRectMake(70, (self.view.frame.size.height)/2-160, 100, 100)];
    
    [lybut setImage:[UIImage imageNamed:@"ly"] forState:UIControlStateNormal];
    [lybut addTarget:self action:@selector(ranklist:) forControlEvents:UIControlEventTouchUpInside];
    [backimage addSubview:lybut];
    
    lybut.tag=1;
    UIButton *wdsbut=[[UIButton alloc]initWithFrame:CGRectMake(70, (self.view.frame.size.height)/2-270,100, 100)];
    
    [wdsbut setImage:[UIImage imageNamed:@"wds"] forState:UIControlStateNormal];
    [wdsbut addTarget:self action:@selector(ranklist:) forControlEvents:UIControlEventTouchUpInside];
    [backimage addSubview:wdsbut];
    wdsbut.tag=0;
    
    UIButton *ggsbut=[[UIButton alloc]initWithFrame:CGRectMake(70, (self.view.frame.size.height)/2-50, 100, 100)];
    
    [ggsbut setImage:[UIImage imageNamed:@"gg"] forState:UIControlStateNormal];
    [ggsbut addTarget:self action:@selector(ranklist:) forControlEvents:UIControlEventTouchUpInside];
    ggsbut.tag=2;
    [backimage addSubview:ggsbut];
    
    
    UIButton *sxbut=[[UIButton alloc]initWithFrame:CGRectMake(70, (self.view.frame.size.height)/2+60, 100, 100)];
    [sxbut setImage:[UIImage imageNamed:@"sxrj"] forState:UIControlStateNormal];
    [sxbut addTarget:self action:@selector(ranklist:) forControlEvents:UIControlEventTouchUpInside];
    sxbut.tag=3;
    [backimage addSubview:sxbut];
    
    UIButton *ljbut=[[UIButton alloc]initWithFrame:CGRectMake(70, (self.view.frame.size.height)/2+170, 100, 100)];
    
    [ljbut setImage:[UIImage imageNamed:@"lj"] forState:UIControlStateNormal];
    [ljbut addTarget:self action:@selector(ranklist:) forControlEvents:UIControlEventTouchUpInside];
    ljbut.tag=4;
    [backimage addSubview:ljbut];
    

    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(180, (self.view.frame.size.height)/2-270, self.view.frame.size.width-280, 80)];
    headerView.backgroundColor=[UIColor colorWithRed:126/255.0 green:195/255.0 blue:201/255.0 alpha:1.0];

    
    
    persontable=[[UITableView alloc]initWithFrame:CGRectMake(180, (self.view.frame.size.height)/2-190, self.view.frame.size.width-280, self.view.frame.size.height-300) style:UITableViewStylePlain];
    persontable.delegate=self;
    persontable.dataSource=self;
    frame=persontable.frame;
    persontable.scrollEnabled=YES;
    persontable.showsVerticalScrollIndicator=0;
    [backimage addSubview:persontable];
    
    [headerView addSubview:[self setTitle:@"排行" Nframe:1]];
    [headerView addSubview:[self setTitle:@"姓名" Nframe:2]];
    [headerView addSubview:[self setTitle:@"分数" Nframe:3]];
    [headerView addSubview:[self setTitle:@"奖章" Nframe:4]];
    [headerView addSubview:[self setTitle:@"时间（分钟）" Nframe:5]];
    
    [backimage addSubview:headerView];
    

    
    
    


}
//-(NSMutableArray *)setMySQL:(NSString *)screenName
//{
//    
//    MySQLdb *db=[[MySQLdb alloc]init];
//    [db connectHost:@"192.168.1.26" connectPort:3356 connectUser:@"test1" connectPassword:@"123" connectDbName:@"test"];
//    NSMutableArray *arry1=[db query:[NSString stringWithFormat:@" select * from scoreganklist where scenicspotName='%@' order by score desc;",screenName]];
//    
//    
//    [db disconnect];
//    
////    NSLog(@"%@",arry1);
//    
//    return arry1;
//    
//}


-(void)ranklist:(UIButton *)sender
{
    
    [SVProgressHUD show];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    [NetRequest ProjectRequestTag:sender.tag Block:^(NSMutableArray *blockarry){
        
        arry=[NSMutableArray arrayWithArray:blockarry];
        [persontable reloadData ];
        [SVProgressHUD dismiss];
    } ];

    
//    
//    if (sender.tag==0) {
//        arry=[self setMySQL:@"武当山"];
//         [persontable reloadData ];
//        
//           }
//    if (sender.tag==1) {
//        arry=[self setMySQL:@"留园"];
//        [persontable reloadData ];
//    }
//    if (sender.tag==2) {
//        arry=[self setMySQL:@"故宫"];
//        [persontable reloadData ];
//    }
//    if (sender.tag==3) {
//        arry=[self setMySQL:@"三峡"];
//        [persontable reloadData ];
//    }
//    if (sender.tag==4) {
//        arry=[self setMySQL:@"丽江"];
//        [persontable reloadData ];
//    }



    
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
    return arry.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (frame.size.height-80)/5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    Model *model=arry[indexPath.row];
    if (indexPath.row==0) {
      
        return  [self setProjectname:model.name Score:model.score Time:model.testTime Rank:[ NSString stringWithFormat:@"%d",(int)(indexPath.row+1) ] Num:@"jinpai"];
    }
    if (indexPath.row==1) {
          return  [self setProjectname:model.name Score:model.score Time:model.testTime Rank:[ NSString stringWithFormat:@"%d",(int)(indexPath.row+1) ] Num:@"yingpai"];
    }
    if (indexPath.row==2) {
        return  [self setProjectname:model.name Score:model.score Time:model.testTime Rank:[ NSString stringWithFormat:@"%d",(int)(indexPath.row+1) ] Num:@"tongpai2"];
    }
    if (indexPath.row==3) {
        return  [self setProjectname:model.name Score:model.score Time:model.testTime Rank:[ NSString stringWithFormat:@"%d",(int)(indexPath.row+1) ] Num:@"tb"];
    }
    else {
         return  [self setProjectname:model.name Score:model.score Time:model.testTime Rank:[ NSString stringWithFormat:@"%d",(int)(indexPath.row+1) ] Num:@"tb"];
    }
}

-(UITableViewCell *)setProjectname:(NSString *)name Score:(NSString *)score Time:(NSString *)time
                              Rank:(NSString *)rank Num:(NSString *)num
{
    
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width/5, (frame.size.height-80)/5)];
    lab1.text=rank;
    lab1.textAlignment=NSTextAlignmentCenter;
    lab1.font=[UIFont systemFontOfSize:23];
    [cell addSubview:lab1];
    
    
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/5, 0, frame.size.width/5, (frame.size.height-80)/5)];
    lab2.text=name;
//    lab2.backgroundColor=[UIColor blueColor];
    lab2.textAlignment=NSTextAlignmentCenter;
    lab2.font=[UIFont systemFontOfSize:23];
    [cell addSubview:lab2];
    
    
    UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/5*2, 0, frame.size.width/5, (frame.size.height-80)/5)];
    lab3.text=score;
    lab3.textAlignment=NSTextAlignmentCenter;
    lab3.font=[UIFont systemFontOfSize:23];
    [cell addSubview:lab3];
    
    UILabel *lab4=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/5*3, 0, frame.size.width/5, (frame.size.height-80)/5)];
    lab4.textAlignment=NSTextAlignmentCenter;
    lab4.font=[UIFont systemFontOfSize:23];
    
    UIImageView *tbimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:num]];
    tbimage.frame=CGRectMake(frame.size.width/5/2-20, 30, 30, 30);
    [lab4 addSubview:tbimage];
    [cell addSubview:lab4];
    
    UILabel *lab5=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/5*4-25, 0, frame.size.width/5, (frame.size.height-80)/5)];
    lab5.text=time;
    lab5.textAlignment=NSTextAlignmentCenter;
    lab5.font=[UIFont systemFontOfSize:14];
    [cell addSubview:lab5];
    
    return cell;
    
}
-(UILabel *)setTitle:(NSString *)name Nframe:(NSInteger) n
{
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake((n-1)*frame.size.width/5, 0, frame.size.width/5, 80)];
    lab1.text=name;
    lab1.textAlignment=NSTextAlignmentCenter;
    lab1.font=[UIFont systemFontOfSize:23];

    
    return lab1;
}

@end
