//
//  LLTabBar.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLTabBar.h"
#import "ackUserPCH.pch"

@interface LLTabBar ()

@property (strong, nonatomic) NSMutableArray *tabBarItems;

@end

@implementation LLTabBar

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		[self config];
	}
	
	return self;
}

#pragma mark - Private Method

- (void)config {
	self.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
//	UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, SCREEN_WIDTH, 5)];
//	topLine.image = [UIImage imageNamed:@"tapbar_top_line"];
//	[self addSubview:topLine];
}

- (void)setSelectedIndex:(NSInteger)index {
	for (LLTabBarItem *item in self.tabBarItems) {
		if (item.tag == index) {
			item.selected = YES;
		} else {
			item.selected = NO;
		}
	}
	
	UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
	UITabBarController *tabBarController = (UITabBarController *)keyWindow.rootViewController;
	if (tabBarController) {
		tabBarController.selectedIndex = index;
	}
}

#pragma mark - Touch Event

- (void)itemSelected:(LLTabBarItem *)sender {
    [self setSelectedIndex:sender.tag];
    
//	if (sender.tabBarItemType != LLTabBarItemRise) {
//		[self setSelectedIndex:sender.tag];
//	} else {
//		if (self.delegate) {
//			if ([self.delegate respondsToSelector:@selector(tabBarDidSelectedRiseButton)]) {
//				[self.delegate tabBarDidSelectedRiseButton];
//			}
//		}
//	}
}

#pragma mark - Setter

- (void)setTabBarItemAttributes:(NSArray<NSDictionary *> *)tabBarItemAttributes {
	_tabBarItemAttributes = tabBarItemAttributes.copy;
    
    NSAssert(_tabBarItemAttributes.count > 2, @"TabBar item count must greet than two.");
    
    CGFloat normalItemWidth = (SCREEN_WIDTH * 0.56) / (_tabBarItemAttributes.count - 1);
    CGFloat tabBarHeight = CGRectGetHeight(self.frame);
    CGFloat publishItemWidth = (SCREEN_WIDTH / 7);
    
	NSInteger itemTag = 0;
    BOOL passedRiseItem = NO;
    
    _tabBarItems = [NSMutableArray arrayWithCapacity:_tabBarItemAttributes.count];
    
	for (id item in _tabBarItemAttributes) {
		if ([item isKindOfClass:[NSDictionary class]]) {
            NSDictionary *itemDict = (NSDictionary *)item;
            
            LLTabBarItemType type = [itemDict[kLLTabBarItemAttributeType] integerValue];
            
            CGRect frame = CGRectMake(itemTag * normalItemWidth + (passedRiseItem ? publishItemWidth : 0), 0, type == LLTabBarItemRise ? publishItemWidth : normalItemWidth, tabBarHeight);
            
            LLTabBarItem *tabBarItem = [self tabBarItemWithFrame:frame
                                                         title:itemDict[kLLTabBarItemAttributeTitle]
                                               normalImageName:itemDict[kLLTabBarItemAttributeNormalImageName]
                                             selectedImageName:itemDict[kLLTabBarItemAttributeSelectedImageName] tabBarItemType:type];
			if (itemTag == 1) {
				tabBarItem.selected = YES;
			}
            
			[tabBarItem addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
            
            
            if (tabBarItem.tabBarItemType != LLTabBarItemRise) {
                tabBarItem.tag = itemTag;
                itemTag++;
                passedRiseItem = YES;
            } else {
                tabBarItem.tag = itemTag;
                itemTag++;
                passedRiseItem = YES;
            }
            
            [_tabBarItems addObject:tabBarItem];
			[self addSubview:tabBarItem];
		}
	}
}

- (LLTabBarItem *)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName tabBarItemType:(LLTabBarItemType)tabBarItemType {
    LLTabBarItem *item = [[LLTabBarItem alloc] initWithFrame:frame];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:10];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [item setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    item.tabBarItemType = tabBarItemType;
    
    return item;
}

@end
