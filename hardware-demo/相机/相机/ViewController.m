//
//  ViewController.m
//  相机
//
//  Created by apple on 16/10/22.
//  Copyright © 2016年 MengYP. All rights reserved.
//

/*
 iOS 10 必须在info.plist中添加 ： NSPhotoLibraryUsageDescription
 
 */

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong) UIImagePickerController *imagePickerVC;
@property(nonatomic,weak)IBOutlet UIImageView *imgView;

@end
@implementation ViewController

- (IBAction)openPhotoLibrary
{
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePickerVC = imagePickerVC;
    self.imagePickerVC.delegate = self;
    
    [self presentViewController:imagePickerVC animated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    self.imgView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



@end
