//
//  VideoProcessor.m
//  TXUGCUploaderExample
//
//  Created by ryan on 2019/11/20.
//  Copyright © 2019 windbird. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "VideoProcessor.h"

@interface VideoProcessor ()

@property(nonatomic, strong)VideoProcessorConfig *config;
@property(nonatomic, strong)AVAssetExportSession *exportSession;

@end

@implementation VideoProcessor

- (instancetype)initWithConfig:(VideoProcessorConfig *)config {
    if(self = [super init]) {
        self.config = config;
    }
    return self;
}

- (void)transferMP4:(void (^)(NSError * _Nullable error, AVAssetExportSessionStatus status)) completion {
    NSURL *originalVideoURL = _config.originalVideoURL;
    AVAsset *asset = [AVAsset assetWithURL:originalVideoURL];
    AVAssetExportSession *exportSession = [AVAssetExportSession exportSessionWithAsset:asset presetName:_config.presetName];
    self.exportSession = exportSession;
    exportSession.outputURL = _config.outputURL;
    exportSession.outputFileType = _config.outputFileType;
    exportSession.shouldOptimizeForNetworkUse = _config.shouldOptimizeForNetworkUse;
    exportSession.timeRange = CMTimeRangeMake(kCMTimeZero, asset.duration);
    if(_delegate && [_delegate respondsToSelector:@selector(videoProcessor:configExportSession:)]) {
        [_delegate videoProcessor:self configExportSession:exportSession];
    }
    __weak typeof(self) weakSelf = self;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        if(!weakSelf) {  return;  }
        completion(exportSession.error, exportSession.status);
    }];
}

- (void)extractFirstFrameAsCoverImage:(void (^)( NSError * _Nullable error,  UIImage * _Nullable image))completion {
    dispatch_queue_global_t globalQueue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    __weak typeof(self) weakSelf = self;
    dispatch_async(globalQueue, ^{
        NSURL *originalVideoURL = weakSelf.config.originalVideoURL;
        AVAsset *asset = [AVAsset assetWithURL:originalVideoURL];
        AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
        if(weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(videoProcessor:configImageGenerator:)]) {
            [weakSelf.delegate videoProcessor:weakSelf configImageGenerator:imageGenerator];
        }
        imageGenerator.appliesPreferredTrackTransform = true;
        CMTime startTime = CMTimeMake(1, 1);
        NSError *error;
        CGImageRef imgRef = [imageGenerator copyCGImageAtTime:startTime actualTime:nil error:&error];
        UIImage *coverImage = nil;
        if(!error) {
            coverImage = [UIImage imageWithCGImage:imgRef];
        }
        completion(error, coverImage);
    });
}

- (Boolean)videoExists {
    BOOL videoExists = [NSFileManager.defaultManager fileExistsAtPath:_config.originalVideoURL.path];
    return videoExists;
}

@end
