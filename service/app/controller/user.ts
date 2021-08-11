import { Controller } from 'egg'

class UserController extends Controller {

    // 获取用户信息
    public async userInfo() {
        const { ctx } = this
        let userId = ctx.query.userId || ctx.user.userId
        // 获取并填充数据
        let user = await this.service.user.getUserByUserId(userId)
        let userInfo = {
            username: user.username,
            email: user.email,
            avatarUrl: user.avatarUrl,
            birth: user.birth,
            account: user.email.replace(/@.*/, ''),
            mobile: user.mobile,
            sex: user.sex,
            userId: user.id
        }
        ctx.returnBody(200, "获取成功", userInfo)
    }

    // 获取用户信息
    public async getUserList() {
        const { ctx } = this;
        let userInfo = await this.service.user.getUserList()
        ctx.returnBody(200, "获取成功", userInfo)
    }

    // 获取用户信息
    public async pageUser() {
        const { ctx } = this;
        const page = ctx.request.query;
        let userInfo = await this.service.user.page(page)
        ctx.returnBody(200, "获取成功", userInfo)
    }

    // 更新用户信息
    public async updateUserInfo() {
        const { ctx } = this
        let userId = ctx.request.body.id || ctx.user.userId;
        delete ctx.request.body.id;
        let contentBody = ctx.request.body
        // 更新已使用的他人邮箱地址
        if (contentBody.email) {
            let result = await this.service.user.getUserByMail(contentBody.email)
            if (result && result.id !== userId) {
                ctx.returnBody(400, "该邮箱已被其他账户使用")
                return
            }
        }
        // 密码校验不通过
        let result = await this.service.user.getUserByUserId(userId)
        if (contentBody.password && result && result.password !== contentBody.password) {
            ctx.returnBody(400, "旧密码不正确")
            return
        } else if (contentBody.password) {
            contentBody.password = contentBody.newPassword
        }
        // 获取并填充数据
        await this.service.user.updateUserInfo({ id: userId }, contentBody)
        // 已更改密码，让用户重新登录
        if (contentBody.password) {
            ctx.logout();
            ctx.cookies.set(this.config.auth_cookie_name, "");
            ctx.returnBody(401, "密码更新成功，请重新登录")
        } else {
            ctx.returnBody(200, "更新成功")
        }
    }
}

module.exports = UserController