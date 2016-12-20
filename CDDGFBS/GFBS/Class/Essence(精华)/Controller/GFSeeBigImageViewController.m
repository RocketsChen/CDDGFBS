//
//  GFSeeBigImageViewController.m
//  GFBS
//
//  Created by apple on 2016/11/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFSeeBigImageViewController.h"
#import "GFTopic.h"

#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>

@interface GFSeeBigImageViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
/*图片属性*/
@property (weak ,nonatomic) UIImageView *imageView;


@end

@implementation GFSeeBigImageViewController

#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    //UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)];
    [scrollView addGestureRecognizer:gesture];
    
    [self.view insertSubview:scrollView atIndex:0];
    scrollView.frame = [UIScreen mainScreen].bounds; //算出准备的尺寸
    
    
    //imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        self.saveButton.enabled = YES;
    
    }];
    imageView.gf_width = scrollView.gf_width;
    imageView.gf_height = imageView.gf_width * self.topic.height / self.topic.width;
    imageView.gf_x = 0;
    if (imageView.gf_height > GFScreenHeight) {
        
        imageView.gf_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.gf_height);
    }else
    {
        imageView.gf_centerY = scrollView.gf_height * 0.5;
    }
    
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    //缩放
    CGFloat maxScale = self.topic.width / imageView.gf_width ;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    
    //保存图片
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
}

@end
