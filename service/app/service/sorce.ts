import { Service } from 'egg';
import { sroceUserParams } from './type/sroce-interface'

export default class sroceService extends Service {
    /*
     * 分页查询
     */
    public async findSorce(query, page) {
        let { ctx } = this
        // if (query.type && query.userid && page.pageNumber) {
        //     let result: any = {
        //         rows: [],
        //         count: null,
        //     };
        //     let count: any = await ctx.model.query(
        //         `SELECT count(t_sorce.id) as count FROM t_sorce left join t_user on t_sorce.user_id = t_user.id  WHERE t_sorce.type = ${query.type} and t_sorce.user_id = '${query.user_id}'`,
        //         {
        //             type: ctx.model.QueryTypes.SELECT,
        //             plain: true,
        //             raw: true,
        //         }
        //     );
        //     result.count = count.count;
        //     if (result.count) {
        //         result.rows = await ctx.model.query(
        //             `SELECT t_sorce.* FROM t_sorce left join t_user on t_sorce.user_id = t_user.id  WHERE t_sorce.type = ${query.type} and t_sorce.user_id = '${query.user_id}'
        //             limit ${page.pageNumber - 1}, ${page.pageSize}`,
        //             {
        //                 type: ctx.model.QueryTypes.SELECT
        //             }
        //         );
        //     }
        //     return result
        // }
        // return null;
        ctx.model.TSorce.belongsTo(ctx.model.TUser, {
            as: 'user',
            foreginkey: "user_id",
            constraints: false
        })
        return await ctx.model.TSorce.findAndCountAll({
            where: query,
            offset: page.pageNumber - 1,
            limit: +page.pageSize,
            include: [
                {
                    association: 'user',
                    attributes: ['username', "id"],
                }
            ]
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
