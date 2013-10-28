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

@interface UIImageView (_KHGravatar)


@end

@implementation UIImageView (KHGravatar)


- (void)setImageWithGravatarEmailAddress:(NSString*)emailAddress{
    [self setImageWithGravatarEmailAddress:emailAddress
                          placeholderImage:nil
                          defaultImageType:KHGravatarDefaultImageDefault
                              forceDefault:NO
                                    rating:KHGravatarRatingG];
}


- (void)setImageWithGravatarEmailAddress:(NSString*)emailAddress placeholderImage:(UIImage*)placeholderImage{
    [self setImageWithGravatarEmailAddress:emailAddress
                          placeholderImage:placeholderImage
                          defaultImageType:KHGravatarDefaultImageDefault
                              forceDefault:NO
                                    rating:KHGravatarRatingG];
}

- (void)setImageWithGravatarEmailAddress:(NSString*)emailAddress
                        placeholderImage:(UIImage*)placeholderImage
                        defaultImageType:(KHGravatarDefaultImage)defaultImageType
                            forceDefault:(BOOL)forceDefault
                                  rating:(KHGravatarRating)rating{
    NSURL * url = [KHGravatar URLForGravatarEmailAddress:emailAddress
                                        defaultImageType:defaultImageType
                                            forceDefault:forceDefault
                                                  rating:rating
                                                    size:[self imageSize]];
    [self setImageWithURL:url placeholderImage:placeholderImage];
}

- (void)setImageWithGravatarEmailAddress:(NSString*)emailAddress 
                        placeholderImage:(UIImage*)placeholderImage
                         defaultImageURL:(NSURL*)defaultImageURL
                            forceDefault:(BOOL)forceDefault
                                  rating:(KHGravatarRating)rating{
    NSURL * url = [KHGravatar URLForGravatarEmailAddress:emailAddress
                                         defaultImageURL:defaultImageURL
                                            forceDefault:forceDefault
                                                  rating:rating
                                                    size:[self imageSize]];
    [self setImageWithURL:url placeholderImage:placeholderImage];
}


- (void)setImageWithGravatarEmailAddress:(NSString*)emailAddress 
                        placeholderImage:(UIImage *)placeholderImage 
                        defaultImageType:(KHGravatarDefaultImage)defaultImageType
                            forceDefault:(BOOL)forceDefault
                                  rating:(KHGravatarRating)rating
                                 success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                                 failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure{
    NSURL * url = [KHGravatar URLForGravatarEmailAddress:emailAddress
                                        defaultImageType:defaultImageType
                                            forceDefault:forceDefault
                                                  rating:rating
                                                    size:[self imageSize]];
    [self setImageWithURLRequest:[NSURLRequest requestWithURL:url]
                placeholderImage:placeholderImage
                         success:success
                         failure:failure];
}

#pragma mark - Private

- (CGFloat)imageSize{
    CGFloat imageSize = [[UIScreen mainScreen] scale] * MAX(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds));
    return MIN(imageSize,512);
}


@end
