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

#import <UIKit/UIKit.h>
#import "KHGravatar.h"

/**
 This category adds methods to the UIKit framework's `UIImageView` class to automatically download images from  for a specified email address. The methods in this category provide support for loading remote images asynchronously from a URL using the `AFNetworking` UIImageView category. This class requires `AFNetworking` to already be included in the project.
 
 Note that all methods return the properly sized image based on the size of the UIImageView and the scale of the screen.
 */
@interface UIImageView (KHGravatar)

/**
 Creates and enqueues an image request operation, which asynchronously downloads the  image for the specified email address, and sets it the request is finished. If the image is cached locally, the image is set immediately, otherwise, the image is set once the request is finished.
 
 @discussion By default, url requests have a cache policy of `NSURLCacheStorageAllowed` and a timeout interval of 30 seconds, and are set to use HTTP pipelining, and not handle cookies. To configure url requests differently, use `setImageWithURLRequest:placeholderImage:success:failure:`
 
 @param emailAddress The email address used for the  image request.
 */
- (void)setImageWithGravatarEmailAddress:(NSString*)emailAddress;

/**
 Creates and enqueues an image request operation, which asynchronously downloads the  image for the specified email address. If the image is cached locally, the image is set immediately. Otherwise, the specified placeholder image will be set immediately, and then the remote image will be set once the request is finished.
 
 @param emailAddress The email address used for the  image request.
 @param placeholderImage The image to be set initially, until the image request finishes. If `nil`, the image view will not change its image until the image request finishes.
 
 @discussion By default, url requests have a cache policy of `NSURLCacheStorageAllowed` and a timeout interval of 30 seconds, and are set to use HTTP pipelining, and not handle cookies. To configure url requests differently, use `setImageWithURLRequest:placeholderImage:success:failure:`
 */
- (void)setImageWithGravatarEmailAddress:(NSString*)emailAddress placeholderImage:(UIImage*)placeholderImage;

/**
 Creates and enqueues an image request operation, which asynchronously downloads the  image for the specified email address. If the image is cached locally, the image is set immediately. Otherwise, the specified placeholder image will be set immediately, and then the remote image will be set once the request is finished. If the email address does not have a , the default image will be returned as specified in the defaultImageType.
 
 @param emailAddress The email address used for the  image request.
 @param placeholderImage The image to be set initially, until the image request finishes. If `nil`, the image view will not change its image until the image request finishes.
 @param defaultImageType The type of image returned if no  exists for the specified email address.
 @param forceDefault Force the default image type to load regardless of whether or not a gravatar is found for the specified email address.
 @param rating The acceptable rating for the image to be used within your application.
 
 @discussion By default, url requests have a cache policy of `NSURLCacheStorageAllowed` and a timeout interval of 30 seconds, and are set to use HTTP pipelining, and not handle cookies. To configure url requests differently, use `setImageWithURLRequest:placeholderImage:success:failure:`
 */
- (void)setImageWithGravatarEmailAddress:(NSString*)emailAddress 
                        placeholderImage:(UIImage*)placeholderImage
                        defaultImageType:(KHGravatarDefaultImage)defaultImageType
                            forceDefault:(BOOL)forceDefault
                                  rating:(KHGravatarRating)rating;

/**
 Creates and enqueues an image request operation, which asynchronously downloads the  image for the specified email address. If the image is cached locally, the image is set immediately. Otherwise, the specified placeholder image will be set immediately, and then the remote image will be set once the request is finished. If the email address does not have a , the default image will be returned as specified by the defaultImageURL.
 
 @param emailAddress The email address used for the  image request.
 @param placeholderImage The image to be set initially, until the image request finishes. If `nil`, the image view will not change its image until the image request finishes.
 @param defaultImageURL The URL pointing to the image to return if no  is found for the specified email address.
 @param forceDefault Force the default image type to load regardless of whether or not a gravatar is found for the specified email address.
 @param rating The acceptable rating for the image to be used within your application.
 
 @discussion By default, url requests have a cache policy of `NSURLCacheStorageAllowed` and a timeout interval of 30 seconds, and are set to use HTTP pipelining, and not handle cookies. To configure url requests differently, use `setImageWithURLRequest:placeholderImage:success:failure:`
 */
- (void)setImageWithGravatarEmailAddress:(NSString*)emailAddress 
                        placeholderImage:(UIImage*)placeholderImage
                         defaultImageURL:(NSURL*)defaultImageURL
                            forceDefault:(BOOL)forceDefault
                                  rating:(KHGravatarRating)rating;

/**
 Creates and enqueues an image request operation, which asynchronously downloads the  image for the specified email address. If the image is cached locally, the image is set immediately. Otherwise, the specified placeholder image will be set immediately, and then the remote image will be set once the request is finished. If the email address does not have a , the default image will be returned as specified by the defaultImageURL.
 
 @param emailAddress The email address used for the  image request.
 @param placeholderImage The image to be set initially, until the image request finishes. If `nil`, the image view will not change its image until the image request finishes.
 @param defaultImageType The type of image returned if no  exists for the specified email address.
 @param forceDefault Force the default image type to load regardless of whether or not a gravatar is found for the specified email address.
 @param rating The acceptable rating for the image to be used within your application.
 @param success A block to be executed when the image request operation finishes successfully, with a status code in the 2xx range, and with an acceptable content type (e.g. `image/png`). This block has no return value and takes three arguments: the request sent from the client, the response received from the server, and the image created from the response data of request. If the image was returned from cache, the request and response parameters will be `nil`.
 @param failure A block object to be executed when the image request operation finishes unsuccessfully, or that finishes successfully. This block has no return value and takes three arguments: the request sent from the client, the response received from the server, and the error object describing the network or parsing error that occurred.
 
 @discussion By default, url requests have a cache policy of `NSURLCacheStorageAllowed` and a timeout interval of 30 seconds, and are set to use HTTP pipelining, and not handle cookies. To configure url requests differently, use `setImageWithURLRequest:placeholderImage:success:failure:` 
 */
- (void)setImageWithGravatarEmailAddress:(NSString*)emailAddress 
                        placeholderImage:(UIImage *)placeholderImage 
                        defaultImageType:(KHGravatarDefaultImage)defaultImageType
                            forceDefault:(BOOL)forceDefault
                                  rating:(KHGravatarRating)rating
                                 success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                                 failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure;

@end
