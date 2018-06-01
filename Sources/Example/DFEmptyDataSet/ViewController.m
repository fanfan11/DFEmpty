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
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 20, 100, 40)];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 60) style:UITableViewStylePlain];
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

- (void)clickBtn {
    self.hasData = !self.hasData;
    self.count ++;
    [self.tableView reloadData];
    
//    ViewController *vc = [[ViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
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
}


#pragma mark ============
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"标题";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:20.0],
                                 NSForegroundColorAttributeName: [UIColor grayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"暂无数据";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0],
                                 NSForegroundColorAttributeName: [UIColor grayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -50;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.isLoading) {
        return [UIImage imageNamed:@"loading"];
    } else {
        return [UIImage imageNamed:@"aa"];
    }
}


- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    return [UIImage imageNamed:@"bb"];
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

}



@end
