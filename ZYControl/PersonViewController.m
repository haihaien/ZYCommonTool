//
//  PersonViewController.m
//  ZYControl
//
//  Created by LeMo-test on 16/6/15.
//  Copyright © 2016年 LeMo-test. All rights reserved.
//

#import "PersonViewController.h"

@interface PersonViewController ()
@property (weak, nonatomic) IBOutlet UIButton *authCodeBtn;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)ButAction:(UIButton*)sender {
    //按钮的type custem是秒到 其他是闪烁
    __block NSInteger time = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _souce = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_souce, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_souce, ^{
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_souce);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.authCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                
                self.authCodeBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.authCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                
                self.authCodeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
 
    dispatch_resume(_souce);
    
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
