//
//  ZYSlide.h
//  ZYControl
//
//  Created by LeMo-test on 16/6/13.
//  Copyright © 2016年 LeMo-test. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYSlide;
@protocol ZYSlideDelegate <NSObject>

-(void)ZYSlideView:(ZYSlide*)zyslide WithChangeValue:(CGFloat)currentValue;

@end
typedef enum AnimationType
{
JumpAnimation = 0,//跳跃
ZoomAnimation = 1,//缩放
ShowAndHide = 2//显示和影藏
    
}Animationtype;
@interface ZYSlide : UIControl
/**
 tintColor
 */
@property (nonatomic, strong) UIColor * trackTintColor;
/**
 ThumbColor
 */
@property (nonatomic, strong) UIColor * thumbColor;
/**
 ThumbImage
 */
@property (nonatomic, strong) UIImage * thumbImage;
/**
 上面的标题
 */
@property (nonatomic, strong) NSMutableArray * titleArry;
/**
 设置值
 */
@property (nonatomic, assign) CGFloat progress;
/**
动画类型
 */
@property (nonatomic, assign) Animationtype animationtype;

/**
代理 */
@property (nonatomic, assign) id<ZYSlideDelegate> delegate;


/**
设置上面标题的选择和正常颜色 */
-(void)settitleColor:(UIColor*)titileColor WithSelectedColor:(UIColor*)selectedColor;
/**
初始化方法 */
-(instancetype)initWithFrame:(CGRect)frame WithAnimation:(Animationtype)animationtype;
@end
