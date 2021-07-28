import { Service } from 'egg';
import { goodsParams } from './type/sroce-interface'

export default class goodsService extends Service {
    /*
     * 分页查询
     */
    public async findGoods(page) {
        let { ctx } = this
        return await ctx.model.TGoods.findAndCountAll({
            limit: +page.pageSize,
            offset: page.pageNumber - 1,
        })
    }
    /*
     * 添加或者更新
     */
    public async addGoods(obj: goodsParams) {
        let { ctx } = this
        if (obj.id) {
            return await ctx.model.TGoods.update(obj, {
                where: {
                    id: obj.id
                }
            });
        } else {
            return await ctx.model.TGoods.create(obj);
        }
    }
    /*
     * 删除
     */
    public async deleteGoods(query) {
        let { ctx } = this
        return await ctx.model.TGoods.destroy({ where: query });
    }
}
