export interface sroceUserParams {
    id: number,
    user_id: string, // 用户名
    sorce: number, // 积分要求
    type: string, // 积分类别
    description: string,//积分说明
}

export interface gradeParams {
    id: number,
    name: string, // 用户名
    sorce: number, // 积分要求
    description: string,//积分说明
    level: number
}

export interface wishParams {
    id: number,
    user_id: string, // 用户名
    description: string,//说明
}

export interface goodsParams {
    id: number,
    title: string, // 标题
    value: number, // 价值
    description: string,//积分说明
    on_shelf: number
}
