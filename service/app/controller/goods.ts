import { Controller } from 'egg'

class GoodsController extends Controller {
    //列表查询
    public async page() {
        const { ctx } = this
        const page = ctx.request.query;
        let result = null;
        if (page) {
            result = await ctx.service.goods.findGoods(page)
        }
        ctx.returnBody(200, "操作成功", result)
    }
    //列表添加或修改
    public async edit() {
        const { ctx } = this
        const garde = ctx.request.body
        await ctx.service.goods.addGoods(garde)
        ctx.returnBody(200, "操作成功")
    }
    //删除
    public async delete() {
        const { ctx } = this
        const query = ctx.request.query
        let result = null;
        if (query.id) {
            result = await ctx.service.goods.deleteGoods({ id: query.id })
        }
        ctx.returnBody(200, "操作成功", result)
    }
}
module.exports = GoodsController
