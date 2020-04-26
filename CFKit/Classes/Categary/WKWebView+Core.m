//
//  WKWebView+Core.m
//  CFKit
//
//  Created by cc on 2020/4/26.
//
#import <WebKit/WebKit.h>
#import "WKWebView+Core.h"

//#import <AppKit/AppKit.h>


@implementation WKWebView (Core)

- (void)cc_getTitle:(completion)completion{
    NSString *titleJs1 = @"document.querySelector(\'meta[name=\"title\"]\') ?document.querySelector(\'meta[name=\"title\"]\').getAttribute(\'content\'):\'\';";
    NSString *titleJs2 = @"document.querySelector(\'meta[property=\"og:title\"]\')?document.querySelector(\'meta[property=\"og:title\"]\').getAttribute(\'content\'):\'\';";
    NSString *titleJs3 = @"document.querySelector(\'meta[property=\"og:site_name\"]\')?document.querySelector(\'meta[property=\"og:site_name\"]\').getAttribute(\'content\'):\'\';";
    NSString *titleJs4 = @"document.querySelector(\'meta[name=\"twitter:title\"]\')?document.querySelector(\'meta[name=\"twitter:title\"]\').getAttribute(\'content\'):\'\';";
    NSString *titleJs5 = @"document.title;";
    
    
    [self evaluateJavaScript:titleJs1 completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
        if (result  && result.length) {
            completion(result);
        } else {
            [self evaluateJavaScript:titleJs2 completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
                if (result && result.length) {
                    completion(result);
                } else {
                    [self evaluateJavaScript:titleJs3 completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
                        if (result && result.length) {
                            completion(result);
                        } else {
                            [self evaluateJavaScript:titleJs4 completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
                                if (result && result.length) {
                                    completion(result);
                                } else {
                                    [self evaluateJavaScript:titleJs5 completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
                                        if (result && result.length) {
                                            completion(result);
                                        } else {
                                            completion(@"No Title");
                                        }
                                    }];
                                }
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}

//描述
- (void)cc_getDescription:(completion)completion{
    NSString *contentJs1 = @"document.querySelector(\'meta[name=\"description\"]\')?document.querySelector(\'meta[name=\"description\"]\').getAttribute(\'content\'):\'\';";
    
    NSString *contentJs2 = @"document.querySelector(\'meta[property=\"og:description\"]\')?document.querySelector(\'meta[property=\"og:description\"]\').getAttribute(\'content\'):\'\';";
    
    NSString *contentJs3 = @"document.querySelector(\'meta[name=\"twitter:description\"]\')?document.querySelector(\'meta[name=\"twitter:description\"]\').getAttribute(\'content\'):\'\';";    NSString *contentJs4 = self.URL.absoluteString ?: @"";
    
    [self evaluateJavaScript:contentJs1 completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
        if (result && result.length) {
            completion(result);
        } else {
            [self evaluateJavaScript:contentJs2 completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
                if (result && result.length) {
                    completion(result);
                } else {
                    [self evaluateJavaScript:contentJs3 completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
                        if (result && result.length) {
                            completion(result);
                        } else {
                            completion(contentJs4);
                        }
                    }];
                }
            }];
        }
    }];
}

//图片
- (void)cc_getImageURL:(completion)completion{
    
    NSString *imgJs0 = @"document.querySelector(\'meta[property=\"blued-screenshot\"]\')?document.querySelector(\'meta[property=\"blued-screenshot\"]\').getAttribute(\'content\'):\'\';";
    
    NSString *imgJs1 = @"document.querySelector(\'meta[property=\"og:image:secure_url\"]\')?document.querySelector(\'meta[property=\"og:image:secure_url\"]\').getAttribute(\'content\'):\'\';";
    
    NSString *imgJs2 = @"document.querySelector(\'meta[property=\"og:image\"]\')?document.querySelector(\'meta[property=\"og:image\"]\').getAttribute(\'content\'):\'\';";
    
    NSString *imgJs3 = @"document.querySelector(\'meta[name=\"twitter:image\"]\')?document.querySelector(\'meta[name=\"twitter:image\"]\').getAttribute(\'content\'):\'\';";
    
    NSString *imgJs4 = @"document.querySelector(\'link[rel=\"image_src\"]\')?document.querySelector(\'link[rel=\"image_src\"]\').getAttribute(\'href\'):\'\';";
    
    NSString *imgJs5 = @"document.querySelector(\'link[rel=\"apple-touch-icon\"]\')?document.querySelector(\'link[rel=\"apple-touch-icon\"]\').getAttribute(\'href\'):\'\';";
    
    NSString *imgJs6 = @"document.getElementsByTagName(\"img\")[0].src;";
    
    [self evaluateJavaScript:imgJs0 completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
        if (result && result.length) {
            completion(result);
        } else {
            [self evaluateJavaScript:imgJs1 completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
                if (result && result.length) {
                    completion(result);
                } else {
                    [self evaluateJavaScript:imgJs2 completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
                        if (result && result.length) {
                            completion(result);
                        } else {
                            [self evaluateJavaScript:imgJs3 completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
                                if (result && result.length) {
                                    completion(result);
                                } else {
                                    [self evaluateJavaScript:imgJs4 completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
                                        if (result && result.length) {
                                            completion(result);
                                        } else {
                                            [self evaluateJavaScript:imgJs5 completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
                                                if (result && result.length) {
                                                    completion(result);
                                                } else {
                                                    [self evaluateJavaScript:imgJs6 completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
                                                        if (result && result.length) {
                                                            completion(result);
                                                        } else {
                                                            completion(@"");
                                                        }
                                                    }];
                                                }
                                            }];
                                        }
                                    }];
                                }
                            }];
                        }
                    }];
                }
            }];
        }
    }];
}

//网页域名
- (void)cc_getDomain:(completion)completion{
    [self evaluateJavaScript:@"document.domain" completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
        if (result && result.length) {
            completion(result);
        } else {
            completion(@"About: blank");
        }
    }];
}

//网页地址
- (void)cc_getAdderss:(completion)completion{
    [self evaluateJavaScript:@"document.location.href" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (result) {
            completion(result);
        } else {
            completion(@"");
        }
    }];
}

// "hide", "show" ,""或空
- (void)cc_menuIsHidden:(completion)completion {
    [self evaluateJavaScript:@"document.querySelector(\'meta[name=\"option-menu\"]\')?document.querySelector(\'meta[name=\"option-menu\"]\').getAttribute(\'content\'):\'\'" completionHandler:^(NSString * _Nullable result, NSError * _Nullable error) {
        if (completion) {
            if (result ==nil || [result isKindOfClass:[NSNull class]]) {
                return ;
            }
            completion(result);
        }
    }];
}



@end
