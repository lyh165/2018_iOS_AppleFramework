/**
 
 当前设备的表示。
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKitDefines.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UIDeviceOrientation) {
    UIDeviceOrientationUnknown,
    UIDeviceOrientationPortrait,            //设备垂直定向，底部的home按钮 Device oriented vertically, home button on the bottom 
    UIDeviceOrientationPortraitUpsideDown,  //设备垂直朝向，顶部的home按钮 Device oriented vertically, home button on the top
    UIDeviceOrientationLandscapeLeft,       //设备水平方向，右边的home按钮 Device oriented horizontally, home button on the right
    UIDeviceOrientationLandscapeRight,      //设备水平方向，左侧为home按钮 Device oriented horizontally, home button on the left
    UIDeviceOrientationFaceUp,              //设备朝向平，face up Device oriented flat, face up
    UIDeviceOrientationFaceDown             //设备朝向平，面朝下  Device oriented flat, face down
} __TVOS_PROHIBITED;

typedef NS_ENUM(NSInteger, UIDeviceBatteryState) {
    UIDeviceBatteryStateUnknown,
    UIDeviceBatteryStateUnplugged,   //电池没电，放电  on battery, discharging
    UIDeviceBatteryStateCharging,    //插电，不到100% plugged in, less than 100%
    UIDeviceBatteryStateFull,        //插电，100% plugged in, at 100%
} __TVOS_PROHIBITED;              // available in iPhone 3.0

typedef NS_ENUM(NSInteger, UIUserInterfaceIdiom) {
    UIUserInterfaceIdiomUnspecified = -1,
    UIUserInterfaceIdiomPhone NS_ENUM_AVAILABLE_IOS(3_2), //iPhone和iPod touch风格的UI iPhone and iPod touch style UI
    UIUserInterfaceIdiomPad NS_ENUM_AVAILABLE_IOS(3_2), //iPad风格UI iPad style UI
    UIUserInterfaceIdiomTV NS_ENUM_AVAILABLE_IOS(9_0), // Apple TV风格UI Apple TV style UI
    UIUserInterfaceIdiomCarPlay NS_ENUM_AVAILABLE_IOS(9_0), // CarPlay风格UI CarPlay style UI
};

static inline BOOL UIDeviceOrientationIsPortrait(UIDeviceOrientation orientation)  __TVOS_PROHIBITED {
    return ((orientation) == UIDeviceOrientationPortrait || (orientation) == UIDeviceOrientationPortraitUpsideDown);
}

static inline BOOL UIDeviceOrientationIsLandscape(UIDeviceOrientation orientation)  __TVOS_PROHIBITED {
    return ((orientation) == UIDeviceOrientationLandscapeLeft || (orientation) == UIDeviceOrientationLandscapeRight);
}

NS_CLASS_AVAILABLE_IOS(2_0) @interface UIDevice : NSObject 

#if UIKIT_DEFINE_AS_PROPERTIES
@property(class, nonatomic, readonly) UIDevice *currentDevice;
#else
+ (UIDevice *)currentDevice;
#endif

@property(nonatomic,readonly,strong) NSString    *name;              //“我的iPhone”  e.g. "My iPhone"
@property(nonatomic,readonly,strong) NSString    *model;             //例如@“iPhone”、@“iPod touch” e.g. @"iPhone", @"iPod touch"
@property(nonatomic,readonly,strong) NSString    *localizedModel;    //本地化版本的模型 localized version of model
@property(nonatomic,readonly,strong) NSString    *systemName;        //例如:@“iOS” e.g. @"iOS"
@property(nonatomic,readonly,strong) NSString    *systemVersion;     //例如:@“4.0” e.g. @"4.0"
@property(nonatomic,readonly) UIDeviceOrientation orientation __TVOS_PROHIBITED;       //返回当前设备方向。这将返回UIDeviceOrientationUnknown，除非正在生成设备定向通知。 return current device orientation.  this will return UIDeviceOrientationUnknown unless device orientation notifications are being generated.

@property(nullable, nonatomic,readonly,strong) NSUUID      *identifierForVendor NS_AVAILABLE_IOS(6_0);      //一个UUID，可用于唯一地标识设备，在单个供应商的应用程序之间是相同的。 a UUID that may be used to uniquely identify the device, same across apps from a single vendor.

@property(nonatomic,readonly,getter=isGeneratingDeviceOrientationNotifications) BOOL generatesDeviceOrientationNotifications __TVOS_PROHIBITED;
- (void)beginGeneratingDeviceOrientationNotifications __TVOS_PROHIBITED;      //嵌套
 nestable
- (void)endGeneratingDeviceOrientationNotifications __TVOS_PROHIBITED;

@property(nonatomic,getter=isBatteryMonitoringEnabled) BOOL batteryMonitoringEnabled NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;  //默认为NO default is NO
@property(nonatomic,readonly) UIDeviceBatteryState          batteryState NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;  //UIDeviceBatteryStateUnknown如果监视不能使用 UIDeviceBatteryStateUnknown if monitoring disabled
@property(nonatomic,readonly) float                         batteryLevel NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;  //0 . .1.0。-1.0如果UIDeviceBatteryStateUnknown 0 .. 1.0. -1.0 if UIDeviceBatteryStateUnknown

@property(nonatomic,getter=isProximityMonitoringEnabled) BOOL proximityMonitoringEnabled NS_AVAILABLE_IOS(3_0); //默认是没有 default is NO
@property(nonatomic,readonly)                            BOOL proximityState NS_AVAILABLE_IOS(3_0);  // 如果没有接近探测器，总是返回NO always returns NO if no proximity detector

@property(nonatomic,readonly,getter=isMultitaskingSupported) BOOL multitaskingSupported NS_AVAILABLE_IOS(4_0);

@property(nonatomic,readonly) UIUserInterfaceIdiom userInterfaceIdiom NS_AVAILABLE_IOS(3_2);

- (void)playInputClick NS_AVAILABLE_IOS(4_2);  //仅当启用输入视图在屏幕上且用户已启用输入单击时才播放单击。 Plays a click only if an enabling input view is on-screen and user has enabled input clicks.

@end

@protocol UIInputViewAudioFeedback <NSObject>
@optional

@property (nonatomic, readonly) BOOL enableInputClicksWhenVisible; //如果是，输入视图将启用playInputClick。 If YES, an input view will enable playInputClick.

@end

/* The UI_USER_INTERFACE_IDIOM() function is provided for use when deploying to a version of the iOS less than 3.2. If the earliest version of iPhone/iOS that you will be deploying for is 3.2 or greater, you may use -[UIDevice userInterfaceIdiom] directly.
 UI_USER_INTERFACE_IDIOM()函数用于部署到小于3.2的iOS版本时。如果您要部署的最早的iPhone/iOS版本是3.2或更高版本，您可以直接使用-[UIDevice userInterfaceIdiom]。
 */
static inline UIUserInterfaceIdiom UI_USER_INTERFACE_IDIOM() {
    return ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] ?
            [[UIDevice currentDevice] userInterfaceIdiom] :
            UIUserInterfaceIdiomPhone);
}

UIKIT_EXTERN NSNotificationName const UIDeviceOrientationDidChangeNotification __TVOS_PROHIBITED;
UIKIT_EXTERN NSNotificationName const UIDeviceBatteryStateDidChangeNotification   NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
UIKIT_EXTERN NSNotificationName const UIDeviceBatteryLevelDidChangeNotification   NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
UIKIT_EXTERN NSNotificationName const UIDeviceProximityStateDidChangeNotification NS_AVAILABLE_IOS(3_0);

NS_ASSUME_NONNULL_END
