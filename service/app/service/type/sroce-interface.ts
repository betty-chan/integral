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