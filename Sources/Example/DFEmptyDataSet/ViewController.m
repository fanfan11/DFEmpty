//
//  ViewController.m
//  DFEmptyDataSet
//
//  Created by user on 24/5/18.
//  Copyright © 2018年 Fanfan. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+EmptyData.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, DFEmptyDataSetSource, DFEmptyDataSetDelegate>
@property (nonatomic, assign) BOOL hasData;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) BOOL isLoading;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
}

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorColor = [UIColor blackColor];
    tableView.rowHeight = 44.0f;
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    
    
}

- (void)loadData {
    self.isLoading = NO;
    self.hasData = !self.hasData;
    self.count ++;
    [self.tableView reloadData];
    
//    ViewController *vc = [[ViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
}

- (void)reloadData {
    self.isLoading = YES;
    [self.tableView reloadEmptyDataSet];
    [self performSelector:@selector(loadData) withObject:nil afterDelay:3];
}



#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hasData ? self.count * 10 : 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%tu", indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self loadData];
}


#pragma mark ============
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.isLoading) {
        return nil;
    }
    NSString *text = @"暂无数据";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:20.0],
                                 NSForegroundColorAttributeName: [UIColor blackColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"数据空空如也，快去添加数据吧。等你一起来玩";
    if (self.isLoading) {
        text = @"加载中，请稍等";
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0],
                                 NSForegroundColorAttributeName: [UIColor grayColor],
                                 NSParagraphStyleAttributeName: paragraphStyle
                                 };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if (self.isLoading) {
        return nil;
    }
    NSString *text = @"点击刷新";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:37.0/255 green:150.0/255 blue:217.0/255 alpha:1.0]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -50;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 25;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.isLoading) {
        return [UIImage imageNamed:@"loading"];
    } else {
        return [UIImage imageNamed:@"aa"];
    }
}



//图片动画
- (CAAnimation *) imageAnimationForEmptyDataSet:(UIScrollView *) scrollView{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima.toValue = @(M_PI*2);
    anima.duration = 1.5f;
    anima.repeatCount = MAX_CANON;
    return anima;
}


- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return self.isLoading;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    NSLog(@"didTapView");
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    NSLog(@"didTapButton");
    
    [self reloadData];

}



@end
