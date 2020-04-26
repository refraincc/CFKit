//
//  WKWebView+Core.h
//  CFKit
//
//  Created by cc on 2020/4/26.
//

//#import <AppKit/AppKit.h>

#import <WKWebView+Core.h>


typedef void (^completion)(NSString *content);

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (Core)


//标题
- (void)cc_getTitle:(completion)completion;
//描述
- (void)cc_getDescription:(completion)completion;

//图片
- (void)cc_getImageURL:(completion)completion;

//网页域名
- (void)cc_getDomain:(completion)completion;

//网页地址
- (void)cc_getAdderss:(completion)completion;

//获得是否隐藏右上角三个点的菜单的标识 "hide", "show" ,""或空
- (void)cc_menuIsHidden:(completion)completion;


@end

NS_ASSUME_NONNULL_END
