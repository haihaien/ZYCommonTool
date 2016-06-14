//
//  ZYSlide.m
//  ZYControl
//
//  Created by LeMo-test on 16/6/13.
//  Copyright © 2016年 LeMo-test. All rights reserved.
//

#import "ZYSlide.h"
#define ZYSlideHight ((self.bounds.size.height)*0.5)
#define ZYTitleHight ((self.bounds.size.height)*0.5)
#define ZYBordWidth   2
#define ZYSPACE      10
#define ZYWight      (self.bounds.size.width)
#define ZYLABLEFONT(F) [UIFont systemFontOfSize:(F)]
@interface ZYSlide()
@property (nonatomic, strong) NSMutableArray *titleLableArry;
@property (nonatomic, strong) UIImageView    *thumImageView;
@property (nonatomic, assign) CGFloat        point_x;
@property (nonatomic, assign) NSInteger      section;
@property (nonatomic, assign) NSInteger      sectionIndex;

@end
@implementation ZYSlide
{
    BOOL     _HaveTitleColor;
    UIColor  *_titlecolor;//标题颜色
    UIColor  *_seletedTitleColor;//选择标题颜色
}
-(UIImageView *)thumImageView
{
    if (!_thumImageView) {
        _thumImageView = [[UIImageView alloc] init];
        [self addSubview:_thumImageView];
    }
    return _thumImageView;

}
-(NSMutableArray *)titleLableArry
{
    if (!_titleLableArry) {
        _titleLableArry = [NSMutableArray array];
    }
    return _titleLableArry;

}

-(instancetype)initWithFrame:(CGRect)frame WithAnimation:(Animationtype)animationtype
{
    if (frame.size.height > frame.size.width) {
        frame.size.height = frame.size.width;
    }
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        _animationtype = animationtype;
        _point_x = 0;
        _section = 6;
        _trackTintColor = [UIColor grayColor];
        //        [self.thumImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //         make.center.mas_equalTo(CGPointMake(0, ZYTitleHight-ZYSlideHight/2));
        //            make.size.mas_equalTo(CGSizeMake(ZYSlideHight, ZYSlideHight));
        //            }];
        self.thumImageView.frame = CGRectMake(0, 0, ZYSlideHight, ZYSlideHight);
        self.thumImageView.center = CGPointMake(self.point_x+ZYSPACE, ZYSlideHight/2 + ZYTitleHight);
        self.thumImageView.layer.cornerRadius = ZYSlideHight/2;
        self.thumImageView.layer.masksToBounds = YES;
        self.thumImageView.backgroundColor=_trackTintColor;
        
    }
    return self;

}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self.trackTintColor setStroke];
    
    CGContextRef context  = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, ZYBordWidth);
    CGContextMoveToPoint(context, ZYSPACE, ZYSlideHight/2 + ZYTitleHight);
    CGContextAddLineToPoint(context, ZYWight-ZYSPACE, ZYSlideHight/2 + ZYTitleHight);
    CGContextStrokePath(context);
    for (int i =0; i<_section; i++) {
    CGContextSetLineWidth(context, ZYBordWidth);
    CGContextMoveToPoint(context, ZYSPACE+i*((ZYWight-2*ZYSPACE)/(_section-1)), ZYTitleHight);
    CGContextAddLineToPoint(context, ZYSPACE+i*((ZYWight-2*ZYSPACE)/(_section-1)), ZYSlideHight/2 + ZYTitleHight);
    CGContextStrokePath(context);
    }
}

-(void)setTitleArry:(NSMutableArray *)titleArry
{
    if (titleArry) {
       NSMutableArray *newTitleArry = [titleArry mutableCopy];
    if (titleArry.count<_section) {
        for (NSInteger i=_section-titleArry.count-1;i<_section; i++) {
            [newTitleArry addObject:@""];
        }
    }
        _section = titleArry.count;
        for (int i=0; i<_section; i++) {
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (ZYWight-2*ZYSPACE)/(_section-1), ZYTitleHight)];
            lable.text = newTitleArry[i];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font = ZYLABLEFONT(10);
            lable.center = CGPointMake(ZYSPACE+i*((ZYWight-2*ZYSPACE)/(_section-1)), ZYTitleHight/2);
                [self.titleLableArry addObject:lable];
            [self addSubview:lable];
            
        }
 
        [self setAnimation];
 }
        
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self changeThumPositionWithPoint_x:touch];
    [self refreshSlide];
    return YES;

}
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self changeThumPositionWithPoint_x:touch];
    [self refreshSlide];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return self;

}
-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{

    [self changeThumPositionWithPoint_x:touch];
    [self refreshSlide];

}
-(void)refreshSlide
{
     self.thumImageView.center = CGPointMake(self.point_x+ZYSPACE, ZYSlideHight/2 + ZYTitleHight);
    [self setAnimation];
}
-(void)changeThumPositionWithPoint_x:(UITouch*)touch
{

    CGPoint location = [touch locationInView:self];
    if (location.x<ZYSPACE) {
        self.point_x = 0;
    }else if (location.x>ZYWight-2*ZYSPACE)
    {
        self.point_x = ZYWight-2*ZYSPACE;
    
    }else{
        self.point_x = location.x-ZYSPACE;
    
    }
 _sectionIndex = (_point_x-2*ZYSPACE)/((ZYWight-2*ZYSPACE)/_section);
    if (self.delegate &&[self.delegate respondsToSelector:@selector(ZYSlideView:WithChangeValue:)]) {
        [self.delegate ZYSlideView:self WithChangeValue:self.point_x/(ZYWight-2*ZYSPACE)];
    }

}

-(void)setProgress:(CGFloat)progress
{
    if (progress>1) {
        _progress = 1;
    }
    if (progress<0) {
        _progress = 0;
    }
    _point_x = _progress*(ZYWight - 2*ZYSPACE);
    _sectionIndex = (_point_x-2*ZYSPACE)/((ZYWight-2*ZYSPACE)/_section);
    [self refreshSlide];


}
-(void)setAnimation{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if (self.animationtype == JumpAnimation) {
        for (int i =0; i<_section; i++) {
            UILabel *label = (UILabel *)self.titleLableArry[i];
            
            if (i ==_sectionIndex) {
               [self.titleLableArry[i] setCenter:CGPointMake(ZYSPACE+i*((ZYWight-2*ZYSPACE)/(_section-1)), ZYTitleHight/4)];
                if (_HaveTitleColor) {
                    label.textColor=_seletedTitleColor;
                }
            }else{
              [self.titleLableArry[i] setCenter:CGPointMake(ZYSPACE+i*((ZYWight-2*ZYSPACE)/(_section-1)), ZYTitleHight/2)];
                if (_HaveTitleColor) {
                    label.textColor=_titlecolor;
                }
            }
        }
    }else if (self.animationtype == ZoomAnimation){
        for (int i =0; i<_section; i++) {
            UILabel *label = (UILabel *)self.titleLableArry[i];
            
            if (i ==_sectionIndex) {
                label.font = ZYLABLEFONT(15);
                if (_HaveTitleColor) {
                    label.textColor=_seletedTitleColor;
                }
            }else{
                label.font = ZYLABLEFONT(10);

                if (_HaveTitleColor) {
                    label.textColor=_titlecolor;
                }
            }
        }
    
    }else if (self.animationtype ==ShowAndHide)
    {
        for (int i =0; i<_section; i++) {
            UILabel *label = (UILabel *)self.titleLableArry[i];
            
            if (i ==_sectionIndex) {
                label.hidden = NO;
                if (_HaveTitleColor) {
                    label.textColor=_seletedTitleColor;
                }
            }else{
                label.hidden = YES;
                if (_HaveTitleColor) {
                    label.textColor=_titlecolor;
                }
            }
        }
    
    }
    [UIView commitAnimations];


}



-(void)settitleColor:(UIColor *)titileColor WithSelectedColor:(UIColor *)selectedColor
{
    _HaveTitleColor    = YES;
    _titlecolor        = titileColor;
    _seletedTitleColor = selectedColor;


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
