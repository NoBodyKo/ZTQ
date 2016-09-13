//
//  UILabel+UILableEx.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/13.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "UILabel+UILableEx.h"

@implementation UILabel (UILableEx)

-(void)setLabelWidth:(NSString *)str andLabFont:(UIFont*)myfont andMaxWidth:(float)maxwidth andMaxHeight:(float)maxheight{
    CGRect oldFrame = self.frame;
    self.text = str;
    self.lineBreakMode =NSLineBreakByTruncatingTail ;
    
    
    self.font = myfont;
    CGSize size =CGSizeMake(maxwidth ,maxheight);
    NSDictionary * ttdic = [NSDictionary dictionaryWithObjectsAndKeys:myfont,NSFontAttributeName,nil];
    
    //ios7方法，获取文本需要的size，限制宽度
    
    CGSize  actualsize =[str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:ttdic context:nil].size;
    //设置新的fram
    oldFrame.size.width = actualsize.width;
    oldFrame.size.height = actualsize.height;
    self.frame = oldFrame;
}


@end
