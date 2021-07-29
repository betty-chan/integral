## 目录结构
```
components //组件库
pages //页面
static //图片静态资源
store //全局变量配置
```

## 待优化  
1. 拦截器配置进行错误提醒和401跳转登录

## uniapp开发遇坑
1. 路由跳转分为tab页跳转和普通页跳转，方法分别为uni.switchTab({url: '/pages/new/new'})和uni.navigateTo({url:"pages/center/info"})