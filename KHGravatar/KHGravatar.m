//
//  KHGravatar.m
//
// Copyright (c) 2013 Kevin Harwood
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "KHGravatar.h"
#import <CommonCrypto/CommonDigest.h>

NSString * const KHGravatarBaseURLString = @"https://secure.gravatar.com/avatar/";

static NSString * KHGravatarHashForEmailAddress(NSString *emailAddress) {
    if (!emailAddress || [emailAddress isEqual:[NSNull null]]) {
        // if a nil or null string is passed in, hash will crash
        return @"";
    }
    emailAddress = [emailAddress stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    emailAddress = [emailAddress lowercaseString];

    const char *cStr = [emailAddress UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    NSString* md5EmailAddress =  [NSString stringWithFormat:
                                  @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                                  result[0], result[1], result[2], result[3],
                                  result[4], result[5], result[6], result[7],
                                  result[8], result[9], result[10], result[11],
                                  result[12], result[13], result[14], result[15]
                                  ];
    return md5EmailAddress;
}

static NSString * KHRatingStringForRating(KHGravatarRating rating){
    NSString * ratingString = nil;
    switch (rating) {
        case KHGravatarRatingG:
            ratingString = @"g";
            break;
        case KHGravatarRatingPG:
            ratingString = @"pg";
            break;
        case KHGravatarRatingR:
            ratingString = @"r";
            break;
        case KHGravatarRatingX:
            ratingString = @"x";
        default:
            break;
    }
    return ratingString;
}

static NSString * KHImageStringForImageType(KHGravatarDefaultImage imageType){
    NSString * type = nil;
    switch (imageType) {
        case KHGravatarDefaultImage404:
            type = @"404";
            break;
        case KHGravatarDefaultImageMysteryMan:
            type = @"mm";
            break;
        case KHGravatarDefaultImageIdenticon:
            type = @"identicon";
            break;
        case KHGravatarDefaultImageMonsterId:
            type = @"monsterid";
            break;
        case KHGravatarDefaultImageWavatar:
            type = @"wavatar";
            break;
        case KHGravatarDefaultImageRetro:
            type = @"retro";
            break;
        default:
            break;
    }
    return type;
}

static NSURL * KHBuildURL(NSString * emailAddress, NSDictionary * parameters){
    NSString *emailHash = KHGravatarHashForEmailAddress(emailAddress);
    __block NSString *urlString = [NSString stringWithFormat:@"%@%@.png",KHGravatarBaseURLString,emailHash];

    //Build out the parameters
    __block NSInteger counter = 0;
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *seperator = (counter==0?@"?":@"&");
        urlString = [urlString stringByAppendingFormat:@"%@%@=%@",seperator,key,obj];
        counter++;
    }];
    
    return [NSURL URLWithString:urlString];
}

@implementation KHGravatar

+ (NSURL *)URLForGravatarEmailAddress:(NSString*)emailAddress;{
    return KHBuildURL(emailAddress, nil);
}

+ (NSURL *)URLForGravatarEmailAddress:(NSString*)emailAddress
                     defaultImageType:(KHGravatarDefaultImage)defaultImageType
                         forceDefault:(BOOL)forceDefault
                               rating:(KHGravatarRating)rating
                                 size:(CGFloat)size{
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    if(size>=0){
        [parameters setValue:[NSString stringWithFormat:@"%0.0f",size] forKey:@"s"];
    }
    
    NSString * type = KHImageStringForImageType(defaultImageType);
    if(type){
        [parameters setValue:type forKey:@"d"];
    }
    
    if(forceDefault){
        [parameters setValue:@"y" forKey:@"f"];
    }
    
    NSString * ratingString = KHRatingStringForRating(rating);
    if(ratingString){
        [parameters setValue:ratingString forKey:@"r"];
    }
    
    return KHBuildURL(emailAddress, parameters);
    
}

+ (NSURL *)URLForGravatarEmailAddress:(NSString*)emailAddress
                      defaultImageURL:(NSURL*)defaultImageURL
                         forceDefault:(BOOL)forceDefault
                               rating:(KHGravatarRating)rating
                                 size:(CGFloat)size{
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    if(size>=0){
        [parameters setValue:[NSString stringWithFormat:@"%0.0f",size] forKey:@"s"];
    }
    
    if(defaultImageURL){
        [parameters setValue:defaultImageURL.absoluteString forKey:@"d"];
    }
    
    if(forceDefault){
        [parameters setValue:@"y" forKey:@"f"];
    }
    
    NSString * ratingString = KHRatingStringForRating(rating);
    if(ratingString){
        [parameters setValue:ratingString forKey:@"r"];
    }
    
    return KHBuildURL(emailAddress, parameters);

}

@end
