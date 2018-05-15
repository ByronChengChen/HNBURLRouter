
# HNBURLRouter

* URLRouter解决项目中繁多的vc之间相互引用。  
* jspatch的替代方案，使用h5页面取代有bug的native页面。
* 远程调用，支持app外调用，如浏览器，其他app，内部使用本地调用实现

## 解决问题
* 1 项目中控制器(vc)过多的时候，vc之间跳转常常要import很多其他vc的头文件，代码耦合且繁琐。

```
	import "WeatherViewController.h"
	WeatherViewController *vc = [WeatherViewController new];
	[self.navigationController pushViewController:vc animated:YES];
```
* 2 快速迭代过程中，即使测试再仔细，也无法保证线上的产品是没有bug的，之前可以使用jspatch方式来热修复，但是17年三月份之后，苹果不再允许使用JSPatch的应用上线appStore。除了使用类似于faceBook的RN 这样的js方案来解决外，原生无法做到热修复。

* 3 项目要求app首页主菜单的四个按钮需要动态配置，原生的做法不太好实现。
## 原理
* 1 app所有的页面都包括导航控制器，直接通过HNBURLRouter 提供的push方法或者model方法打开目的vc，目的vc通过注册的字符串绑定、runTime获取，此法解除了import头文件的依赖，但存在一个问题，如果VC需要指定参数，那么用Router去打开这个VC的时候，
`[Router openUrl:@"*****" withParams:dict]`
参数的格式不明确，字典该长啥样？需要去相关的vc查阅。为解决这个问题，便有了第二点。`finish`

* 2 基于Router提供一个中介者，中介者为每个vc提供打开方式。eg:
`[Mediator orderDeatilViewControllerWithId:orderID]`
方法内部使用URLRouter获取具体的VC并且赋参,参数可以是普通类型，也可以是复杂类型也可以是非常规类型 这样就解决了casatwy提出的`传params容易懵逼的问题` [iOS应用架构谈 组件化方案 ](https://casatwy.com/iOS-Modulization.html)。`finish`

* 3 为了解决问题2:线上的bug，可以使用webView替换native vc的方法修改线上bug。具体做法是在 Mediator open一个具体的控制器的时候，可以在检查本地字典需要打开的控制器是否需要被替换，本地字典可以在app启动的时候就获取。`todo`

* 4 远程调用
 * 通过浏览器或者其他app内置h5打开。`finish`
 * 项目内配置：app内动态配置某个原生页面的按钮点击事件，可以让该页面动态按钮(相应页面由服务端配置)绑定到该页面接口返回的url中，[使用远程调用的方式实现按钮动态化。](https://github.com/ByronChengChen/HNBKit.git)`finish`