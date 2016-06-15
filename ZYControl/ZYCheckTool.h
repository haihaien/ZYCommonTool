//
//  ZYCheckTool.h
//  ZYControl
//
//  Created by LeMo-test on 16/6/15.
//  Copyright © 2016年 LeMo-test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCheckTool : NSObject
/**
 验证邮箱
 */
+(BOOL)checkForEmail:(NSString*)email;
/**
 验证手机号
 */
+(BOOL)checkForMobilePhoneNum:(NSString*)mobilePhone;
/**
 验证电话
 */

+(BOOL)checkForPhoneNum:(NSString*)Phone;
/**
 验证生分证号
 */
+(BOOL)checkForIdCard:(NSString*)idCard;
/**
 验证密码
 */
+(BOOL)checkForPasswordWithShortest:(NSInteger)shortest longest:(NSInteger)longest password:(NSString *)pwd;
/**
 验证由数字和26个英语组成的字符串
 */

+ (BOOL) checkForNumberAndCase:(NSString *)data;
/**
 *  校验只能输入26位大写字母
 *
 *  @param data 数据
 *
 *  @return 结果
 */
+ (BOOL) checkForUpperCase:(NSString *)data;

/**
 *  校验只能输入由26个小写英文字母组成的字符串
 *
 *  @param data 字符串
 *
 *  @return 结果
 */
+ (BOOL) checkForLowerAndUpperCase:(NSString *)data;

/**
 *  是否含有特殊字符(%&’,;=?$\等)
 *
 *  @param data 数据
 *
 *  @return 结果
 */
+ (BOOL) checkForSpecialChar:(NSString *)data;


/**
 *  校验只能输入数字
 *
 *  @param number 数字
 *
 *  @return 结果
 */
+ (BOOL) checkForNumber:(NSString *)number;

/**
 *  校验只能输入n位的数字
 *
 *  @param length n位
 *  @param number 数字
 *
 *  @return 结果
 */
+ (BOOL) checkForNumberWithLength:(NSString *)length number:(NSString *)number;

@end
