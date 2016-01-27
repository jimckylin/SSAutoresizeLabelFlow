# SSAutoresizeLabelFlow 
![](https://raw.githubusercontent.com/immrss/SSAutoresizeLabelFlow/master/Demo.gif)

## Usage

```objective-c
self.automaticallyAdjustsScrollViewInsets = NO;
SSAutoresizeLabelFlowConfig *config = [SSAutoresizeLabelFlowConfig shareConfig];
config.backgroundColor = [UIColor lightGrayColor];
config.textFont = [UIFont fontWithName:@"Times New Roman" size:15];
NSArray *array = @[@"Adele",@"Alicia Keys",@"Ariana Grande",@"Avril Lavigne",@"Beyoncé",@"Britney Spears",@"Celine Dion",@"Katy Perry",@"Rihanna"];
self.flow = [[SSAutoresizeLabelFlow alloc]initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width-20, 0) titles:array selectedHandler:^(NSUInteger index, NSString *title) {
    NSLog(@"%lu %@",index,title);
}];
[self.view addSubview:self.flow]; 
```
See the Demo for more information.

## License
The project is available under the MIT license.

