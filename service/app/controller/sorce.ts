import { Controller } from 'egg'

class SorceController extends Controller {
    //列表查询
    public async page() {
        const { ctx } = this
        const query = ctx.request.query
        let params = {};
        if (query.type && query.user_id) {
            params = { type: query.type, user_id: query.user_id }
        }
        let result = await ctx.service.sorce.findSorce(params, query)
        ctx.returnBody(200, "操作成功", result)
    }
    //列表添加或修改
    public async edit() {
        const { ctx } = this
        const garde = ctx.request.body
        let result = await ctx.service.sorce.addSorce(garde)
        ctx.returnBody(200, "操作成功", result)
    }
    //求和
    public async sumSorce() {
        const { ctx } = this
        const query = ctx.request.query
        let params = {};
        if (query.type && query.user_id) {
            params = { type: query.type, user_id: query.user_id }
        }
        let result = await ctx.service.sorce.sumSorce(params)
        ctx.returnBody(200, "操作成功", result)
    }
}
module.exports = SorceController
