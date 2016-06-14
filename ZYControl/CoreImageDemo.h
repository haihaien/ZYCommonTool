//
//  Core ImageDemo.h
//  ZYControl
//
//  Created by LeMo-test on 16/6/14.
//  Copyright © 2016年 LeMo-test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum ImageType{
    MOSAIC    =0,//马晒客
    QRCode    =1,  //二维码
    GRcOLOR   =2
    
}imagetype;

@interface CoreImageDemo : NSObject
-(CIFilter*)CreatTypeWithImageType:(imagetype*)type WithImage:(UIImage*)image;
@end
