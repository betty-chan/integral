import Main from '@/views/Main.vue';

// 不作为Main组件的子页面展示的页面单独写，如下
export const loginRouter = {
    path: '/login',
    name: 'login',
    meta: {
        title: '登录 - 家庭慧 '
    },
    component: () => import('@/views/login.vue')
};

export const registRouter = {
    path: '/regist',
    name: 'regist',
    meta: {
        title: '注册 - 家庭慧'
    },
    component: () => import('@/views/regist.vue')
};

export const registResult = {
    path: '/regist-result',
    name: 'regist-result',
    meta: {
        title: '注册结果 - 家庭慧'
    },
    component: () => import('@/views/regist-result.vue')
};

export const authorizeRouter = {
    path: '/authorize',
    name: 'authorize',
    meta: {
        title: 'XBoot统一认证平台 - XBoot前后端分离开发平台 '
    },
    component: () => import('@/views/authorize.vue')
};

export const page404 = {
    path: '/*',
    name: 'error-404',
    meta: {
        title: '404-页面不存在'
    },
    component: () => import('@/views/error-page/404.vue')
};

export const page403 = {
    path: '/403',
    meta: {
        title: '403-权限不足'
    },
    name: 'error-403',
    component: () => import('@/views/error-page/403.vue')
};

export const page500 = {
    path: '/500',
    meta: {
        title: '500-服务端错误'
    },
    name: 'error-500',
    component: () => import('@/views/error-page/500.vue')
};

// 作为Main组件的子页面展示但是不在左侧菜单显示的路由写在otherRouter里
export const otherRouter = {
    path: '/',
    name: 'otherRouter',
    redirect: '/home',
    component: Main,
    children: [
        { path: 'home', title: { i18n: 'home' }, name: 'home_index', component: () => import('@/views/home/home.vue') },
        { path: 'ownspace', title: '个人中心', name: 'ownspace_index', component: () => import('@/views/own-space/own-space.vue') },
        { path: 'change-pass', title: '修改密码', name: 'change_pass', component: () => import('@/views/change-pass/change-pass.vue') },
    ]
};

export const appRouter = [];

// 所有上面定义的路由都要写在下面的routers里
export const routers = [
    loginRouter,
    registRouter,
    registResult,
    authorizeRouter,
    otherRouter,
    ...appRouter,
    page500,
    page403
];
