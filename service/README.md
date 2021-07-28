# hackernews-async-ts

[Hacker News](https://news.ycombinator.com/) showcase using typescript && egg

## QuickStart

### Development

```bash
$ npm i
$ npm run dev
$ open http://localhost:7001/
```

Don't tsc compile at development mode, if you had run `tsc` then you need to `npm run clean` before `npm run dev`.

### debug
```bash
npm run debug
```

### Deploy

```bash
$ npm run tsc
$ npm start
```

### Npm Scripts

- Use `npm run lint` to check code style
- Use `npm test` to run unit test
- se `npm run clean` to clean compiled js at development mode once

### Requirement

- Node.js 8.x
- Typescript 2.8+

## Egg目录结构
### TypeScript
```
showcase
├── app
│   ├── controller
│   │   └── home.ts
│   ├── router.ts
│   ├── middleware
│   |   └── response_time.ts
│   ├── service
│   │   └── news.ts
│   └── view
│       └── home.tpl
├── config
│   ├── config.default.ts
│   ├── config.local.ts
│   ├── config.prod.ts
│   └── plugin.ts
├── test
|   ├── controller
|   |   └── home.test.ts
|   └── service
|       └── user.test.ts
├── typings //自动生成
│   └── **/*.d.ts
├── package.json
├── README.md
├── tsconfig.json
└── tslint.json
```
### ES6
```
showcase
├── app
|   ├── router.js
│   ├── controller
│   |   └── home.js
│   ├── service
│   |   └── user.js
│   ├── middleware
│   |   └── response_time.js
│   └── view
│       └── home.tpl
├── config
|   ├── plugin.js
|   ├── config.default.js
│   ├── config.prod.js
|   ├── config.local.js
|   └── config.unittest.js
├── test
|   ├── controller
|   |   └── home.test.js
|   └── service
|       └── user.test.js
├── package.json
└──  README.md
```

# 开发遇坑
- 新增接口，但是调试使用报404，排查后并没有发现问题。结果修改接口地址，一次正常调用后再还原原来的地址就可以正常使用了。