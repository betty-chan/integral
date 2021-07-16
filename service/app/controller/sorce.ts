import { Controller } from 'egg'

class SorceController extends Controller {
    //列表查询
    public async page() {
        const { ctx } = this
        const query = ctx.request.query
        let result = await ctx.service.sorce.findSorce({ type: query.type }, query)
        ctx.returnBody(200, "操作成功", result)
    }
    //列表添加或修改
    public async eidt() {
        const { ctx } = this
        const garde = ctx.request.body
        await ctx.service.sorce.addSorce(garde)
        ctx.returnBody(200, "操作成功")
    }
}
module.exports = SorceController
