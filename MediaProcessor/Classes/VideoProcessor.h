//
//  VideoProcessor.h
//  TXUGCUploaderExample
//
//  Created by ryan on 2019/11/20.
//  Copyright © 2019 windbird. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoProcessorConfig.h"
#import "VideoProcessorDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoProcessor : NSObject

@property(weak, nonatomic)id<VideoProcessorDelegate> delegate;
@property(nonatomic, assign, readonly)Boolean videoExists;

- (instancetype)initWithConfig:(VideoProcessorConfig *)config;

/// 转换成mp4视频文件
- (void)transferMP4:(void (^)(NSError * _Nullable error, AVAssetExportSessionStatus status)) completion;

- (VideoProcessorConfig *)config;

/// 获取视频封面
//- (void)makeCoverImage;

/// 提取第一帧作为视频的封面
- (void)extractFirstFrameAsCoverImage:(void(^)(NSError * _Nullable error, UIImage * _Nullable image)) completion;

@end

NS_ASSUME_NONNULL_END
