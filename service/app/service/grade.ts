import { Service } from 'egg';
import { gradeParams } from './type/sroce-interface'

export default class gradeService extends Service {
    /*
     * 分页查询
     */
    public async findGrade(page) {
        let { ctx } = this
        return await ctx.model.TGrade.findAndCountAll({
            limit: +page.pageSize,
            offset: page.pageNumber - 1,
            order: ['level']
        })
    }
    /*
     * 查询等级特权
     */
    public async findPower(page) {
        let { ctx } = this
        return await ctx.model.TPower.findAndCountAll({
            limit: +page.pageSize,
            offset: page.pageNumber - 1,
            where: {
                grade_id: page.grade_id
            }
        })
    }
    /*
     * 添加或者更新
     * @interface {sroceUserParams}
     */
    public async addGrade(obj: gradeParams) {
        let { ctx } = this
        if (obj.id) {
            return await ctx.model.TGrade.update(obj, {
                where: {
                    id: obj.id
                }
            });
        } else {
            return await ctx.model.TGrade.create(obj);
        }
    }
    public async deleteGrade(query) {
        let { ctx } = this
        return await ctx.model.TGrade.destroy({ where: query });
    }
}
