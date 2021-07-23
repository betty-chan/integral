import { Service } from 'egg';

export default class wishService extends Service {
    /*
     * 分页查询
     */
    public async findWish(page) {
        let { ctx } = this
        return await ctx.model.TWish.findAndCountAll({
            limit: +page.pageSize,
            offset: page.pageNumber - 1,
        })
    }
}
