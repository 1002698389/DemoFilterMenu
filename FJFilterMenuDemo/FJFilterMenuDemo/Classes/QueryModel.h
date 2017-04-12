//
//  QueryModel.h
//  FJFilterMenuDemo
//

#import "MyModel.h"

@interface QueryModel : MyModel

@property (copy, nonatomic) NSString<Optional> *query;
@property (copy, nonatomic) NSString<Optional> *brand;
@property (copy, nonatomic) NSString<Optional> *seller;
@property (copy, nonatomic) NSString<Optional> *category;

@end
