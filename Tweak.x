#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <substrate.h>

@interface CustomModMenuViewController : UIViewController

- (void)showMenu;

@end

@implementation CustomModMenuViewController {
    UIButton *closeButton;
    UISlider *volumeSlider;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    closeButton.frame = CGRectMake(20, 100, self.view.frame.size.width - 40, 30);
    [closeButton setTitle:@"Close Menu" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 150, self.view.frame.size.width - 40, 30)];
    volumeSlider.minimumValue = 0.0;
    volumeSlider.maximumValue = 1.0;
    volumeSlider.value = 0.5; // Example initial value
    [volumeSlider addTarget:self action:@selector(volumeChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:volumeSlider];
}

- (void)showMenu {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:self animated:YES completion:nil];
}

- (void)closeMenu {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)volumeChanged:(UISlider *)slider {
    // Adjust device volume based on slider value
    [[AVAudioSession sharedInstance] setOutputVolume:slider.value error:nil];
}

@end

%hook UIViewController

- (void)viewDidLoad {
    %orig;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showModMenu)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)showModMenu {
    CustomModMenuViewController *menuVC = [[CustomModMenuViewController alloc] init];
    [menuVC showMenu];
}

%end
