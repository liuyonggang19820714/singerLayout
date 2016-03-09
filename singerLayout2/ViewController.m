//
//  ViewController.m
//  singerLayout2
//
//  Created by 极客学院 on 16/3/8.
//  Copyright © 2016年 极客学院. All rights reserved.
//

#import "ViewController.h"
#import "singerModel.h"


#define Ymargin 40         // view距离控制器view顶部的距离
#define viewYmargin 25     // view和viewY方向间距
#define viewWidth 80       // view的宽度
#define viewHeight 100     // view的高度

#define column 3           // 列数

@interface ViewController ()

// 保存plist文件里读出来的所有模型
@property(nonatomic,strong)NSMutableArray*arrayAll;

@end

@implementation ViewController

// 懒加载
-(NSMutableArray*)arrayAll
{
    if (!_arrayAll) {
        // 初始化
        _arrayAll = [NSMutableArray array];
        
        NSString*strPath = [[NSBundle mainBundle]pathForResource:@"picList.plist" ofType:nil];
        
        NSArray*array = [NSArray arrayWithContentsOfFile:strPath];
        
        for (NSDictionary*dict in array) {
            singerModel*model = [singerModel singerModelWithDict:dict];
            
            [_arrayAll addObject:model];
        }
        
    }
    
    return _arrayAll;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self arrayAll];
    
    int iXmargin = (self.view.frame.size.width - (viewWidth*column))/(column+1);
    
    for (int i = 0; i < 9; i++) {
        
        if (i< self.arrayAll.count) {
            singerModel*model2 = self.arrayAll[i];
            
            int iColumn = i%column;     // 确定列
            int iRow = i/column;        // 确定行
            
            int x = iXmargin +(viewWidth+iXmargin)*iColumn;
            int y = Ymargin +(viewHeight+ viewYmargin)*iRow;
            
            UIView*view1 = [[UIView alloc]initWithFrame:CGRectMake(x, y , viewWidth, viewHeight)];
            //  view1.backgroundColor = [UIColor redColor];
            [self.view addSubview:view1];
            
            [self addSubControl:view1 model:model2];
        }
        
        
    }
}

-(void)addSubControl:(UIView*)uiviewParent model:(singerModel*)model1
{
    CGRect rectPar = uiviewParent.bounds;
    
    // 添加图片控件
    UIImageView*imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rectPar.size.width, 50)];
    imgView.image = [UIImage imageNamed:model1.pic];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [uiviewParent addSubview:imgView];
    
    // 添加歌曲名label
    UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, rectPar.size.width, 20)];
   // label.backgroundColor = [UIColor orangeColor];
    label.text = model1.songname;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    
    [uiviewParent addSubview:label];
    
    UIButton*btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 80, rectPar.size.width, 20)];
    //btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"下载" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setBackgroundImage:[UIImage imageNamed:@"normal"] forState:UIControlStateNormal];
    
     [btn setBackgroundImage:[UIImage imageNamed:@"highlighted"] forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    
    [uiviewParent addSubview:btn];
    
    
}

-(void)download
{
    UILabel*tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 400, 100, 30)];
    tipLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tipLabel];
    tipLabel.alpha = 1;
    tipLabel.text = @"下载完成";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    
    // UIView 动画函数 动画持续时间为2秒
    [UIView animateWithDuration:2.0 animations:^{
        tipLabel.alpha = 0;     // 具体执行的动画
        
    } completion:^(BOOL finished) {
        [tipLabel removeFromSuperview];     // 动画完成后执行的操作
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
