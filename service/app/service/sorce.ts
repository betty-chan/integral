import { Service } from 'egg';
import { sroceUserParams } from './type/sroce-interface'

export default class sroceService extends Service {
    /*
     * 分页查询
     */
    public async findSorce(query, page) {
        let { ctx } = this
        return await ctx.model.TSorce.findAndCountAll({
            where: query,
            offset: page.pageNumber - 1,
            limit: +page.pageSize
        })
    }

    /*
     * 查询用户某类积分总和
     */
    public async sumSorce(query) {
        let { ctx } = this
        return await ctx.model.TSorce.sum('sroce', {
            where: query
        })
    }

    /*
     * 添加或者更新
     */
    public async addSorce(obj: sroceUserParams) {
        let { ctx } = this
        if (obj.id) {
            return await ctx.model.TSorce.update(obj, {
                where: {
                    id: obj.id
                }
            });
        } else {
            return await ctx.model.TSorce.create(obj);
        }
    }
}
