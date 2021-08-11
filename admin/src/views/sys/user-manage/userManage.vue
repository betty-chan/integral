<template>
  <div class="search">
    <Card>
      <Row class="operation">
        <Button @click="add" type="primary" icon="md-add">添加用户</Button>
        <Button @click="handleSearch" icon="md-refresh">刷新</Button>
      </Row>
      <Row>
        <Table
          :loading="loading"
          border
          :columns="columns"
          :data="data"
          sortable="custom"
          @on-sort-change="changeSort"
          @on-selection-change="showSelect"
          ref="table"
        ></Table>
      </Row>
      <Row type="flex" justify="end" class="page">
        <Page
          :current="searchForm.pageNumber"
          :total="total"
          :page-size="searchForm.pageSize"
          @on-change="changePage"
          @on-page-size-change="changePageSize"
          :page-size-opts="[10, 20, 50]"
          size="small"
          show-total
          show-elevator
          show-sizer
        ></Page>
      </Row>
    </Card>
    <addEdit
      :data="form"
      :type="showType"
      v-model="showUser"
      @on-submit="getDataList"
    />
  </div>
</template>

<script>
import { deleteUser, resetUserPass } from "@/api/index";
import checkPassword from "@/views/my-components/xboot/check-password";
import addEdit from "./addEdit.vue";
import dict from "@/views/my-components/xboot/dict";
export default {
  name: "user-manage",
  components: {
    checkPassword,
    addEdit,
    dict,
  },
  data() {
    return {
      showUser: false,
      showType: "0",
      loading: true,
      operationLoading: false,
      selectList: [],
      searchKey: "",
      searchForm: {
        username: "",
        mobile: "",
        email: "",
        pageNumber: 1,
        pageSize: 10,
        sort: "createTime",
        order: "desc",
      },
      form: {},
      columns: [
        {
          type: "selection",
          width: 60,
          align: "center",
          fixed: "left",
        },
        {
          type: "index",
          width: 60,
          align: "center",
          fixed: "left",
        },
        {
          title: "用户名",
          key: "username",
          width: 150,
          sortable: true,
          fixed: "left",
        },
        {
          title: "头像",
          key: "avatar",
          width: 80,
          align: "center",
          render: (h, params) => {
            return h("Avatar", {
              props: {
                src: params.row.avatar,
              },
            });
          },
        },
        {
          title: "邮箱",
          key: "email",
          minWidth: 180,
          sortable: true,
        },
        {
          title: "性别",
          key: "sex",
          width: 70,
          align: "center",
          render: (h, params) => {
            let text = "未知";
            if (params.row.sex == 0) {
              text = "男";
            } else if (params.row.sex == 1) {
              text = "女";
            }
            return h("span", text);
          },
        },
        {
          title: "类型",
          key: "type",
          align: "center",
          width: 110,
          render: (h, params) => {
            let re = "普通用户",
              color = "default";
            if (params.row.is_admin == 1) {
              re = "管理员";
              color = "blue";
            }
            return h("div", [
              h(
                "Tag",
                {
                  props: {
                    color: color,
                  },
                },
                re
              ),
            ]);
          },
        },
        {
          title: "操作",
          key: "action",
          width: 170,
          align: "center",
          fixed: "right",
          render: (h, params) => {
            return h("div", [
              h(
                "a",
                {
                  on: {
                    click: () => {
                      this.edit(params.row);
                    },
                  },
                },
                "编辑"
              ),
              h("Divider", {
                props: {
                  type: "vertical",
                },
              }),
              h(
                "a",
                {
                  on: {
                    click: () => {
                      this.remove(params.row);
                    },
                  },
                },
                "删除"
              ),
            ]);
          },
        },
      ],
      data: [],
      total: 0,
    };
  },
  methods: {
    init() {
      this.getDataList();
    },
    handleSelectDep(v) {
      this.searchForm.departmentId = v;
    },
    changePage(v) {
      this.searchForm.pageNumber = v;
      this.getDataList();
      this.clearSelectAll();
    },
    changePageSize(v) {
      this.searchForm.pageSize = v;
      this.getDataList();
    },
    getDataList() {
      this.loading = true;
      this.getRequest("/user/page", this.searchForm).then((res) => {
        this.loading = false;
        if (res.success) {
          this.data = res.data.rows;
          this.total = res.data.total;
        }
      });
    },
    handleSearch() {
      this.searchForm.pageNumber = 1;
      this.searchForm.pageSize = 10;
      this.getDataList();
    },
    changeSort(e) {
      this.searchForm.sort = e.key;
      this.searchForm.order = e.order;
      if (e.order == "normal") {
        this.searchForm.order = "";
      }
      this.getDataList();
    },
    showDetail(v) {
      // 转换null为""
      for (let attr in v) {
        if (v[attr] == null) {
          v[attr] = "";
        }
      }
      let str = JSON.stringify(v);
      let data = JSON.parse(str);
      this.form = data;
      this.showType = "0";
      this.showUser = true;
    },
    add() {
      this.showType = "2";
      this.showUser = true;
    },
    edit(v) {
      // 转换null为""
      for (let attr in v) {
        if (v[attr] == null) {
          v[attr] = "";
        }
      }
      let str = JSON.stringify(v);
      let data = JSON.parse(str);
      this.form = data;
      this.showType = "1";
      this.showUser = true;
    },
    remove(v) {
      this.$Modal.confirm({
        title: "确认删除",
        content: "您确认要删除用户 " + v.username + " ?",
        loading: true,
        onOk: () => {
          deleteUser({ ids: v.id }).then((res) => {
            this.$Modal.remove();
            if (res.success) {
              this.clearSelectAll();
              this.$Message.success("删除成功");
              this.getDataList();
            }
          });
        },
      });
    },
    showSelect(e) {
      this.selectList = e;
      this.selectList.length = e.length;
    },
    clearSelectAll() {
      this.$refs.table.selectAll(false);
    },
  },
  mounted() {
    this.init();
  },
};
</script>
<style lang="less">
@import "../../../styles/table-common.less";
</style>