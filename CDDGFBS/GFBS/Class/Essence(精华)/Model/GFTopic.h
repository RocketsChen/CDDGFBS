//
//  GFTopic.h
//  GFBS
//
//  Created by apple on 2016/11/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GFComment.h"


typedef NS_ENUM(NSInteger , GFTopicType){
    //全部
    GFTopicTypeAll = 1,
    //图片
    GFTopicTypePicture = 10,
    //段子
    GFTopicTypeWord = 29,
    //声音
    GFTopicTypeVoice = 31,
    //视频
    GFTopicTypeVideo = 41
};


@interface GFTopic : NSObject


/** id */
@property (nonatomic, copy) NSString *ID;


/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发、分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;


///*最热评论*/
//@property (strong , nonatomic)NSArray<GFComment*> *top_cmt;
//最热评论
@property (strong , nonatomic) GFComment *top_cmt;

/** 帖子类型 */
@property (nonatomic, assign) GFTopicType type;


/** 图片的真实宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的真实高度 */
@property (nonatomic, assign) CGFloat height;

/** 小图 */
@property (nonatomic, copy) NSString *small_image;
/** 大图（原图）*/
@property (nonatomic, copy) NSString *large_image;
/** 中图 */
@property (nonatomic, copy) NSString *middle_image;
/** 是否为GIF */
@property (nonatomic, assign) BOOL is_gif;
/** 是否为large_image */
@property (nonatomic, assign) BOOL is_largeImage;


/** 播放数量 */
@property (nonatomic, copy) NSString *playcount;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 声音时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 视频播放的url地址 */
@property (nonatomic,copy) NSString *videouri;
/** 音频的url */
@property (nonatomic,copy) NSString *voiceuri;

/*****额外增加的属性*****/

/** cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间内容的Frame */
@property (nonatomic, assign) CGRect middleF;

/** 声音是否在播放 */
@property (nonatomic, assign,getter=is_voicePlaying) BOOL voicePlaying;



@end
