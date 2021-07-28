import { Controller } from 'egg'

class WishController extends Controller {
    //列表查询
    public async page() {
        const { ctx } = this
        const page = ctx.request.query
        let result = await ctx.service.wish.findWish(page)
        ctx.returnBody(200, "操作成功", result)
    }
    //列表添加或修改
    public async edit() {
        const { ctx } = this
        const wish = ctx.request.body
        let result = await ctx.service.wish.addWish(wish)
        ctx.returnBody(200, "操作成功", result)
    }
    //删除
    public async delete() {
        const { ctx } = this
        const query = ctx.request.query
        let result = null;
        if (query.id) {
            result = await ctx.service.wish.deleteWish({ id: query.id })
        }
        ctx.returnBody(200, "操作成功", result)
    }
}
module.exports = WishController
