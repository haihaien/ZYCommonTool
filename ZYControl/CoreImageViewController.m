//
//  CoreImageViewController.m
//  ZYControl
//
//  Created by LeMo-test on 16/6/14.
//  Copyright © 2016年 LeMo-test. All rights reserved.
//

#import "CoreImageViewController.h"
#import "CoreImageDemo.h"
#import "ScanViewController.h"
@interface CoreImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *OriginalImageView;

@property (weak, nonatomic) IBOutlet UIImageView *NewImageView;
@end

@implementation CoreImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.OriginalImageView.image = [UIImage imageNamed:@"aa.jpg"];


    // Do any additional setup after loading the view.
}
- (IBAction)ButAction:(UIButton *)sender {
    CoreImageDemo *core = [[CoreImageDemo alloc] init];
    CIFilter *fiter =  [core CreatTypeWithImageType:sender.tag WithImage:[UIImage imageNamed:@"aa.jpg"]];
        //1.返回的CIFilte直接去outputImage 然后显示(但是这样设置contentModel时候有问题)
//    CIImage *outImage = [fiter valueForKey:@"outputImage"];
//    self.NewImageView.image = [UIImage imageWithCIImage:outImage];
    //2用上下文(底一种我们在cpu上面渲染直接印CIContent..但是那样很好时和浪费资源(因为去Core Graphics逛了一圈))
    //2中我们使用OpenGl来提高性能(OpenGl和Core Image可以互相操作)
    EAGLContext *OPContent = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    CIContext *content = [CIContext contextWithEAGLContext:OPContent];
//    CIContext *content = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [content createCGImage:fiter.outputImage fromRect:fiter.outputImage.extent];
//   [content drawImage:fiter.outputImage inRect:fiter.outputImage.extent fromRect:fiter.outputImage.extent];
 
//    self.NewImageView.image = [UIImage imageWithCGImage:imageRef];
    if (sender.tag==1) {
        UIImage *image = [self createNonInterpolatedUIImageFormCIImage:fiter.outputImage withSize:100];
        self.NewImageView.image = image;
    }else{
    self.NewImageView.image = [UIImage imageWithCGImage:imageRef];
    
    }
    
    
}
- (IBAction)Scan:(UIButton *)sender {
    ScanViewController *scan = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:scan animated:YES];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
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
