//
//  ViewController.m
//  kd_study
//
//  Created by hour on 2018/8/14.
//  Copyright © 2018 hour. All rights reserved.
//

#import "ViewController.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/UIImage+ForceDecode.h>

#import "kd_study-Swift.h"

#import "DispatchTest.h"

#import "RuntimeDemo.h"
#import "KDLayerVC.h"
#import "KDAnimationVC.h"
#import "OffScreenRenderVC.h"
#import "AttrStrVC.h"

#import "RunLoopTest.h"
#import "TestObject.h"
#import "TestCompare.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
}
@property (nonatomic, strong) NSArray<KDHomeSectionModel *> *models;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) NSTextStorage *textStorage;

@property (nonatomic, strong) TestObject* testObj;


@property (nonatomic, strong) CALayer *layer1;

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        while (true) {
//            //
//        }
//    });
    
//    [[[Hello alloc] init] hello];
//    [DispatchTest test];

    [self setupView];
//    [self testImageLoad];
//    [self testTextView];
//    [self testKVO];
//    [RuntimeDemo test];
//    [TestCompare test];
//    [RunLoopTest test];
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"=1== %@", [NSThread currentThread]);
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiTask:) name:UIApplicationDidBecomeActiveNotification object:nil];
//    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//    NSLog(@"111");
}

- (void)setupView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)testKVO {
    self.testObj = [[TestObject alloc] init];
    
//    [self.testObj addObserver:self
//                   forKeyPath:@"name"
//                      options:NSKeyValueObservingOptionInitial
//                            | NSKeyValueObservingOptionNew
//                            | NSKeyValueObservingOptionOld
//                      context:nil];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.testObj.name = @"222";
//    });
    
    [self testKVOTheory];
}

- (void)testKVOTheory {
    NSLog(@"class-withOutKVO: %@ \n", object_getClass(_testObj));
    NSLog(@"setterAdress-withOutKVO: %p \n", [_testObj methodForSelector:@selector(setAName:)]);
    [_testObj addObserver:self forKeyPath:@"aName" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:(__bridge void *)(self)];
    NSLog(@"class-addKVO class: %@ \n", [_testObj class]);
    NSLog(@"class-addKVO get class: %@ \n", object_getClass(_testObj));
    NSLog(@"setterAdress-addKVO: %p \n", [_testObj methodForSelector:@selector(setAName:)]);
    [_testObj removeObserver:self forKeyPath:@"aName"];
    NSLog(@"class-removeKVO: %@", object_getClass(_testObj));
    NSLog(@"setterAdress-removeKVO: %p \n", [_testObj methodForSelector:@selector(setAName:)]);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"keyPath:%@, object:%@, change:%@", keyPath, object, change);
}

- (CADisplayLink *)displayLink {
    if (_displayLink == nil) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayStep:)];
//        _displayLink.preferredFramesPerSecond = 6000;
//        _displayLink.frameInterval = 6000;
    }
    
    return _displayLink;
}

- (void)displayStep:(CADisplayLink *)displayLink {
    NSLog(@"%@", displayLink);
//    self.title = [NSString stringWithFormat:@"%f", displayLink.timestamp];
    self.title = [NSString stringWithFormat:@"%f", 1 / displayLink.duration];
}

#pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    KDHomeSectionModel *sectionModel = [self.models objectAtIndex:section];

    return sectionModel.rowModels.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    KDHomeSectionModel *sectionModel = [self.models objectAtIndex:section];
    
    return sectionModel.title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewCell"];
    }
    
    KDHomeSectionModel *sectionModel = [self.models objectAtIndex:indexPath.section];
    KDHomeRowModel *model = [sectionModel.rowModels objectAtIndex:indexPath.row];
    cell.textLabel.text = model.title;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    
    KDHomeSectionModel *sectionModel = [self.models objectAtIndex:indexPath.section];
    KDHomeRowModel *model = [sectionModel.rowModels objectAtIndex:indexPath.row];
    switch (model.type) {
        case KDHomeModelCALayer: {
            UIViewController *vc = [[KDLayerVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case KDHomeModelAnimation: {
            UIViewController *vc = [[KDAnimationVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case KDHomeModelOffScreen: {
            UIViewController *vc = [[OffScreenRenderVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case KDHomeModelAttrStr: {
            UIViewController *vc = [[AttrStrVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)testImageLoad {
    [self.view addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(40);
        make.left.mas_equalTo(self.view);
        
        make.width.height.mas_equalTo(300);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UIImage *img = [UIImage imageNamed:@"3"];
        UIImage *img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"3" ofType:@"png"]];

                img = [UIImage decodedImageWithImage:img];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.imgView.image = img;
        });
    });
}

- (void)testTextView {
    CGRect textViewRect = CGRectInset(self.view.bounds, 10.0, 20.0);
    
    // NSTextContainer
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:CGSizeMake(10, CGFLOAT_MAX)];
//    container.widthTracksTextView = YES;
    
    // NSLayoutManager
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [layoutManager addTextContainer:container];
    
    // NSTextStorage
    self.textStorage = [[NSTextStorage alloc] init];
    [self.textStorage addLayoutManager:layoutManager];
    
    // UITextView
    UITextView *newTextView = [[UITextView alloc] initWithFrame:textViewRect textContainer:container];
    newTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    newTextView.scrollEnabled = YES;
    newTextView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.textView = newTextView;
    [self.view addSubview:self.textView];
    
    [self.textStorage beginEditing];
    
    NSMutableAttributedString *mutableAttrString = [[NSMutableAttributedString alloc] initWithString:@"Letterpress" attributes:@{NSTextEffectAttributeName: NSTextEffectLetterpressStyle}];
    [mutableAttrString appendAttributedString:[[NSAttributedString alloc] initWithString:@" \n 234"]];
    [mutableAttrString appendAttributedString:[[NSAttributedString alloc] initWithString:@" \n 567"]];
    
    [self.textStorage setAttributedString:mutableAttrString];
    
    [self.textStorage endEditing];
}

- (void)notiTask:(NSNotification *)not {
    NSLog(@"=== %@", [NSThread currentThread]);
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
//        _imgView.clipsToBounds = YES;
//        _imgView.image = [UIImage imageNamed:@"2"];
        
        UIImage *img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"png"]];
        _imgView.image = img;
        
//        _imgView.contentMode = UIViewContentModeTop;
//        _imgView.contentMode = UIViewContentModeRedraw;
    }
    
    return _imgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    NSLog(@"");
    
    return YES;
}

- (void)cut:(id)sender {
    NSLog(@"");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *arrayTouch = [touches allObjects];
    UITouch *touch = (UITouch *)[arrayTouch lastObject];
    CGFloat force = touch.force;
    NSLog(@"压力值为 %f",force);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    // 事物可以嵌套
    [CATransaction begin];
    self.layer1.zPosition = 200.0;
    [CATransaction setValue:@(1.0) forKey:kCATransactionAnimationDuration];
    
    [CATransaction begin];
//    [CATransaction setValue:@(NO) forKey:kCATransactionDisableActions];
    [CATransaction setValue:@(3.0) forKey:kCATransactionAnimationDuration];
    self.layer1.opacity = 0.0;
    
    [CATransaction commit];
    [CATransaction commit];
}

- (NSArray<KDHomeSectionModel *> *)models {
    if (_models == nil) {
        NSMutableArray<KDHomeSectionModel *> *models = @[].mutableCopy;
        
        NSArray *rows = @[
            [[KDHomeRowModel alloc] initWithType:KDHomeModelCALayer title:@"CALayer 子类"],
            [[KDHomeRowModel alloc] initWithType:KDHomeModelAnimation title:@"动画"],
            [[KDHomeRowModel alloc] initWithType:KDHomeModelOffScreen title:@"离屏渲染"],
            [[KDHomeRowModel alloc] initWithType:KDHomeModelAttrStr title:@"NSAttributedString"]
        ];
        KDHomeSectionModel *secion1 = [[KDHomeSectionModel alloc] initWithTitle:@"Core Animtaion" rowModels:rows];
        [models addObject:secion1];
        
        _models = models.copy;
    }
    
    return _models;
}
@end

@implementation KDHomeSectionModel

- (instancetype)initWithTitle:(NSString *)title rowModels:(NSArray<KDHomeRowModel *> *)models {
    self = [super init];
    if (self) {
        self.title = title;
        self.rowModels = models;
    }
    return self;
}

@end


@implementation KDHomeRowModel

- (instancetype)initWithType:(KDHomeModelType)type title:(NSString *)title
{
    self = [super init];
    if (self) {
        self.type = type;
        self.title = title;
    }
    return self;
}

@end
