<style lang="less">
@import "@/styles/tree&table-common.less";
</style>
<template>
  <div class="search">
    <Card>
      <Row type="flex" justify="space-between">
        <Col v-if="expand" span="5">
          <Row class="operation">
            <Button @click="addTree" type="primary" icon="md-add">添加</Button>
            <Button @click="handleDropdown('editTree')">编辑</Button>
            <Button @click="handleDropdown('delTree')">删除</Button>
            <Button @click="handleDropdown('refreshTree')">刷新</Button>
          </Row>
          <div style="position: relative">
            <ul class="tree-bar" style="max-height: 800px">
              <li
                v-for="(item, index) in treeData"
                :key="index"
                @click="selectTree(index)"
                :class="selectIndex == index ? 'active' : ''"
              >
                {{ item.name }}
              </li>
            </ul>
            <Spin fix v-if="treeLoading"></Spin>
          </div>
        </Col>
        <div class="expand">
          <Icon
            :type="expandIcon"
            size="16"
            class="icon"
            @click="changeExpand"
          />
        </div>
        <Col :span="span">
          <Row class="operation">
            <Button @click="add" type="primary" icon="md-add">添加</Button>
            <Button @click="getDataList" icon="md-refresh">刷新</Button>
          </Row>
          <Row>
            <Table
              :loading="loading"
              border
              :columns="columns"
              :data="data"
              sortable="custom"
              @on-sort-change="changeSort"
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
        </Col>
      </Row>
    </Card>

    <Modal
      :title="dictModalTitle"
      v-model="dictModalVisible"
      :mask-closable="false"
      :width="500"
    >
      <Form
        ref="dictForm"
        :model="dictForm"
        :label-width="85"
        :rules="dictFormValidate"
      >
        <FormItem label="名称" prop="name">
          <Input v-model="dictForm.name" />
        </FormItem>
        <FormItem label="分值" prop="score">
          <Input v-model="dictForm.score" />
        </FormItem>
        <FormItem label="排序" prop="level">
          <InputNumber
            :max="1000"
            :min="0"
            v-model="dictForm.level"
          ></InputNumber>
        </FormItem>
        <FormItem label="说明" prop="description">
          <Input v-model="dictForm.description" />
        </FormItem>
      </Form>
      <div slot="footer">
        <Button type="text" @click="dictModalVisible = false">取消</Button>
        <Button type="primary" :loading="submitLoading" @click="addGrade"
          >提交</Button
        >
      </div>
    </Modal>

    <Modal
      :title="modalTitle"
      v-model="modalVisible"
      :mask-closable="false"
      :width="500"
    >
      <Form ref="form" :model="form" :label-width="80" :rules="formValidate">
        <FormItem label="说明" prop="description">
          <Input v-model="form.description" />
        </FormItem>
      </Form>
      <div slot="footer">
        <Button type="text" @click="modalVisible = false">取消</Button>
        <Button type="primary" :loading="submitLoading" @click="handelSubmit"
          >提交</Button
        >
      </div>
    </Modal>
  </div>
</template>

<script>
export default {
  mounted() {
    this.init();
  },
  data() {
    return {
      treeLoading: false, // 树加载状态
      loading: false, // 表格加载状态
      editTitle: "", // 编辑节点名称
      searchKey: "", // 搜索树
      expand: true,
      span: 18,
      expandIcon: "ios-arrow-back",
      selectNode: {},
      selectIndex: null,
      treeData: [], // 树数据
      searchForm: {
        pageNumber: 1, // 当前页数
        pageSize: 10, // 页面大小
        sort: "sortOrder", // 默认排序字段
        order: "asc", // 默认排序方式
      },
      modalType: 0, // 添加或编辑标识
      modalVisible: false, // 添加或编辑显示
      dictModalVisible: false,
      dictModalTitle: "",
      modalTitle: "", // 添加或编辑标题
      dictForm: {
        name: "",
        level: null,
        description: "",
        sorce: 0,
      },
      form: {
        grade_id: "",
        description: "",
      },
      dictFormValidate: {
        name: [{ required: true, message: "不能为空", trigger: "change" }],
        level: [{ required: true, message: "不能为空", trigger: "change" }],
        description: [
          { required: true, message: "不能为空", trigger: "change" },
        ],
        sorce: [{ required: true, message: "不能为空", trigger: "change" }],
      },
      formValidate: {
        description: [
          { required: true, message: "不能为空", trigger: "change" },
        ],
      },
      columns: [
        {
          type: "index",
          width: 60,
          align: "center",
        },
        {
          title: "说明",
          key: "description",
        },
        {
          title: "创建时间",
          key: "created_at",
          sortable: true,
          sortType: "desc",
        },
        {
          title: "操作",
          key: "action",
          width: 150,
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
      submitLoading: false, // 添加或编辑提交状态
      data: [], //表单数据
      total: 0, // 表单数据总数
    };
  },
  methods: {
    init() {
      this.getAllGrade();
    },
    changeExpand() {
      this.expand = !this.expand;
      if (this.expand) {
        this.expandIcon = "ios-arrow-back";
        this.span = 18;
      } else {
        this.expandIcon = "ios-arrow-forward";
        this.span = 23;
      }
    },
    changePage(v) {
      this.searchForm.pageNumber = v;
      this.getDataList();
    },
    changePageSize(v) {
      this.searchForm.pageSize = v;
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
    getAllGrade() {
      this.treeLoading = true;
      this.getRequest("/grade/list").then((res) => {
        this.treeLoading = false;
        if (res.success) {
          this.treeData = res.data;
        }
      });
    },
    selectTree(index) {
      if (this.selectIndex == index) {
        this.selectIndex = null;
        this.selectNode = {};
        this.data = [];
        this.total = 0;
      } else {
        this.selectIndex = index;
        this.selectNode = this.treeData[this.selectIndex];
        this.getDataList();
      }
    },
    handleDropdown(name) {
      if (name) {
        this[name]();
      }
    },
    refreshTree() {
      this.getAllGrade();
      this.selectIndex = null;
    },
    addTree() {
      this.modalType = 0;
      this.dictModalTitle = "添加字典";
      this.$refs.dictForm.resetFields();
      this.dictModalVisible = true;
    },
    addGrade() {
      this.$refs.dictForm.validate((valid) => {
        if (valid) {
          this.submitLoading = true;
          if (this.modalType == 0) {
            delete this.dictForm.id;
          }
          this.postRequest("/grade/edit", this.dictForm).then((res) => {
            this.submitLoading = false;
            if (res.success) {
              this.$Message.success("操作成功");
              this.getAllGrade();
              this.dictModalVisible = false;
            }
          });
        }
      });
    },
    editTree() {
      if (this.selectIndex == null) {
        return this.$Message.warning("您还未选择要操作的等级");
      }
      this.dictForm = this.selectNode;
      this.modalType = 1;
      this.dictModalTitle = "编辑字典";
      this.dictModalVisible = true;
    },
    delTree() {
      if (this.selectIndex == null) {
        return this.$Message.warning("您还未选择要操作的等级");
      }
      this.$Modal.confirm({
        title: "确认删除",
        loading: true,
        content: "您确认要删除 " + this.selectNode.name + " ?",
        onOk: () => {
          this.getRequest("/grade/delete", { ids: this.selectNode.id }).then(
            (res) => {
              this.$Modal.remove();
              if (res.success) {
                this.$Message.success("操作成功");
                this.refreshTree();
              }
            }
          );
        },
      });
    },
    getDataList() {
      this.loading = true;
      let params = { ...this.searchForm };
      params.grade_id = this.selectNode.id;
      this.getRequest("/power/list", params).then((res) => {
        this.loading = false;
        if (res.success) {
          this.data = res.data.rows;
          this.total = res.data.total;
        }
      });
    },
    add() {
      if (this.selectIndex == null) {
        return this.$Message.warning("您还未选择要操作的等级");
      }
      this.modalType = 0;
      this.modalTitle = "添加特权";
      this.$refs.form.resetFields();
      this.modalVisible = true;
    },
    edit(v) {
      this.modalType = 1;
      this.modalTitle = "编辑特权";
      this.$refs.form.resetFields();
      this.form = { ...v };
      this.modalVisible = true;
    },
    handelSubmit() {
      this.$refs.form.validate((valid) => {
        if (valid) {
          this.submitLoading = true;
          if (this.modalType == 0) {
            delete this.form.id;
            this.form.grade_id = this.selectNode.id;
          }
          this.postRequest("/power/edit", this.form).then((res) => {
            this.submitLoading = false;
            if (res.success) {
              this.$Message.success("操作成功");
              this.getDataList();
              this.modalVisible = false;
            }
          });
        }
      });
    },
    remove(v) {
      this.$Modal.confirm({
        title: "确认删除",
        content: "您确认要删除?",
        loading: true,
        onOk: () => {
          this.getRequest("/power/delete", { id: v.id }).then((res) => {
            this.$Modal.remove();
            if (res.success) {
              this.$Message.success("操作成功");
              this.getDataList();
            }
          });
        },
      });
    },
  },
};
</script>
<style>
.tree-bar {
  border: 1px solid #dcdee2;
}
.tree-bar li {
  padding: 5px;
}
.tree-bar li:hover,
.tree-bar .active {
  background-color: #d5e8fc;
}
</style>