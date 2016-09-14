//
//  UILabel+UILableEx.m
//  ZTQ
//
//  Created by 杨洪 on 16/9/13.
//  Copyright © 2016年 杨洪. All rights reserved.
//

#import "UILabel+UILableEx.h"

@implementation UILabel (UILableEx)

-(CGSize)setLabelWidth:(NSString *)str andLabFont:(float)myfont andMaxWidth:(float)maxwidth andMaxHeight:(float)maxheight{
    
    self.text = str;
    self.lineBreakMode = NSLineBreakByTruncatingTail ;
    
    
    self.font = [UIFont systemFontOfSize:myfont];
    CGSize size =CGSizeMake(maxwidth ,maxheight);
    NSDictionary * ttdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:myfont],NSFontAttributeName,nil];
    
    //ios7方法，获取文本需要的size，限制宽度
    
    CGSize  actualsize =[str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:ttdic context:nil].size;
    //设置新的fram
    return actualsize;
}


@end
