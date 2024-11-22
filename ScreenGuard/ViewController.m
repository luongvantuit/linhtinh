//
//  ViewController.m
//  ScreenGuard
//
//  Created by tus on 7/11/24.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // NSURL *videoURL = [NSURL URLWithString:@"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"]
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"]];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:playerLayer];

    // Tắt ghi màn hình cho video (chỉ khả dụng trên các thiết bị hỗ trợ)
    if (@available(iOS 9.0, *)) {
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        playerLayer.masksToBounds = YES;
        playerLayer.hidden = NO;
    }
    [player play];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"Running...");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didScreenshot) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRecordingScreen) name:UIScreenCapturedDidChangeNotification object:nil];
}

- (void)addScreenShotProtectionLayer {
    UIView *protectionLayer = [[UIView alloc] initWithFrame:self.view.bounds];
    protectionLayer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:protectionLayer];
    protectionLayer.tag = 999; // Set a tag to identify it later
}

- (void)removeScreenShotProtectionLayer {
    UIView *protectionLayer = [self.view viewWithTag:999];
    [protectionLayer removeFromSuperview];
}

- (void)didScreenshot {
    NSLog(@"Screenshot");
//    [self addScreenShotProtectionLayer];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self removeScreenShotProtectionLayer];
//    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // Ẩn UI nhạy cảm
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.hidden = YES;
            });
            
            // Đợi một chút và sau đó hiển thị lại UI
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.imageView.hidden = NO;
            });
        });
}

- (void)didRecordingScreen {
    if (UIScreen.mainScreen.isCaptured) {
        // Làm mờ toàn bộ giao diện
        UIView *blurView = [[UIView alloc] initWithFrame:self.view.bounds];
        blurView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
        blurView.tag = 999; // Đặt tag để dễ quản lý
        [self.view addSubview:blurView];
        NSLog(@"Is Captured");
    } else {
        [[self.view viewWithTag:999] removeFromSuperview];
        NSLog(@"Is't Captured");
    }
}


@end
