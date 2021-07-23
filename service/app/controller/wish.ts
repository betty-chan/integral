import { Controller } from 'egg'

class WishController extends Controller {
    //列表查询
    public async page() {
        const { ctx } = this
        const page = ctx.request.query
        let result = await ctx.service.wish.findWish(page)
        ctx.returnBody(200, "操作成功", result)
    }
}
module.exports = WishController
