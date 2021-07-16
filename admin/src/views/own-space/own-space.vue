<style lang="less" scoped>
@import "./own-space.less";
</style>

<template>
  <div class="own-space">
    <Card class="own-space-new">
      <div class="own-wrap">
        <div style="width: 240px">
          <Menu active-name="基本信息" theme="light" @on-select="changeMenu">
            <MenuItem name="基本信息">基本信息</MenuItem>
            <MenuItem name="安全设置">安全设置</MenuItem>
            <MenuItem name="第三方账号绑定">第三方账号绑定</MenuItem>
            <MenuItem name="消息通知">消息通知</MenuItem>
          </Menu>
        </div>
        <div style="padding: 8px 40px; width: 100%">
          <div class="title">{{ currMenu }}</div>
          <div>
            <div v-show="currMenu == '基本信息'">
              <Form
                ref="form"
                :model="form"
                :label-width="90"
                label-position="left"
              >
                <FormItem label="登录账号：" prop="username">{{
                  form.username
                }}</FormItem>
                <FormItem label="用户头像：">
                  <upload-pic-thumb
                    v-model="form.avatar"
                    :multiple="false"
                  ></upload-pic-thumb>
                </FormItem>
                <FormItem label="用户名：" prop="nickname">
                  <Input v-model="form.nickname" style="width: 300px" />
                </FormItem>
                <FormItem label="性别：">
                  <dict dict="sex" v-model="form.sex" style="width: 300px" />
                </FormItem>
                <FormItem label="生日：">
                  <DatePicker
                    v-model="form.birth"
                    @on-change="changeBirth"
                    style="width: 300px"
                    type="date"
                  ></DatePicker>
                </FormItem>
                <FormItem label="所在省市：">
                  <al-cascader
                    v-model="form.address"
                    data-type="name"
                    level="2"
                    style="width: 300px"
                  />
                </FormItem>
                <FormItem label="街道地址：" prop="street">
                  <Input v-model="form.street" style="width: 300px" />
                </FormItem>
                <FormItem label="个人简介：" prop="description">
                  <Input
                    v-model="form.description"
                    type="textarea"
                    style="width: 300px"
                    :autosize="{ minRows: 3, maxRows: 5 }"
                    placeholder="个人简介"
                  ></Input>
                </FormItem>
                <FormItem label="所属部门：">
                  <span>{{ form.departmentTitle }}</span>
                </FormItem>
                <FormItem label="用户类型：">
                  <span>{{ form.typeTxt }}</span>
                </FormItem>
                <FormItem>
                  <Button
                    type="primary"
                    style="width: 100px; margin-right: 5px"
                    :loading="saveLoading"
                    @click="saveEdit"
                    >保存</Button
                  >
                </FormItem>
              </Form>
            </div>
            <div v-show="currMenu == '安全设置'" class="safe">
              <div class="item">
                <div>
                  <div class="title">账户密码</div>
                  <div v-if="form.passStrength" class="desc">
                    当前密码强度：
                    <span v-if="form.passStrength == '弱'" class="red">{{
                      form.passStrength
                    }}</span>
                    <span v-if="form.passStrength == '中'" class="middle">{{
                      form.passStrength
                    }}</span>
                    <span v-if="form.passStrength == '强'" class="green">{{
                      form.passStrength
                    }}</span>
                  </div>
                </div>
                <div>
                  <a @click="changePass">修改</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </Card>

    <Modal
      title="修改手机号"
      v-model="editMobileVisible"
      :closable="false"
      :mask-closable="false"
      :width="500"
    >
      <Form
        ref="mobileEditForm"
        :model="mobileEditForm"
        :label-width="70"
        :rules="mobileEditValidate"
      >
        <FormItem label="手机号" prop="mobile">
          <Input
            v-model="mobileEditForm.mobile"
            @on-change="hasChangePhone"
            placeholder="请输入新手机号"
          />
        </FormItem>
        <FormItem label="验证码" prop="code" :error="codeError">
          <Row type="flex" justify="space-between">
            <Input
              v-model="mobileEditForm.code"
              placeholder="请输入您收到的短信验证码"
              style="width: 280px"
            />
            <CountDownButton
              ref="countDownMobile"
              @on-click="sendEditMobileCode"
              :disabled="canSendMobileCode"
              :autoCountDown="false"
              :loading="sending"
              :text="getSms"
            />
          </Row>
        </FormItem>
      </Form>
      <div slot="footer">
        <Button type="text" @click="cancelInputCodeBox">取消</Button>
        <Button
          type="primary"
          :loading="checkCodeLoading"
          @click="submitEditMobile"
          >提交</Button
        >
      </div>
    </Modal>

    <Modal
      title="修改邮箱"
      v-model="editEmailVisible"
      :closable="false"
      :mask-closable="false"
      :width="500"
    >
      <Form
        ref="emailEditForm"
        :model="emailEditForm"
        :label-width="100"
        :rules="emailEditValidate"
      >
        <FormItem label="新邮箱地址" prop="email">
          <Input
            v-model="emailEditForm.email"
            @on-change="hasChangeEmail"
            placeholder="请输入新邮箱地址"
          ></Input>
        </FormItem>
        <FormItem label="验证码" prop="code" :error="codeError">
          <Row type="flex" justify="space-between">
            <Input
              v-model="emailEditForm.code"
              placeholder="请输入您收到的邮件中的验证码"
              style="width: 250px"
            />
            <CountDownButton
              ref="countDownEmail"
              @on-click="sendVerifyEmail"
              :disabled="canSendEditEmail"
              :autoCountDown="false"
              :loading="sending"
              :text="getSms"
            />
          </Row>
        </FormItem>
      </Form>
      <div slot="footer">
        <Button type="text" @click="cancelEditEmail">取消</Button>
        <Button
          type="primary"
          :loading="editEmailLoading"
          @click="submitEditEmail"
          >提交</Button
        >
      </div>
    </Modal>
    <check-password ref="checkPassMobile" @on-success="checkSuccessMobile" />
    <check-password ref="checkPassEmail" @on-success="checkSuccessEmail" />
  </div>
</template>

<script>
import { userInfo, userInfoEdit } from "@/api/index";
import { validateMobile } from "@/libs/validate";
import CountDownButton from "@/views/my-components/xboot/count-down-button";
import uploadPicThumb from "@/views/my-components/xboot/upload-pic-thumb";
import checkPassword from "@/views/my-components/xboot/check-password";
import Cookies from "js-cookie";
import dict from "@/views/my-components/xboot/dict";
export default {
  components: {
    uploadPicThumb,
    checkPassword,
    CountDownButton,
    dict,
  },
  name: "ownspace_index",
  data() {
    return {
      area: 86,
      messageOpen: 1,
      form: {
        id: "",
        avatar: "",
        username: "",
        sex: "",
        mobile: "",
        email: "",
        status: "",
        type: "",
        typeTxt: "",
        address: [],
      },
      mobileEditForm: {
        mobile: "",
        code: "",
      },
      emailEditForm: {
        email: "",
        code: "",
      },
      codeError: "",
      initPhone: "",
      initEmail: "",
      saveLoading: false,
      sending: false,
      getSms: "获取验证码",
      canSendMobileCode: true, // 是否可点获取验证码
      checkCodeLoading: false,
      checkPassLoading: false,
      editEmailLoading: false,
      mobileEditValidate: {
        mobile: [
          { required: true, message: "请输入手机号码" },
          { validator: validateMobile },
        ],
      },
      emailEditValidate: {
        email: [
          { required: true, message: "请输入邮箱地址" },
          { type: "email", message: "邮箱格式不正确" },
        ],
      },
      editMobileVisible: false, // 显示填写验证码box
      editEmailVisible: false,
      canSendEditEmail: true,
      relate: {},
      jumping: false,
      currMenu: "基本信息",
    };
  },
  methods: {
    init() {
      let v = JSON.parse(Cookies.get("userInfo"));
      // 转换null为""
      for (let attr in v) {
        if (v[attr] == null) {
          v[attr] = "";
        }
      }
      let str = JSON.stringify(v);
      let userInfo = JSON.parse(str);
      this.form = userInfo;
      this.initPhone = userInfo.mobile;
      this.mobileEditForm.mobile = userInfo.mobile;
      this.initEmail = userInfo.email;
      this.emailEditForm.email = userInfo.email;
      if (userInfo.address) {
        if (typeof userInfo.address == "string") {
          this.form.address = userInfo.address.split(",");
        } else {
          this.form.address = userInfo.address;
        }
      } else {
        this.form.address = [];
      }
      if (this.form.type == 0) {
        this.form.typeTxt = "普通用户";
      } else if (this.form.type == 1) {
        this.form.typeTxt = "管理员";
      }
      let messageOpen = this.getStore("messageOpen");
      if (
        messageOpen != "" &&
        messageOpen != undefined &&
        messageOpen != null
      ) {
        this.messageOpen = Number(messageOpen);
      } else {
        this.setStore("messageOpen", 1);
      }
    },
    changePass() {
      this.$router.push({
        name: "change_pass",
      });
    },
    changeMenu(v) {
      this.currMenu = v;
    },
    showChangeMobile() {
      this.$refs.checkPassMobile.show();
    },
    checkSuccessMobile() {
      this.editMobileVisible = true;
    },
    showChangeEmail() {
      this.$refs.checkPassEmail.show();
    },
    checkSuccessEmail() {
      this.editEmailVisible = true;
    },
    saveEdit() {
      this.saveLoading = true;
      if (typeof this.form.birth == "object") {
        this.form.birth = this.format(this.form.birth, "yyyy-MM-dd");
      }
      delete this.form.roles;
      userInfoEdit(this.form).then((res) => {
        this.saveLoading = false;
        if (res.success) {
          this.$Message.success("保存成功");
          // 更新用户信息
          this.updateUserInfo();
          // 更新头像
          this.$store.commit("setAvatarPath", this.form.avatar);
        }
      });
    },
    changeBirth(v) {
      this.form.birth = v;
    },
    cancelInputCodeBox() {
      this.editMobileVisible = false;
      this.form.mobile = this.initPhone;
    },
    cancelEditEmail() {
      this.editEmailVisible = false;
      this.emailEditForm.email = this.initEmail;
    },
    sendEditMobileCode() {
      this.$refs["mobileEditForm"].validate((valid) => {
        if (valid) {
          this.$Modal.info({
            title: "抱歉，请获取完整版",
            content: "",
          });
        }
      });
    },
    submitEditMobile() {
      this.$refs["mobileEditForm"].validate((valid) => {
        if (valid) {
          if (!this.mobileEditForm.code) {
            this.codeError = "请填写短信验证码";
            return;
          } else {
            this.codeError = "";
          }
          this.$Modal.info({
            title: "抱歉，请获取完整版",
            content: "",
          });
        }
      });
    },
    hasChangePhone() {
      if (this.mobileEditForm.mobile == this.initPhone) {
        this.canSendMobileCode = true;
      } else {
        this.$refs["mobileEditForm"].validate((valid) => {
          if (valid) {
            this.canSendMobileCode = false;
          } else {
            this.canSendMobileCode = true;
          }
        });
      }
    },
    hasChangeEmail() {
      if (this.emailEditForm.email == this.initEmail) {
        this.canSendEditEmail = true;
      } else {
        this.canSendEditEmail = false;
      }
    },
    sendVerifyEmail() {
      this.$refs["emailEditForm"].validate((valid) => {
        if (valid) {
          this.$Modal.info({
            title: "抱歉，请获取完整版",
            content: "",
          });
        }
      });
    },
    submitEditEmail() {
      this.$refs["emailEditForm"].validate((valid) => {
        if (valid) {
          if (!this.emailEditForm.code) {
            this.codeError = "验证码不能为空";
            return;
          } else {
            this.codeError = "";
          }
          this.$Modal.info({
            title: "抱歉，请获取完整版",
            content: "",
          });
        }
      });
    },
    updateUserInfo() {
      // 更新用户信息
      userInfo().then((res) => {
        if (res.success) {
          // 避免超过大小限制
          delete res.result.permissions;
          delete res.result.roles;
          if (this.getStore("saveLogin")) {
            // 保存7天
            Cookies.set("userInfo", JSON.stringify(res.result), {
              expires: 7,
            });
          } else {
            Cookies.set("userInfo", JSON.stringify(res.result));
          }
          this.setStore("userInfo", res.result);
        }
      });
    },
    changeMessage(v) {
      this.setStore("messageOpen", v);
    },
  },
  mounted() {
    this.init();
  },
};
</script>
