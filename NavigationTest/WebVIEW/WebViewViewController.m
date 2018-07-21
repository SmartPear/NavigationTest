//
//  WebViewViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/5/17.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "WebViewViewController.h"
#import <WebKit/WebKit.h>
@interface WebViewViewController ()<UIWebViewDelegate>;
@property (nonatomic,strong)UIWebView * webView;
@property (nonatomic,strong)UIProgressView * progressView;
@property (nonatomic,strong)UIButton * loadBtn;
@end

@implementation WebViewViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    NSString * str = @"http://tjgaj.gov.cn/";
    NSURL * url = [NSURL URLWithString:str];
    
    NSURLRequest * requset = [[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:requset];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(64);
        make.top.equalTo(self.view);
        make.height.equalTo(@2);
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.loadBtn];

    // Do any additional setup after loading the view.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    if ([keyPath isEqual:@"estimatedProgress"] && object == self.webView) {
//        [self.progressView setAlpha:1.0f];
//        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
//        if (self.webView.estimatedProgress  >= 1.0f) {
//            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
//                [self.progressView setAlpha:0.0f];
//            } completion:^(BOOL finished) {
//                [self.progressView setProgress:0.0f animated:YES];
//            }];
//        }
//    }else{
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"%@",error);
}
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
        
    }
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"结束");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self loadAction:self.loadBtn];
    NSLog(@"失败");
}
-(void)loadAction:(UIButton*)btn{

    NSString * str = @"http://tjgaj.gov.cn/";
    NSURL * url = [NSURL URLWithString:str];
    NSURLRequest * requset = [[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:requset];
}
-(UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]init];
        _progressView.tintColor = [UIColor redColor];
        _progressView.trackTintColor = [UIColor yellowColor];
    }return _progressView;
}
-(UIWebView*)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate = self;
    }return _webView;
}
-(UIButton *)loadBtn{
    if (!_loadBtn) {
        _loadBtn = [[UIButton alloc]init];
        [_loadBtn addTarget:self action:@selector(loadAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_loadBtn setTitle:@"刷新" forState:(UIControlStateNormal)];
        [_loadBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _loadBtn.frame = CGRectMake(0, 0, 60, 40);
    }return _loadBtn;
}
-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
