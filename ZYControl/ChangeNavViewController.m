//
//  ChangeNavViewController.m
//  ZYControl
//
//  Created by LeMo-test on 16/6/14.
//  Copyright © 2016年 LeMo-test. All rights reserved.
//

#import "ChangeNavViewController.h"
#define UIColorWithRGBA(r,g,b,a)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
@interface ChangeNavViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ChangeNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"kk"];
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    lable.text = @"首页";
    lable.font = [UIFont systemFontOfSize:16];
    lable.alpha = 0;
    
    lable.textAlignment = NSTextAlignmentCenter;
    
    
    self.navigationItem.titleView=lable;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kk"];
    return cell;


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self .navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:UIColorWithRGBA(255, 255, 255, self.tableview.contentOffset.y/100)] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView.alpha=self.tableview.contentOffset.y/100;
}

- (UIImage*)imageWithBgColor:(UIColor *)color
{
    
    CGRect rect=CGRectMake(0, 0,1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
    
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
