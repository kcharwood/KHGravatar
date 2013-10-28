//
//  KHViewController.m
//  KHGravatarExample
//
//  Created by Kevin Harwood on 10/28/13.
//  Copyright (c) 2013 Kevin Harwood. All rights reserved.
//

#import "KHViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "UIImageView+KHGravatar.h"
@interface KHViewController ()
@property (nonatomic,strong) UIImageView * imageView;
@end

@implementation KHViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupImageView{
    _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [_imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:_imageView];
    
    [_imageView setImageWithGravatarEmailAddress:@"test@gmail.com"
                                placeholderImage:nil
                                defaultImageType:KHGravatarDefaultImageIdenticon
                                    forceDefault:YES
                                          rating:KHGravatarRatingG];
}

@end
