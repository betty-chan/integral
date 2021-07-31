import { Service } from 'egg';
import { gradeParams } from './type/sroce-interface'

export default class gradeService extends Service {
    /*
     * 分页查询
     */
    public async findGrade() {
        let { ctx } = this
        return await ctx.model.TGrade.findAll({
            order: ['level']
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
    /*
     * 删除
     */
    public async deleteGrade(query) {
        let { ctx } = this
        return await ctx.model.TGrade.destroy({ where: query });
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
    public async addPower(obj: gradeParams) {
        let { ctx } = this
        if (obj.id) {
            return await ctx.model.TPower.update(obj, {
                where: {
                    id: obj.id
                }
            });
        } else {
            return await ctx.model.TPower.create(obj);
        }
    }
    /*
     * 删除特权
     */
    public async deletePower(query) {
        let { ctx } = this
        return await ctx.model.TPower.destroy({ where: query });
    }
}
