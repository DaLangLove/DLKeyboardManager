//
//  DLKeyboardManager.h
//  Pods-Example
//
//  Created by Dalang on 2019/1/23.
//

/*
 记录一个问题的解决方法
 问题：在 Storyboard 中添加了一个 UITextField，在测试的时候 UIKeyboardWillShowNotification 通知方法执行了2次。
 解决：在 Storyboard 中将 correction 和 spellcheck 属性关闭
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - DLKeyboardInformation
@interface DLKeyboardInformation : NSObject

/**
 开始的 Frame，对应 UIKeyboardFrameBeginUserInfoKey
 */
@property (nonatomic, assign, readonly) CGRect startFrame;

/**
 结束的 Frame， 对应 UIKeyboardFrameEndUserInfoKey
 */
@property (nonatomic, assign, readonly) CGRect endFrame;

/**
 动画时间，对应 UIKeyboardAnimationDurationUserInfoKey
 */
@property (nonatomic, assign, readonly) NSTimeInterval animationDuration;

/**
 动画曲线类型， 对应 UIKeyboardAnimationCurveUserInfoKey
 */
@property (nonatomic, assign, readonly) UIViewAnimationCurve animationCurve;

/**
 Keyboard 事件是否发生在是否在当前的App内 对应 UIKeyboardIsLocalUserInfoKey
 */
@property (nonatomic, assign, readonly) BOOL isInCurrentApp NS_AVAILABLE_IOS(9_0);

@end

#pragma mark - DLKeyboardEvent
typedef NSString DLKeyboardEvent;
// 对应 UIKeyboardWillShowNotification
extern DLKeyboardEvent *DLKeyboardEventWillShow;
// 对应 UIKeyboardDidShowNotification
extern DLKeyboardEvent *DLKeyboardEventDidShow;
// 对应 UIKeyboardWillHideNotification
extern DLKeyboardEvent *DLKeyboardEventWillHide;
// 对应 UIKeyboardDidHideNotification
extern DLKeyboardEvent *DLKeyboardEventDidHide;
// 对应 UIKeyboardWillChangeFrameNotification
extern DLKeyboardEvent *DLKeyboardEventWillChangeFrame;
// 对应 UIKeyboardDidChangeFrameNotification
extern DLKeyboardEvent *DLKeyboardEventDidChangeFrame;

#pragma mark - DLKeyboardCallBack
typedef void(^DLKeyboardCallBack)(DLKeyboardInformation *);

#pragma mark - KeyboardManager
@interface DLKeyboardManager : NSObject

/**
 单例
 
 @return DLKeyboardManager
 */
+ (instancetype)sharedManager;


/**
 注册 Keyboard 事件
 
 @param event 事件类型
 @param callBack 事件回调
 */
- (void)registerForEvent:(DLKeyboardEvent *_Nonnull)event callBack:(DLKeyboardCallBack _Nullable)callBack;

/**
 注销 Keyboard事件
 
 @param event 事件类型
 */
- (void)cancellationForEvent:(DLKeyboardEvent *_Nonnull)event;

/**
 注销所有 Keyboard 事件
 */
- (void)cancellationAllEvents;

@end

NS_ASSUME_NONNULL_END
