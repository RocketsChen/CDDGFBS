//
//  GFSettingViewController.m
//  高仿百思不得不得姐
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GFSettingViewController.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>
static NSString*const ID = @"ID";
@interface GFSettingViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *cleanCell;
@end

@implementation GFSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    //计算整个应用程序的缓存数据 --- > 沙盒（Cache）
    //NSFileManager
    //attributesOfItemAtPathe:指定文件路径，获取文件属性
    //把所有文件尺寸加起来
    //获取缓存尺寸字符串赋值给cell的textLabel
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"字体大小";

    }if (indexPath.section == 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            
            CGFloat size = [SDImageCache sharedImageCache].getSize / 1000.0 / 1000;
            cell.textLabel.text = [NSString stringWithFormat:@"清除缓存（已使用%.2fMB）", size];
        }else if (indexPath.row == 1)
        {
            cell.textLabel.text = @"常见问题";
        }else
        {
            cell.textLabel.text = @"关于我们";
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat size = [SDImageCache sharedImageCache].getSize / 1000.0 / 1000;
    if (size != 0) {
        if (indexPath.section == 1 && indexPath.row == 0) {
            [[SDImageCache sharedImageCache] clearDisk];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD showWithStatus:@"删除缓存中..."];
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    });
    
}


@end
