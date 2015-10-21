//
//  UtilOjbC.h
//  AllerPal

/*
 * [...]
 * @project:  AllerPal
 * @version: 1.0
 * @since:   swift 2.0
 * @Created: by Ngo Hoai Duc on 6/4/15 All rights reserved.
 * @Developer: Ngo Hoai Duc
 * @Email: ducngo@innoria.com
 * @Skype: ngohoaiduc
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UtilOjbC : NSObject
+(BOOL) IsValidEmail:(NSString *)email_address;
+(BOOL) IsValidPassword:(NSString *)pwd;

+ (NSString *)encodeToBase64String:(UIImage *)image;
+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;
+ (NSString*) UTF8EncodingBase64String:(NSString *) strValue;
+ (NSString*) UTF8DecodingBase64String:(NSString *) strValue;

@end
