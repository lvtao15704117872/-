//
//  LT_WebViewController.m
//  monito
//  网页加载控制器
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_WebViewController.h"
#import "LT_oneWebViewController.h"
#import "AppDelegate.h"
#import "NetworkRequests.h"
#import "PrefixHeader.pch"

@interface LT_WebViewController ()<UIScrollViewDelegate>{
    
    navBottomBtnView * view;
    NSArray * Btnarr;
}

@end

@implementation LT_WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor grayColor];
    [self creatScrollView:self.BtnAy];
    [self creatBtn:self.BtnAy];
    [self creatWeb:self.BtnAy];
    [self addClik];
   
}

-(void)creatrightBarButtonItem{
    UIBarButtonItem * rightBtn1 = [[UIBarButtonItem alloc]initWithTitle:@"二维码" style:UIBarButtonItemStyleDone target:self action:@selector(QRcode:)];
    self.navigationItem.rightBarButtonItem = rightBtn1;
}
-(void)creatloadItem{
    UIView * rightview = [[UIView alloc]initWithFrame:CGRectMakeRelative(0, 0, 44, 44)];
    UIButton * loadWeb = [[UIButton alloc]init];
    loadWeb.frame =CGRectMakeRelative(0, 0, 44, 44);
    loadWeb.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [loadWeb setImage:[UIImage imageNamed:@"load.png"] forState:UIControlStateNormal];
    [loadWeb addTarget:self action:@selector(loadWeb) forControlEvents:UIControlEventTouchUpInside];
    [rightview addSubview:loadWeb];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightview];
    self.navigationItem.rightBarButtonItem = rightBtn;
}
-(void)loadWeb{
    NSLog(@"点击查询");
}
-(void)QRcode:(UIButton *)btn{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        SGScanningQRCodeVC *VC = [[SGScanningQRCodeVC alloc] init];
        VC.block = ^(NSString * string){
            NSLog(@"扫描结果%@",string);
        };
        [self.navigationController pushViewController:VC animated:YES];
        
    } else {
        
        SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"未检测到您的摄像头, 请在真机上测试" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
        [alertView show];
    }
    
}
-(void)creatBtn:(NSArray *)arr{
    if (arr.count > 1) {
        view = [[navBottomBtnView alloc]init];
        if (arr.count >5) {
            view.frame =CGRectMakeRelative(0, 0,arr.count*75, 60 );
        }else{
            view.frame = CGRectMakeRelative(0, 0, 375, 50);
        }
        [view creatButton:arr];
        [self.view addSubview:view];
        UIView * pgView = [[UIView alloc]initWithFrame:CGRectMakeRelative(0, 50, 375, 3)];
        pgView.tag = 10;
        [self.view addSubview:pgView];
        for (int i = 0; i<arr.count; i++) {
            UIButton * btn = [[UIButton alloc]init];
            if (i==0) {
                [btn setBackgroundColor:[UIColor redColor]];
            }
            [pgView addSubview:btn];
            if (arr.count<5) {
                btn.frame = CGRectMakeRelative(0+375.0/arr.count*i, 0, 375.0/arr.count, 3 );
            }else{
                btn.frame = CGRectMakeRelative(0+75*i, 0, 75, 3);
            }
            if (i==0) {
                btn.selected = YES;
            }
        }
    }
    
    
}
-(void)creatScrollView:(NSArray *)arr{
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    
    if (arr.count > 1) {
        _scrollView.frame = CGRectMakeRelative(0, 50, 375, 553);
        _scrollView.contentSize = CGSizeMake(375*arr.count, 553);
    }else{
        _scrollView.frame = CGRectMakeRelative(0, 0, 375, 603);
        _scrollView.contentSize = CGSizeMake(375*arr.count, 603);
    }
    [self.view addSubview:_scrollView];
    
}
-(void)creatWeb:(NSArray *)arr{
    if (arr.count > 1) {
        for (int i = 0; i < arr.count; i++) {
            if([arr[i] isEqualToString:@"操作"]){
                _OPView = [[operateView alloc]init];
                _OPView.frame = CGRectMakeRelative(375*i, 4, 375, 553);
                [_scrollView addSubview:_OPView];
                [_OPView.flowBtn addTarget:self action:@selector(operate:) forControlEvents:UIControlEventTouchUpInside];
                [_OPView.sendBtn addTarget:self action:@selector(operate:) forControlEvents:UIControlEventTouchUpInside];
                [_OPView.transmitBtn addTarget:self action:@selector(operate:) forControlEvents:UIControlEventTouchUpInside];
            }else if ([arr[i] isEqualToString:@"基本"]) {
                UIWebView * WebView = [[UIWebView alloc]init];
                WebView.tag = i+1;
                WebView.frame =CGRectMakeRelative(0+375*i, 0, 375, 553);
                [_scrollView addSubview:WebView];
            }else if ([arr[i] isEqualToString:@"现场"]){
                UIWebView * WebView = [[UIWebView alloc]init];
                WebView.tag = i+1;
                WebView.frame =CGRectMakeRelative(0+375*i, 0, 375, 553);
                [_scrollView addSubview:WebView];
            }else if ([arr[i] isEqualToString:@"工况"]){
                UIWebView * WebView = [[UIWebView alloc]init];
                WebView.tag = i+1;
                WebView.frame =CGRectMakeRelative(0+375*i, 0, 375, 553);
                [_scrollView addSubview:WebView];
            }else if ([arr[i] isEqualToString:@"绘图"]){
                UIWebView * WebView = [[UIWebView alloc]init];
                WebView.tag = i+1;
                WebView.frame =CGRectMakeRelative(0+375*i, 0, 375, 553);
                [_scrollView addSubview:WebView];
            }else if ([arr[i] isEqualToString:@"附件"]){
                if ([self.sign isEqualToString:@"enterpriseArchives"]) {
                    //企业档案附件为表格
                    
                }else{
                    UIWebView * WebView = [[UIWebView alloc]init];
                    WebView.tag = i+1;
                    WebView.frame =CGRectMakeRelative(0+375*i, 0, 375, 553);
                    [_scrollView addSubview:WebView];
                }
            }else if ([arr[i] isEqualToString:@"报告"]){
                if ([self.sign isEqualToString:@"enterpriseArchives"]) {
                    //企业档案报告为表格
                    
                }else{
                    UIWebView * WebView = [[UIWebView alloc]init];
                    WebView.tag = i+1;
                    WebView.frame =CGRectMakeRelative(0+375*i, 0, 375, 553);
                    [_scrollView addSubview:WebView];
                }
                
            }else if ([arr[i] isEqualToString:@"监测"]){
                UIWebView * WebView = [[UIWebView alloc]init];
                WebView.tag = i+1;
                WebView.frame =CGRectMakeRelative(0+375*i, 0, 375, 553);
                [_scrollView addSubview:WebView];
            }else if ([arr[i] isEqualToString:@"详细信息"]){
                UIWebView * WebView = [[UIWebView alloc]init];
                WebView.tag = i+1;
                WebView.frame =CGRectMakeRelative(0+375*i, 0, 375, 553);
                [_scrollView addSubview:WebView];
            }else if ([arr[i] isEqualToString:@"流程操作"]){
                _OPView = [[operateView alloc]init];
                _OPView.frame = CGRectMakeRelative(375*i, 4, 375, 553);
                [_OPView creatRollback];
                [self.OPView setButton:self.OPView.transmitBtn WithTittle:@"转办" AndImage:@"backlog"];
                [_scrollView addSubview:_OPView];
                [_OPView.flowBtn addTarget:self action:@selector(operate:) forControlEvents:UIControlEventTouchUpInside];
                [_OPView.sendBtn addTarget:self action:@selector(operate:) forControlEvents:UIControlEventTouchUpInside];
                [_OPView.transmitBtn addTarget:self action:@selector(operate:) forControlEvents:UIControlEventTouchUpInside];
                [_OPView.rollback addTarget:self action:@selector(operate:) forControlEvents:UIControlEventTouchUpInside];
                _OPView.flowBtn.tag     = 1;
                _OPView.sendBtn.tag     = 2;
                _OPView.transmitBtn.tag = 3;
                _OPView.rollback.tag    = 4;
            }else if ([arr[i] isEqualToString:@"信息"]){
                UIWebView * WebView = [[UIWebView alloc]init];
                WebView.tag = i+1;
                WebView.frame =CGRectMakeRelative(0+375*i, 0, 375, 553);
                [_scrollView addSubview:WebView];
            }else if ([arr[i] isEqualToString:@"排口"]){
                //表格
            }else if ([arr[i] isEqualToString:@"项目"]){
                UIWebView * WebView = [[UIWebView alloc]init];
                WebView.tag = i+1;
                WebView.frame =CGRectMakeRelative(0+375*i, 0, 375, 553);
                [_scrollView addSubview:WebView];
            }else if ([arr[i] isEqualToString:@"方案"]){
                UIWebView * WebView = [[UIWebView alloc]init];
                WebView.tag = i+1;
                WebView.frame =CGRectMakeRelative(0+375*i, 0, 375, 553);
                [_scrollView addSubview:WebView];
            }
        }
    }
}
-(void)operate:(UIButton *)btn{
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    LT_oneWebViewController * oneWebCon = [[LT_oneWebViewController alloc]init];
    if (btn.tag == 1) {
        NSLog(@"流程");
        [parameterDic setValue:self.parameter[@"SessionId"] forKey:@"SessionId"];
        oneWebCon.url = @"/Manager/MobileSvc/WorkFlow/FlowLogAnalyseDone.aspx";
        
    }else if (btn.tag == 2){
        NSLog(@"发送");
        [parameterDic setValue:self.parameter[@"FlowInsId"] forKey:@"FlowInsId"];
        [parameterDic setValue:self.parameter[@"SessionId"] forKey:@"SessionId"];
        [parameterDic setValue:self.parameter[@"TempId"] forKey:@"TempId"];
        [parameterDic setValue:self.parameter[@"LinkInsId"] forKey:@"LinkInsId"];
        [parameterDic setValue:self.parameter[@"UserCName"] forKey:@"UserCName"];
        [parameterDic setValue:self.parameter[@"UserCode"] forKey:@"UserCode"];
        [parameterDic setValue:self.parameter[@"UserId"] forKey:@"UserId"];
        oneWebCon.url = @"/Manager/MobileSvc/WorkFlow/NewVersion/TaskSubmit.aspx";
        
    }else if (btn.tag == 3){
        NSLog(@"转办");
        [parameterDic setValue:self.parameter[@"FlowInsId"] forKey:@"FlowInsId"];
        [parameterDic setValue:self.parameter[@"SessionId"] forKey:@"SessionId"];
        [parameterDic setValue:self.parameter[@"TempId"] forKey:@"TempId"];
        [parameterDic setValue:self.parameter[@"LinkInsId"] forKey:@"LinkInsId"];
        [parameterDic setValue:self.parameter[@"UserCName"] forKey:@"UserCName"];
        [parameterDic setValue:self.parameter[@"UserCode"] forKey:@"UserCode"];
        [parameterDic setValue:self.parameter[@"UserId"] forKey:@"UserId"];
        oneWebCon.url = @"/Manager/MobileSvc/WorkFlow/TaskTransfer.aspx";
        
    }else if (btn.tag == 4){
        NSLog(@"回退");
        [parameterDic setValue:self.parameter[@"FlowInsId"] forKey:@"FlowInsId"];
        [parameterDic setValue:self.parameter[@"SessionId"] forKey:@"SessionId"];
        [parameterDic setValue:self.parameter[@"TempId"] forKey:@"TempId"];
        [parameterDic setValue:self.parameter[@"LinkInsId"] forKey:@"LinkInsId"];
        [parameterDic setValue:self.parameter[@"UserCName"] forKey:@"UserCName"];
        [parameterDic setValue:self.parameter[@"UserCode"] forKey:@"UserCode"];
        [parameterDic setValue:self.parameter[@"UserId"] forKey:@"UserId"];
        oneWebCon.url = @"/Manager/MobileSvc/WorkFlow/NewVersion/TaskSpanBack.aspx";
        
    }
    oneWebCon.parameter = parameterDic;
    [self.navigationController pushViewController:oneWebCon animated:YES];

}
-(void)addClik{
    
    Btnarr = [[NSArray alloc]initWithArray:view.subviews];
    for (int i = 0; i < Btnarr.count; i++) {
        [Btnarr[i] addTarget:self action:@selector(clik:) forControlEvents:UIControlEventTouchUpInside];
        UIButton * btn = Btnarr[i];
        if ([btn.titleLabel.text isEqualToString:@"基本"]||[btn.titleLabel.text isEqualToString:@"详细信息"]) {
            [Btnarr[i] sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }
    
}
//点击事件
-(void)clik:(UIButton *)btn{
    Btnarr = [[NSArray alloc]initWithArray:view.subviews];
    NSLog(@"点击事件 %@",btn.titleLabel.text);
    UIView * vi= [self.view viewWithTag:10];
    for (int i = 0; i < vi.subviews.count; i++) {
        if (vi.subviews[i].frame.origin.x == btn.frame.origin.x) {
            vi.subviews[i].backgroundColor = [UIColor redColor];
        }else{
            vi.subviews[i].backgroundColor = [UIColor whiteColor];
        }
    }
    _scrollView.contentOffset = CGPointMake(btn.frame.origin.x/btn.frame.size.width*self.view.frame.size.width, 0);

    if (btn.selected == YES) {
        
    }else{
        for (int i = 0; i < Btnarr.count; i++) {
            if (btn != Btnarr[i]) {
                UIButton * temp = Btnarr[i];
                temp.selected = NO;
                temp.enabled  = YES;
            }
        }
        btn.selected = YES;
    }
   
    //btn  超过5个
    if ((Btnarr.count > 5)&&(btn.frame.origin.x<=btn.frame.size.width*2)) {
        view.frame = CGRectMakeRelative(0, 0, 375, 50);
        vi.frame = CGRectMakeRelative(0, 50, 375, 3);
    }
    if ((Btnarr.count > 5)&&(btn.frame.origin.x>=btn.frame.size.width*3)) {
        view.frame = CGRectMakeRelative(-btn.frame.size.width, 0, self.BtnAy.count*75, 50);
        vi.frame = CGRectMakeRelative(-btn.frame.size.width, 50, self.BtnAy.count*75, 3);
    }
    
    [self clickButton:btn];
}
#pragma 网页请求
-(void)clickButton:(UIButton *)btn{
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    if ([btn.titleLabel.text isEqualToString:@"详细信息"]) {
        
        [parameterDic setValue:self.parameter[@"FlowInsID"] forKey:@"FlowInsID"];
        [parameterDic setValue:self.parameter[@"LinkInsId"] forKey:@"LinkInsId"];
        [parameterDic setValue:self.parameter[@"SessionId"] forKey:@"SessionId"];
        [parameterDic setValue:self.parameter[@"UserCName"] forKey:@"UserCName"];
        [parameterDic setValue:self.parameter[@"UserCode"] forKey:@"UserCode"];
        [parameterDic setValue:self.parameter[@"UserId"] forKey:@"UserId"];
        [parameterDic setValue:self.parameter[@"businessId"] forKey:@"businessId"];
        [parameterDic setValue:self.parameter[@"entity_name"] forKey:@"entity_name"];
        [parameterDic setValue:self.parameter[@"link_code"] forKey:@"link_code"];
        [parameterDic setValue:self.parameter[@"taskId"] forKey:@"taskId"];
        if (self.flag == 0) {
            [NetworkRequests requestWebWithparameters:parameterDic andWithURL:@"/Manager/MobileSvc/Analyse/ListViewItem.aspx" Success:^(NSString *str) {
                NSArray * subView =[_scrollView subviews];
                for (id obj in subView) {
                    if ([obj isKindOfClass:[UIWebView class]]) {
                        UIWebView * web = obj;
                        [web loadHTMLString:str baseURL:nil];
                    }
                }
            } failure:^(NSDictionary *dic) {
                NSLog(@"请求失败");
            }];
        }
        if (self.flag ==1) {
            [NetworkRequests requestWebWithparameters:parameterDic andWithURL:@"/Manager/MobileSvc/Analyse/ListViewItem.aspx" Success:^(NSString *str) {
                NSArray * subView =[_scrollView subviews];
                for (id obj in subView) {
                    if ([obj isKindOfClass:[UIWebView class]]) {
                        UIWebView * web = obj;
                        [web loadHTMLString:str baseURL:nil];
                    }
                }
            } failure:^(NSDictionary *dic) {
                NSLog(@"请求失败");
            }];
        }
        
        
    }else if ([btn.titleLabel.text isEqualToString:@"信息"]){
        if ([self.sign isEqualToString:@"examining"]) {
            [parameterDic setValue:self.parameter[@"CMD"] forKey:@"CMD"];
            [parameterDic setValue:self.parameter[@"EmergencyId"] forKey:@"EmergencyId"];
            [self requestWebWithparametre:parameterDic andURL:@"/Manager/MobileSvc/MeetEmergency/MeetEmergency.aspx" andNum:0];
        }else{
            [parameterDic setValue:self.parameter[@"CMD"] forKey:@"CMD"];
            [parameterDic setValue:self.parameter[@"UnitId"] forKey:@"UnitId"];
            [parameterDic setValue:self.parameter[@"UnitName"] forKey:@"UnitName"];
            [parameterDic setValue:self.parameter[@"UserId"] forKey:@"UserId"];
            [self requestWebWithparametre:parameterDic andURL:@"/Manager/MobileSvc/Unit/UnitManager.aspx" andNum:0];
        }
        
    }else if ([btn.titleLabel.text isEqualToString:@"报告"]){
        [parameterDic setValue:self.parameter[@"endtime"] forKey:@"endtime"];
        [parameterDic setValue:self.parameter[@"endtime"] forKey:@"keyword"];
        [parameterDic setValue:self.parameter[@"password"] forKey:@"password"];
        [parameterDic setValue:self.parameter[@"starttime"] forKey:@"starttime"];
        [parameterDic setValue:self.parameter[@"username"] forKey:@"username"];
        [self requstDatasourceWithParameter:parameterDic andURL:@"/Manager/MobileSvc/MonTaskSvc.asmx/taskAllList2"];
    }else if ([btn.titleLabel.text isEqualToString:@"监测"]){
        [parameterDic setValue:self.parameter[@"CMD"] forKey:@"CMD"];
        [parameterDic setValue:self.parameter[@"UnitId"] forKey:@"UnitId"];
        [parameterDic setValue:self.parameter[@"UnitName"] forKey:@"UnitName"];
        [parameterDic setValue:self.parameter[@"UserId"] forKey:@"UserId"];
        [parameterDic setValue:self.parameter[@"unit_outfall_id"] forKey:@"unit_outfall_id"];
        [self requestWebWithparametre:parameterDic andURL:@"/Manager/MobileSvc/GIS/Pollution/PollutionWater.aspx" andNum:1];
        
    }else if ([btn.titleLabel.text isEqualToString:@"附件"]){
        [parameterDic setValue:self.parameter[@"password"] forKey:@"password"];
        [parameterDic setValue:self.parameter[@"unitid"] forKey:@"unitid"];
        [parameterDic setValue:self.parameter[@"username"] forKey:@"username"];
        
        [self requstDatasourceWithParameter:parameterDic andURL:@"/Manager/MobileSvc/MonTaskSvc.asmx/unitfileList"];
        
    }else if ([btn.titleLabel.text isEqualToString:@"排口"]){
        [parameterDic setValue:self.parameter[@"password"] forKey:@"password"];
        [parameterDic setValue:self.parameter[@"unitid"] forKey:@"unitid"];
        [parameterDic setValue:self.parameter[@"username"] forKey:@"username"];
        
        [self requstDatasourceWithParameter:parameterDic andURL:@"/Manager/MobileSvc/PollutionUnitSvc.asmx/outfallList"];
        
    }else if ([btn.titleLabel.text isEqualToString:@"工况"]){
        [parameterDic setValue:self.parameter[@"CMD"] forKey:@"CMD"];
        [parameterDic setValue:self.parameter[@"UnitId"] forKey:@"UnitId"];
        [parameterDic setValue:self.parameter[@"UnitName"] forKey:@"UnitName"];
        [parameterDic setValue:self.parameter[@"UserId"] forKey:@"UserId"];
        [self requestWebWithparametre:parameterDic andURL:@"/Manager/MobileSvc/Sample/ConditionUnit.aspx" andNum:2];
        
    }else if ([btn.titleLabel.text isEqualToString:@"项目"]){
        [parameterDic setValue:self.parameter[@"CMD"] forKey:@"CMD"];
        [parameterDic setValue:self.parameter[@"EmergencyId"] forKey:@"EmergencyId"];
        [self requestWebWithparametre:parameterDic andURL:@"/Manager/MobileSvc/MeetEmergency/MeetItem.aspx" andNum:1];
        
    }else if ([btn.titleLabel.text isEqualToString:@"方案"]){
        [parameterDic setValue:self.parameter[@"CMD"] forKey:@"CMD"];
        [parameterDic setValue:self.parameter[@"EmergencyId"] forKey:@"EmergencyId"];
        [self requestWebWithparametre:parameterDic andURL:@"/Manager/MobileSvc/MeetEmergency/MeetScheme.aspx" andNum:2];
        
    }
    
}
//网络请求
-(void)requestWebWithparametre:(NSDictionary *)parameter andURL:(NSString *)url andNum:(int)num{
    [NetworkRequests requestWebWithparameters:parameter andWithURL:url Success:^(NSString *str) {
        NSArray * subView =[_scrollView subviews];
        NSMutableArray * webViewAy = [[NSMutableArray alloc]init];
        for (id obj in subView) {
            if ([obj isKindOfClass:[UIWebView class]]) {
                [webViewAy addObject:obj];
            }
        }
        UIWebView * web = webViewAy[num];
        [web loadHTMLString:str baseURL:nil];
    } failure:^(NSDictionary *dic) {
        NSLog(@"请求失败");
    }];
}

#pragma mark - 表格数据请求
-(void)requstDatasourceWithParameter:(NSDictionary *)parameter andURL:(NSString *)url{
    [NetworkRequests requestWithparameters:parameter andWithURL:url Success:^(NSDictionary *dic) {
        
    } failure:^(NSDictionary *dic) {
        
    }];
}
//滚动协议
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // called when scroll view grinds to a halt
    UIView * vi= [self.view viewWithTag:10];
    NSArray * btn = [view subviews];
    for (int i = 0; i < vi.subviews.count; i++) {
        if ((vi.subviews[i].frame.origin.x/vi.subviews[i].frame.size.width) == (scrollView.contentOffset.x/scrollView.frame.size.width)) {
            vi.subviews[i].backgroundColor = [UIColor redColor];
            //btn  超过5个
            UIButton * Btn = btn[i];
            if ((Btnarr.count > 5)&&(Btn.frame.origin.x==Btn.frame.size.width*2)) {
                view.frame = CGRectMakeRelative(0, 0, 375, 50);
                vi.frame = CGRectMakeRelative(0, 50, 375, 3);
            }
            if ((Btnarr.count > 5)&&(Btn.frame.origin.x==Btn.frame.size.width*3)) {
                view.frame = CGRectMakeRelative(-Btn.frame.size.width, 0, self.BtnAy.count*75, 50);
                vi.frame = CGRectMakeRelative(-Btn.frame.size.width, 50, self.BtnAy.count*75, 3);
            }
            for (int j=0; j<btn.count; j++) {
                
                if (j==i) {
                    [btn[j] setValue:@"YES" forKey:@"selected"];
                }else{
                    [btn[j] setValue:@"NO" forKey:@"selected"];
                }
                
                
            }
        }else{
            vi.subviews[i].backgroundColor = [UIColor whiteColor];
        }
    }
    
}

CG_INLINE CGRect
CGRectMakeRelative(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
{
    //创建appDelegate 在这不会产生类的对象,(不存在引起循环引用的问题)
    AppDelegate * app = (id)[UIApplication sharedApplication].delegate;
    
    //计算返回
    return CGRectMake(x * app.autoSizeScaleX, y * app.autoSizeScaleY, width * app.autoSizeScaleX, height * app.autoSizeScaleY);
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
