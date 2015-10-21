//
//  UtilOjbC.m
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

#import "UtilOjbC.h"

@implementation UtilOjbC
+(BOOL) IsValidEmail:(NSString *)email_address
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email_address];
}

+(BOOL) IsValidPassword:(NSString *)pwd{

    NSCharacterSet *upperCaseChars = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLKMNOPQRSTUVWXYZ"];
    NSCharacterSet *lowerCaseChars = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz"];
    
    //NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    if ( [pwd length]<6 || [pwd length]>20 )
        return NO;  // too long or too short
    NSRange rang;
    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    if ( !rang.length )
        return NO;  // no letter
    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
    if ( !rang.length )
        return NO;  // no number;
    rang = [pwd rangeOfCharacterFromSet:upperCaseChars];
    if ( !rang.length )
        return NO;  // no uppercase letter;
    rang = [pwd rangeOfCharacterFromSet:lowerCaseChars];
    if ( !rang.length )
        return NO;  // no lowerCase Chars;
    return YES;
}

+ (NSString *)encodeToBase64String:(UIImage *)image {
    NSString *img=[UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSLog(@"image %@", img);
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

+(NSString*)encodeBase64CodeFormImage:(UIImage *)img
{
    
    NSData *imagedata = UIImagePNGRepresentation(img);
    NSString *base64String = [imagedata base64EncodedStringWithOptions:0];
    
    
    return base64String;
}

// Encode NSString from NSData object in Base64
+ (NSString*) UTF8EncodingBase64String:(NSString *) strValue
{
    NSData *nsdata = [strValue dataUsingEncoding:NSUTF8StringEncoding];
    return [nsdata base64EncodedStringWithOptions:0];
}

// Decoded NSString from the NSData
+ (NSString*) UTF8DecodingBase64String:(NSString *) strValue
{
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:strValue options:0];
    return [[NSString alloc]
            initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
}


@end
