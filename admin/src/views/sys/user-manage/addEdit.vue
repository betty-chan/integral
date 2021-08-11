<template>
  <div class="user-edit">
    <!-- Drawer抽屉 -->
    <Drawer
      :title="title"
      v-model="visible"
      width="720"
      draggable
      :mask-closable="type == '0'"
    >
      <div :style="{ maxHeight: maxHeight }" class="drawer-content">
        <div class="drawer-header">
          <div style="margin-right: 16px">基本信息</div>
          <Avatar :src="form.avatar" size="large" v-show="type != '2'" />
        </div>
        <Form label-colon v-show="type != '2'">
          <Row :gutter="32">
            <Col span="12">
              <FormItem label="用户ID">
                {{ form.id }}
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="用户名">
                {{ form.username }}
                <Tooltip
                  trigger="hover"
                  placement="right"
                  :content="`密码强度：${form.passStrength}`"
                >
                  <Icon
                    v-show="form.passStrength"
                    type="md-key"
                    :color="passColor"
                    size="18"
                    style="margin-left: 10px; cursor: pointer"
                  />
                </Tooltip>
              </FormItem>
            </Col>
          </Row>
        </Form>
        <Form
          ref="form"
          :model="form"
          :rules="formValidate"
          label-position="top"
        >
          <Row :gutter="32" v-if="type == '2'">
            <Col span="12">
              <FormItem label="用户ID" prop="id">
                <Input v-model="form.id" maxlength="4" />
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="用户名" prop="username">
                <Input v-model="form.username" />
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="密码" prop="password">
                <SetPassword v-model="form.password" @on-change="changePass" />
              </FormItem>
            </Col>
          </Row>
          <Row :gutter="32">
            <Col span="12">
              <FormItem label="邮箱" prop="email">
                <Input v-model="form.email" />
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="手机号" prop="mobile">
                <Input v-model="form.mobile" />
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="性别">
                <Select v-model="form.sex" transfer placeholder="请选择">
                  <Option :value="0">男</Option>
                  <Option :value="1">女</Option>
                </Select>
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="用户类型">
                <Select v-model="form.is_admin" transfer placeholder="请选择">
                  <Option :value="0">普通用户</Option>
                  <Option :value="1">管理员</Option>
                </Select>
              </FormItem>
            </Col>
          </Row>
          <Row :gutter="32">
            <Col span="12">
              <FormItem label="头像">
                <upload-pic-input v-model="form.avatar"></upload-pic-input>
              </FormItem>
            </Col>
            <Col span="12">
              <FormItem label="生日" prop="birth">
                <DatePicker
                  v-model="form.birth"
                  style="display: block"
                  type="date"
                  transfer
                ></DatePicker>
              </FormItem>
            </Col>
          </Row>
          <Divider />
        </Form>
      </div>
      <div class="drawer-footer br" v-show="type != '0'">
        <Button type="primary" :loading="submitLoading" @click="submit"
          >提交</Button
        >
        <Button @click="visible = false">取消</Button>
      </div>
    </Drawer>
  </div>
</template>

<script>
import { addUser, editUser } from "@/api/index";
import { validateUsername, validatePassword } from "@/libs/validate";
import uploadPicInput from "@/views/my-components/xboot/upload-pic-input";
import SetPassword from "@/views/my-components/xboot/set-password";
import dict from "@/views/my-components/xboot/dict";
export default {
  name: "user",
  components: {
    uploadPicInput,
    SetPassword,
    dict,
  },
  props: {
    value: {
      type: Boolean,
      default: false,
    },
    data: {
      type: Object,
    },
    type: {
      type: String,
      default: "0",
    },
  },
  mounted() {
    this.init();
  },
  watch: {
    value(val) {
      this.setCurrentValue(val);
    },
    visible(value) {
      this.$emit("input", value);
    },
  },
  data() {
    return {
      visible: this.value,
      title: "",
      passColor: "",
      submitLoading: false,
      maxHeight: 510,
      form: {
        address: [],
      },
      formValidate: {
        // 表单验证规则
        username: [
          { required: true, message: "请输入登录账号", trigger: "change" },
          { validator: validateUsername, trigger: "change" },
        ],
        nickname: [
          { required: true, message: "请输入用户名", trigger: "change" },
        ],
        password: [
          { required: true, message: "请输入密码", trigger: "change" },
          { validator: validatePassword, trigger: "change" },
        ],
        email: [
          { required: true, message: "请输入邮箱地址" },
          { type: "email", message: "邮箱格式不正确" },
        ],
      },
    };
  },
  methods: {
    init() {},
    changePass(v, grade, strength) {
      this.form.passStrength = strength;
    },
    submit() {
      this.$refs.form.validate((valid) => {
        if (valid) {
          if (typeof this.form.birth == "object") {
            this.form.birth = this.format(this.form.birth, "yyyy-MM-dd");
          }
          if (this.type == "1") {
            // 编辑
            this.submitLoading = true;
            let params = {
              id: this.form.id,
              email: this.form.email,
              username: this.form.username,
              is_admin: this.form.is_admin,
              birth: this.form.birth,
              sex: this.form.sex,
            };
            this.postRequest("/user/update", params).then((res) => {
              this.submitLoading = false;
              if (res.success) {
                this.$Message.success("操作成功");
                this.$emit("on-submit", true);
                this.visible = false;
              }
            });
          } else {
            // 添加
            this.submitLoading = true;
            this.postRequest("/login/register", this.form).then((res) => {
              this.submitLoading = false;
              if (res.success) {
                this.$Message.success("操作成功");
                this.$emit("on-submit", true);
                this.visible = false;
              }
            });
          }
        }
      });
    },
    setCurrentValue(value) {
      if (value === this.visible) {
        return;
      }
      if (this.type == "1") {
        this.title = "编辑用户";
        this.maxHeight =
          Number(document.documentElement.clientHeight - 121) + "px";
      } else if (this.type == "2") {
        this.title = "添加用户";
        this.maxHeight =
          Number(document.documentElement.clientHeight - 121) + "px";
      } else {
        this.title = "用户详情";
        this.maxHeight = "100%";
      }
      // 清空数据
      this.$refs.form.resetFields();
      if (this.type == "0" || this.type == "1") {
        // 回显数据
        let data = this.data;
        // 密码强度
        if (data.passStrength == "弱") {
          this.passColor = "#ed3f14";
        } else if (data.passStrength == "中") {
          this.passColor = "#faad14";
        } else if (data.passStrength == "强") {
          this.passColor = "#52c41a";
        }
        // 回显
        this.form = data;
      } else {
        // 添加
        this.form = {
          type: 0,
          sex: "",
          address: [],
        };
      }
      this.visible = value;
    },
  },
};
</script>

<style lang="less">
@import "../../../styles/drawer-common.less";
</style>