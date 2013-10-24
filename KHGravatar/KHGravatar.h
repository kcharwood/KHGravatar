//
//  KHGravatar.h
//  KHGravatarExample
//
//  Created by Kevin Harwood on 10/24/13.
//  Copyright (c) 2013 Kevin Harwood. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    KHGravatarDefaultImageDefault = 0,
    KHGravatarDefaultImage404,
    KHGravatarDefaultImageMysteryMan,
    KHGravatarDefaultImageIdenticon,
    KHGravatarDefaultImageMonsterId,
    KHGravatarDefaultImageWavatar,
    KHGravatarDefaultImageRetro,
}KHGravatarDefaultImage;

typedef enum {
    KHGravatarRatingG = 0,
    KHGravatarRatingPG,
    KHGravatarRatingR,
    KHGravatarRatingX,
}KHGravatarRating;

@interface KHGravatar : NSObject

+ (NSURL *)URLForGravatarEmailAddress:(NSString*)emailAddress;

+ (NSURL *)URLForGravatarEmailAddress:(NSString*)emailAddress
                     defaultImageType:(KHGravatarDefaultImage)defaultImageType
                               rating:(KHGravatarRating)rating
                                 size:(CGFloat)size;

+ (NSURL *)URLForGravatarEmailAddress:(NSString*)emailAddress
                      defaultImageURL:(NSURL*)defaultImageURL
                               rating:(KHGravatarRating)rating
                                 size:(CGFloat)size;

@end
