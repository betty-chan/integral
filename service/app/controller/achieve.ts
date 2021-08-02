import { Controller } from 'egg'

class AchieveController extends Controller {
    //列表查询
    public async page() {
        const { ctx } = this
        const page = ctx.request.query;
        let query = {
            user_id: ctx.user.userId
        }
        let result = null;
        if (page) {
            result = await ctx.service.achieve.findAchieve(query, page)
        }
        ctx.returnBody(200, "操作成功", result)
    }
    //列表查询
    public async pageRecord() {
        const { ctx } = this
        const page = ctx.request.query;
        let result = null;
        if (page) {
            result = await ctx.service.achieve.findRecord(page)
        }
        ctx.returnBody(200, "操作成功", result)
    }
    //列表添加或修改
    public async edit() {
        const { ctx } = this
        const garde = ctx.request.body
        await ctx.service.achieve.addAchieve(garde)
        ctx.returnBody(200, "操作成功")
    }
    //删除
    public async delete() {
        const { ctx } = this
        const query = ctx.request.query
        let result = null;
        if (query.id) {
            result = await ctx.service.achieve.deleteAchieve({ id: query.id })
        }
        ctx.returnBody(200, "操作成功", result)
    }
}
module.exports = AchieveController
