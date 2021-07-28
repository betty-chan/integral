import { Application, Router } from 'egg';

export default (app: Application) => {
  const { controller } = app;
  const { user, handle, grade, sorce, login, wish, goods } = controller
  const apiV2Router: Router = app.router.namespace('/api/v2');

  // login 
  apiV2Router.post('/login/register', login.register); // 注册
  apiV2Router.post('/login', login.loginIn); // 登录
  apiV2Router.get('/login/signout', login.signOut); // 退出登录

  // user
  apiV2Router.get('/user/info', user.userInfo); // 用户信息
  apiV2Router.get('/user/personal', user.userPersonalInfo); // 用户信息
  apiV2Router.post('/user/update', user.updateUserInfo); // 用户信息
  apiV2Router.get('/user/list', user.getUserList); // 用户信息

  // handle
  apiV2Router.get('/handle/upload/get-token', handle.getQiniuToken); // 退出登录

  // grade
  apiV2Router.get('/grade/list', grade.page); // 列表
  apiV2Router.post('/grade/edit', grade.edit); // 编辑
  apiV2Router.get('/grade/delete', grade.delete);

  // goods
  apiV2Router.get('/goods/list', goods.page); // 列表
  apiV2Router.post('/goods/edit', goods.edit); // 编辑
  apiV2Router.get('/goods/delete', goods.delete);

  // sorce
  apiV2Router.get('/sorce/list', sorce.page); // 列表
  apiV2Router.post('/sorce/edit', sorce.edit); // 编辑
  apiV2Router.get('/sorce/sum', sorce.sumSorce); // 编辑

  //wish
  apiV2Router.get('/wish/list', wish.page);
  apiV2Router.post('/wish/add', wish.edit);
  apiV2Router.get('/wish/delete', wish.delete);
}
