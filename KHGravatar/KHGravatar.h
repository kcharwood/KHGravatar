// KHGravatar.h
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

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, KHGravatarDefaultImage) {
    KHGravatarDefaultImageDefault = 0,
    KHGravatarDefaultImage404,
    KHGravatarDefaultImageMysteryMan,
    KHGravatarDefaultImageIdenticon,
    KHGravatarDefaultImageMonsterId,
    KHGravatarDefaultImageWavatar,
    KHGravatarDefaultImageRetro,
};

typedef NS_ENUM(NSUInteger, KHGravatarRating) {
    KHGravatarRatingG = 0,
    KHGravatarRatingPG,
    KHGravatarRatingR,
    KHGravatarRatingX,
};

@interface KHGravatar : NSObject

/**
 Creates a Gravatar url for the specified email address.
 
 @discussion The URL only contains the email hash, and returns the default settings from Gravater. 
 
 @param emailAddress The email address used to create the URL.
 
 @return The Gravatar URL for the specified email address.
 */
+ (NSURL *)URLForGravatarEmailAddress:(NSString*)emailAddress;

/**
 Creates a Gravatar url for the specified email address, default image type, forced default image flag, rating, and size.
 
 @discussion The generated URL contains all the options passed into this method. If you want the default size returned by Gravatar, pass -1 for size.
 
 @param emailAddress The email address used to create the URL.
 @param defaultImageType The default image type to return.
 @param forceDefault Force the default image type to load regardless of whether or not a gravatar is found for the specified email address.
 @param rating The image rating to return.
 @param size The size of the image to return. For the default size returned by Gravatar, pass -1.
 
 @return The Gravatar URL for the specified options.
 */
+ (NSURL *)URLForGravatarEmailAddress:(NSString*)emailAddress
                     defaultImageType:(KHGravatarDefaultImage)defaultImageType
                         forceDefault:(BOOL)forceDefault
                               rating:(KHGravatarRating)rating
                                 size:(CGFloat)size;

/**
 Creates a Gravatar url for the specified email address, default image type URL, forced default image flag, rating, and size.
 
 @discussion The generated URL contains all the options passed into this method. If you want the default size returned by Gravatar, pass -1 for size.
 
 @param emailAddress The email address used to create the URL.
 @param defaultImageURL The URL for the default image to load.
 @param forceDefault Force the default image type to load regardless of whether or not a gravatar is found for the specified email address.
 @param rating The image rating to return.
 @param size The size of the image to return. For the default size returned by Gravatar, pass -1.
 
 @return The Gravatar URL for the specified options.
 */
+ (NSURL *)URLForGravatarEmailAddress:(NSString*)emailAddress
                      defaultImageURL:(NSURL*)defaultImageURL
                         forceDefault:(BOOL)forceDefault
                               rating:(KHGravatarRating)rating
                                 size:(CGFloat)size;

@end
