//
//  ViewController.m
//  ZYControl
//
//  Created by LeMo-test on 16/6/13.
//  Copyright © 2016年 LeMo-test. All rights reserved.
//

#import "ViewController.h"
#import "ZYSlide.h"
#import "CoreImageViewController.h"
@interface ViewController ()<ZYSlideDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZYSlide *ZY = [[ZYSlide alloc] initWithFrame:CGRectMake(10, 100, 300, 30) WithAnimation:0];
    ZY.delegate=self;
    ZY.titleArry = [@[@"小",@"中",@"大",@"特大"]mutableCopy];
    [self.view addSubview:ZY];

    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)ZYSlideView:(ZYSlide *)zyslide WithChangeValue:(CGFloat)currentValue
{
    NSLog(@"%f",currentValue);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
