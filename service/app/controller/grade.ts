import { Controller } from 'egg'

class GradeController extends Controller {
    //列表查询
    public async page() {
        const { ctx } = this
        const page = ctx.request.query
        let result = await ctx.service.grade.findGrade(page)
        ctx.returnBody(200, "操作成功", result)
    }
    //特权列表查询
    public async pagePower() {
        const { ctx } = this
        const page = ctx.request.query
        let result = await ctx.service.grade.findPower(page)
        ctx.returnBody(200, "操作成功", result)
    }
    //列表添加或修改
    public async edit() {
        const { ctx } = this
        const garde = ctx.request.body
        await ctx.service.grade.addGrade(garde)
        ctx.returnBody(200, "操作成功")
    }
    //删除
    public async delete() {
        const { ctx } = this
        const query = ctx.request.query
        let result = null;
        if (query.id) {
            result = await ctx.service.grade.deleteGrade({ id: query.id })
        }
        ctx.returnBody(200, "操作成功", result)
    }
}
module.exports = GradeController
