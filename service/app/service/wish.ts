import { Service } from 'egg';
import { wishParams } from './type/sroce-interface'

function flattenObj(values) {
    let keys1 = Object.keys(values);
    keys1.forEach((key) => {
        let name = key.split(".");
        let item = ""
        key.split(".").length && (item = name[name.length - 1]);
        if (!values[item]) {
            values[item] = values[key];
            delete values[key]
        }
    });
    return values;
}

export default class wishService extends Service {
    /*
     * 分页查询
     */
    public async findWish(page) {
        let { ctx } = this
        ctx.model.TWish.belongsTo(ctx.model.TUser, {
            foreignKey: "user_id",
            targetKey: "id",
            constraints: false,
        })
        let result = await ctx.model.TWish.findAndCountAll({
            offset: page.pageNumber - 1,
            limit: +page.pageSize,
            raw: true,//表明返回的数据是json而不是model
            include: [
                {
                    model: ctx.model.TUser,
                    attributes: ['username'],
                }
            ],
        })
        result.rows.forEach((element) => {
            flattenObj(element)
        });
        return result
    }
    /*
     * 添加或者更新
     */
    public async addWish(obj: wishParams) {
        let { ctx } = this
        if (obj.id) {
            return await ctx.model.TWish.update(obj, {
                where: {
                    id: obj.id
                }
            });
        } else {
            return await ctx.model.TWish.create(obj);
        }
    }
    /*
     * 删除
     */
    public async deleteWish(query) {
        let { ctx } = this
        return await ctx.model.TWish.destroy({ where: query });
    }
}
