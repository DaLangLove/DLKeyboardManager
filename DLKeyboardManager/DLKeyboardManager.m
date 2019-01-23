//
//  DLKeyboardManager.m
//  Pods-Example
//
//  Created by Dalang on 2019/1/23.
//

#import "DLKeyboardManager.h"

#pragma mark - DLKeyboardInformation
@interface DLKeyboardInformation ()

- (instancetype)initWithInformation:(NSDictionary *_Nonnull)information;

@end

@implementation DLKeyboardInformation

- (instancetype)initWithInformation:(NSDictionary *_Nonnull)information
{
    self = [super init];
    if (self) {
        _startFrame        = [[information objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        _endFrame          = [[information objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        _animationDuration = [[information objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        _animationCurve    = (UIViewAnimationCurve)[[information objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
        if (@available(iOS 9.0, *)) {
            _isInCurrentApp = [[information objectForKey:UIKeyboardIsLocalUserInfoKey] boolValue];
        }
    }
    return self;
}

- (NSString *)description
{
    if (@available(iOS 9.0, *)) {
        return [NSString stringWithFormat:@"DLKeyboardInformation:\nstartFrame: %@\nendFrame: %@\nanimationDuration: %f\nanimationCurve: %ld\nisInCurrentApp: %@", NSStringFromCGRect(_startFrame), NSStringFromCGRect(_endFrame), _animationDuration, (long)_animationCurve, (_isInCurrentApp ? @"YES" : @"NO")];
    } else {
        return [NSString stringWithFormat:@"\nDLKeyboardInformation:\nstartFrame: %@\nendFrame: %@\nanimationDuration: %f\nanimationCurve: %ld\n", NSStringFromCGRect(_startFrame), NSStringFromCGRect(_endFrame), _animationDuration, (long)_animationCurve];
    }
}

- (NSString *)debugDescription
{
    if (@available(iOS 9.0, *)) {
        return [NSString stringWithFormat:@"DLKeyboardInformation:\nstartFrame: %@\nendFrame: %@\nanimationDuration: %f\nanimationCurve: %ld\nisInCurrentApp: %@", NSStringFromCGRect(_startFrame), NSStringFromCGRect(_endFrame), _animationDuration, (long)_animationCurve, (_isInCurrentApp ? @"YES" : @"NO")];
    } else {
        return [NSString stringWithFormat:@"\nDLKeyboardInformation:\nstartFrame: %@\nendFrame: %@\nanimationDuration: %f\nanimationCurve: %ld\n", NSStringFromCGRect(_startFrame), NSStringFromCGRect(_endFrame), _animationDuration, (long)_animationCurve];
    }
}

@end


#pragma mark - DLKeyboardManager

DLKeyboardEvent *DLKeyboardEventWillShow        = @"DLKeyboardEventWillShow";
DLKeyboardEvent *DLKeyboardEventDidShow         = @"DLKeyboardEventDidShow";
DLKeyboardEvent *DLKeyboardEventWillHide        = @"DLKeyboardEventWillHide";
DLKeyboardEvent *DLKeyboardEventDidHide         = @"DLKeyboardEventDidHide";
DLKeyboardEvent *DLKeyboardEventWillChangeFrame = @"DLKeyboardEventWillChangeFrame";
DLKeyboardEvent *DLKeyboardEventDidChangeFrame  = @"DLKeyboardEventDidChangeFrame";

@interface DLKeyboardManager ()

@property (nonatomic, strong) NSMutableDictionary <DLKeyboardEvent *, DLKeyboardCallBack> *callBacks;

@end


@implementation DLKeyboardManager

#pragma mark - 单例

static DLKeyboardManager *_manager;

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[DLKeyboardManager alloc] init];
    });
    return _manager;
}



+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _manager;
}



#pragma mark - 注册
- (void)registerForEvent:(DLKeyboardEvent *)event callBack:(DLKeyboardCallBack)callBack
{
    NSString *notificationName = [self notificationForEvent:event];
    SEL selector               = [self selectorForEvent:event];
    
    [_callBacks setObject:callBack forKey:event];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:notificationName
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:selector
                                                 name:notificationName
                                               object:nil];
}

#pragma mark - 注销
- (void)cancellationForEvent:(DLKeyboardEvent *)event
{
    NSString *notificationName = [self notificationForEvent:event];
    [_callBacks removeObjectForKey:event];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:notificationName
                                                  object:nil];
}

- (void)cancellationAllEvents
{
    [_callBacks removeAllObjects];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private
- (instancetype)init
{
    self = [super init];
    if (self) {
        _callBacks = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - WillShow
- (void)keyboardWillShow:(NSNotification *)notification
{
    DLKeyboardCallBack callBack = [_callBacks objectForKey:DLKeyboardEventWillShow];
    if (callBack) {
        DLKeyboardInformation *info = [[DLKeyboardInformation alloc] initWithInformation:notification.userInfo];
        callBack(info);
    }
}
#pragma mark - didShow
- (void)keyboardDidShow:(NSNotification *)notification
{
    DLKeyboardCallBack callBack = [_callBacks objectForKey:DLKeyboardEventDidShow];
    if (callBack) {
        DLKeyboardInformation *info = [[DLKeyboardInformation alloc] initWithInformation:notification.userInfo];
        callBack(info);
    }
}
#pragma mark - WillHide
- (void)keyboardWillHide:(NSNotification *)notification
{
    DLKeyboardCallBack callBack = [_callBacks objectForKey:DLKeyboardEventWillHide];
    if (callBack) {
        DLKeyboardInformation *info = [[DLKeyboardInformation alloc] initWithInformation:notification.userInfo];
        callBack(info);
    }
}
#pragma mark - didHide
- (void)keyboardDidHide:(NSNotification *)notification
{
    DLKeyboardCallBack callBack = [_callBacks objectForKey:DLKeyboardEventDidHide];
    if (callBack) {
        DLKeyboardInformation *info = [[DLKeyboardInformation alloc] initWithInformation:notification.userInfo];
        callBack(info);
    }
}
#pragma mark - willChangeFrame
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    DLKeyboardCallBack callBack = [_callBacks objectForKey:DLKeyboardEventWillChangeFrame];
    if (callBack) {
        DLKeyboardInformation *info = [[DLKeyboardInformation alloc] initWithInformation:notification.userInfo];
        callBack(info);
    }
}
#pragma mark - didChangeFrame
- (void)keyboardDidChangeFrame:(NSNotification *)notification
{
    DLKeyboardCallBack callBack = [_callBacks objectForKey:DLKeyboardEventDidChangeFrame];
    if (callBack) {
        DLKeyboardInformation *info = [[DLKeyboardInformation alloc] initWithInformation:notification.userInfo];
        callBack(info);
    }
}

#pragma mark - Notification name
- (NSString *)notificationForEvent:(DLKeyboardEvent *)event
{
    if ([event isEqualToString:DLKeyboardEventWillShow]) {
        return @"UIKeyboardWillShowNotification";
    }
    
    if ([event isEqualToString:DLKeyboardEventDidShow]) {
        return @"UIKeyboardDidShowNotification";
    }
    
    if ([event isEqualToString:DLKeyboardEventWillHide]) {
        return @"UIKeyboardWillHideNotification";
    }
    
    if ([event isEqualToString:DLKeyboardEventDidHide]) {
        return @"UIKeyboardDidHideNotification";
    }
    
    if ([event isEqualToString:DLKeyboardEventWillChangeFrame]) {
        return @"UIKeyboardWillChangeFrameNotification";
    }
    
    if ([event isEqualToString:DLKeyboardEventDidChangeFrame]) {
        return @"UIKeyboardDidChangeFrameNotification";
    }
    
    return nil;
}
#pragma mark - Notification selector
- (SEL)selectorForEvent:(DLKeyboardEvent *)event
{
    if ([event isEqualToString:DLKeyboardEventWillShow]) {
        return @selector(keyboardWillShow:);
    }
    
    if ([event isEqualToString:DLKeyboardEventDidShow]) {
        return @selector(keyboardDidShow:);
    }
    
    if ([event isEqualToString:DLKeyboardEventWillHide]) {
        return @selector(keyboardWillHide:);
    }
    
    if ([event isEqualToString:DLKeyboardEventDidHide]) {
        return @selector(keyboardDidHide:);
    }
    
    if ([event isEqualToString:DLKeyboardEventWillChangeFrame]) {
        return @selector(keyboardWillChangeFrame:);
    }
    
    if ([event isEqualToString:DLKeyboardEventDidChangeFrame]) {
        return @selector(keyboardDidChangeFrame:);
    }
    
    return nil;
}


@end
