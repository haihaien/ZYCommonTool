//
//  Core ImageDemo.m
//  ZYControl
//
//  Created by LeMo-test on 16/6/14.
//  Copyright © 2016年 LeMo-test. All rights reserved.
//

#import "CoreImageDemo.h"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation CoreImageDemo
{


}
-(CIFilter *)CreatTypeWithImageType:(imagetype *)type WithImage:(UIImage *)image
{
//1.core image 主要有三个类1.CIImage 他是保存图片数据的类  CIFilter 主要的滤镜处理 CIContext 上下文(OpenGL 上下文和 Core Image 上下文之间共享资源，我们需要用一个稍微不同的方式来创建我们的 CIContext：)主要可以用GPU渲染硬件加速 ,当然我们可以直接用输出的过滤后的图片加在image上 不过那样我们用imageView显示时设置contentModel的话会出问题 下面有涉及到
    if (type == MOSAIC) {
        return [self creatMASAICwithImage:image];
    }else if (type == QRCode){
    return [self Creat2dBarcode:image];
    }
    return [self createGrayscale:image];

}
/**
 生成马赛克
 */
-(CIFilter*)creatMASAICwithImage:(UIImage *)image
{
    CIFilter *filter = [CIFilter filterWithName:@"CIPixellate"];
  [filter setDefaults];
    //创建滤镜时候是更具名字来的 可以查看api文档查看客相关的效果
    //2.创建一个CIImage对象来进行滤镜处理
    CIImage *originalImage = [CIImage imageWithCGImage:image.CGImage];
    //3.设置滤镜处理的相关参数(如果不想看api文档)可以用CIFilter的inputKeys 和outPutKeys来打印参数名称(是一个字符串类型的数组),,因为滤镜处理是kvc所以我们需要key
    [filter setValue:@(10.0) forKey:@"inputScale"];
    [filter setValue:originalImage forKey:@"inputImage"];
    CIVector *vec = [CIVector vectorWithX:50 Y:50];
    [filter setValue:vec forKey:@"inputCenter"];
    return filter;

}

/**
 二维码
 */
-(CIFilter*)Creat2dBarcode:(UIImage*)image
{
    CIFilter *filte = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filte setDefaults];
    NSString *str = @"http://www.baidu.com";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    // 使用KVO设置属性
    [filte setValue:data forKey:@"inputMessage"];
    NSString *st = @"H";
    [filte setValue:st forKey:@"inputCorrectionLevel"];
    return filte;


}
/**
 暗度
 */

-(CIFilter*)createGrayscale:(UIImage*)image
{
    CIFilter *fiter = [CIFilter filterWithName:@"CIColorClamp"];
    [fiter setDefaults];
    CIImage *originalImage = [CIImage imageWithCGImage:image.CGImage];
    [fiter setValue:originalImage forKey:@"inputImage"];
//        CIVector *minvec = [CIVector vectorWithX:0 Y:0 Z:1 W:1];
//     CIVector *maxvec = [CIVector vectorWithX:1 Y:1 Z:1 W:1];
//    [fiter setValue:minvec forKey:@"inputMinComponents"];
//    [fiter setValue:maxvec forKey:@"inputMaxComponents"];
   
    return fiter;

}





@end
