//
//  ViewController.m
//  KeyBoardManager
//
//  Created by TongLi on 2017/3/29.
//  Copyright © 2017年 TongLi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textfield1;
@property (weak, nonatomic) IBOutlet UITextField *textfield2;
@property (weak, nonatomic) IBOutlet UITextField *textfield3;

@property (nonatomic,strong)UITextField *tempTextField;//作为标记，标记那个textfield正在输入。
@end

@implementation ViewController

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.tempTextField = textField;//记录一下现在正在输入的是哪个textfield
    
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*通知，键盘出现或者消失就会相应通知*/
    
    //键盘将要出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘已经出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    //键盘将要消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //键盘已经消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    //键盘的frame将要改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //键盘的frame改变完毕
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];

}

- (void)keyboardWillShow:(NSNotification *)info {
    NSLog(@"键盘将要出现");
}

- (void)keyboardDidShow:(NSNotification *)info {
    NSLog(@"键盘已经出现");
    
    //获取键盘高度，
    CGFloat kbHeight = [[info.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSLog(@"键盘高度 %f",kbHeight);
    

    //如果当前正在输入的textfield的最大Y值 + 键盘高度 大于 屏幕高度，就说明遮挡了，
    if (CGRectGetMaxY(self.tempTextField.frame) + kbHeight > self.view.bounds.size.height) {
        
        //动画效果，为了更加好看
        [UIView animateWithDuration:.1 animations:^{
            //遮挡了，就要将屏幕上移
            CGFloat upHeight =  CGRectGetMaxY(self.tempTextField.frame) + kbHeight - self.view.bounds.size.height;
            self.view.frame =CGRectMake(0, -upHeight - 10, self.view.bounds.size.width, self.view.bounds.size.height);
        }];
        
       
        
    }
    
}

- (void)keyboardWillHide:(NSNotification *)info {
    NSLog(@"键盘将要消失");
    
}

- (void)keyboardDidHide:(NSNotification *)info {
    NSLog(@"键盘已经消失");
    //动画
    [UIView animateWithDuration:.1 animations:^{
        //屏幕还原
        self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        
    }];

}

- (void)keyboardWillChangeFrame:(NSNotification *)info {
    NSLog(@"键盘的frame将要改变");
}
- (void)keyboardDidChangeFrame:(NSNotification *)info {
    NSLog(@"键盘的frame改变完毕");

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.textfield1 resignFirstResponder];
    [self.textfield2 resignFirstResponder];
    [self.textfield3 resignFirstResponder];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
