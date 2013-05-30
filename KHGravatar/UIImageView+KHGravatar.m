// UIImageView+KHGravatar.h
//
// Copyright (c) 2012 Kevin Harwood 
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

#import "UIImageView+KHGravatar.h"
#import "UIImageView+AFNetworking.h"
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
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    NSString* md5EmailAddress =  [NSString stringWithFormat:
                                  @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                                  result[0], result[1], result[2], result[3], 
                                  result[4], result[5], result[6], result[7],
                                  result[8], result[9], result[10], result[11],
                                  result[12], result[13], result[14], result[15]
                                  ]; 
    return [md5EmailAddress lowercaseString];
}

@interface UIImageView (_KHGravatar)

- (NSURL*)gravatarURLForEmailAddress:(NSString*)emailAddress;
- (NSURL*)gravatarURLForEmailAddress:(NSString*)emailAddress defaultImageType:(KHGravatarDefaultImage)defaultImageType rating:(KHGravatarRating)rating;
- (NSURL*)gravatarURLForEmailAddress:(NSString*)emailAddress defaultImageURL:(NSURL*)defaultImageURL rating:(KHGravatarRating)rating;
- (CGFloat)imageSize;

-(NSString*)ratingStringForRating:(KHGravatarRating)rating;

@end

@implementation UIImageView (KHGravatar)


- (void)setImageWithGravatarEmailAddress:(NSString*)emailAddress{
    [self setImageWithURL:[self gravatarURLForEmailAddress:emailAddress]];
}


- (void)setImageWithGravatarEmailAddress:(NSString*)emailAddress placeholderImage:(UIImage*)placeholderImage{
    [self setImageWithURL:[self gravatarURLForEmailAddress:emailAddress] placeholderImage:placeholderImage];
}

- (void)setImageWithGravatarEmailAddress:(NSString*)emailAddress placeholderImage:(UIImage*)placeholderImage defaultImageType:(KHGravatarDefaultImage)defaultImageType rating:(KHGravatarRating)rating{
    [self setImageWithURL:[self gravatarURLForEmailAddress:emailAddress defaultImageType:defaultImageType rating:rating] placeholderImage:placeholderImage];
}

- (void)setImageWithGravatarEmailAddress:(NSString*)emailAddress 
                        placeholderImage:(UIImage*)placeholderImage
                         defaultImageURL:(NSURL*)defaultImageURL
                                  rating:(KHGravatarRating)rating{
    [self setImageWithURL:[self gravatarURLForEmailAddress:emailAddress defaultImageURL:defaultImageURL rating:rating] placeholderImage:placeholderImage];
}


- (void)setImageWithGravatarEmailAddress:(NSString*)emailAddress 
                        placeholderImage:(UIImage *)placeholderImage 
                        defaultImageType:(KHGravatarDefaultImage)defaultImageType
                                  rating:(KHGravatarRating)rating
                                 success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                                 failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure{
    [self setImageWithURLRequest:[NSURLRequest requestWithURL:[self gravatarURLForEmailAddress:emailAddress defaultImageType:defaultImageType rating:rating]]
                placeholderImage:placeholderImage
                         success:success
                         failure:failure];
}

#pragma mark - Private
- (NSURL*)gravatarURLForEmailAddress:(NSString*)emailAddress{
    return [self gravatarURLForEmailAddress:emailAddress defaultImageType:KHGravatarDefaultImageDefault rating:KHGravatarRatingG];
}

- (NSURL*)gravatarURLForEmailAddress:(NSString*)emailAddress defaultImageType:(KHGravatarDefaultImage)defaultImageType rating:(KHGravatarRating)rating{
    NSString *emailHash = KHGravatarHashForEmailAddress(emailAddress);
    NSString * urlString = [NSString stringWithFormat:@"%@%@.png?s=%0.0f",KHGravatarBaseURLString,emailHash,[self imageSize]];
    
    if(defaultImageType!=KHGravatarDefaultImageDefault){
        NSString * type = nil;
        switch (defaultImageType) {
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
        if(type){
            urlString = [urlString stringByAppendingFormat:@"&d=%@",type];
        }
    }
    
    NSString * ratingString = [self ratingStringForRating:rating];
    if(ratingString){
        urlString = [urlString stringByAppendingFormat:@"&r=%@",ratingString];
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

- (NSURL*)gravatarURLForEmailAddress:(NSString*)emailAddress defaultImageURL:(NSURL*)defaultImageURL rating:(KHGravatarRating)rating{
    NSString *emailHash = KHGravatarHashForEmailAddress(emailAddress);
    NSString * urlString = [NSString stringWithFormat:@"%@%@.png?s=%0.0f",KHGravatarBaseURLString,emailHash,[self imageSize]];
    
    urlString = [urlString stringByAppendingFormat:@"&d=%@",[defaultImageURL absoluteString]];

    NSString * ratingString = [self ratingStringForRating:rating];
    if(ratingString){
        urlString = [urlString stringByAppendingFormat:@"&r=%@",ratingString];
    }

    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

- (CGFloat)imageSize{
    CGFloat imageSize = [[UIScreen mainScreen] scale] * MAX(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds));
    return MIN(imageSize,512);
}

-(NSString*)ratingStringForRating:(KHGravatarRating)rating{
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

@end
