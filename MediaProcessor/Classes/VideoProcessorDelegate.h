//
//  VideoProcessorDelegate.h
//  TXUGCUploaderExample
//
//  Created by ryan on 2019/11/20.
//  Copyright © 2019 windbird. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VideoProcessor;
@protocol VideoProcessorDelegate <NSObject>

@optional
-(void)videoProcessor:(VideoProcessor *) processor configExportSession:(AVAssetExportSession *)exportSession;
-(void)videoProcessor:(VideoProcessor *) processor configImageGenerator:(AVAssetImageGenerator *)generator;

@end

NS_ASSUME_NONNULL_END
