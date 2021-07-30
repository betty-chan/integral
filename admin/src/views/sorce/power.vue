<style lang="less">
@import "@/styles/tree&table-common.less";
</style>
<template>
  <div class="search">
    <Card>
      <Row type="flex" justify="space-between">
        <Col v-if="expand" span="5">
          <Row class="operation">
            <Button @click="addDcit" type="primary" icon="md-add">添加</Button>
            <Dropdown @on-click="handleDropdown">
              <Button>
                更多操作
                <Icon type="md-arrow-dropdown" />
              </Button>
              <DropdownMenu slot="list">
                <DropdownItem name="editDcit">编辑</DropdownItem>
                <DropdownItem name="delDcit">删除</DropdownItem>
                <DropdownItem name="refreshDcit">刷新</DropdownItem>
              </DropdownMenu>
            </Dropdown>
          </Row>
          <Alert show-icon>
            当前选择：
            <span class="select-title">{{ editTitle }}</span>
            <a class="select-clear" v-if="editTitle" @click="cancelEdit"
              >取消选择</a
            >
          </Alert>
          <div style="position: relative">
            <div class="tree-bar" style="max-height: 800px">
              <Tree
                ref="tree"
                :data="treeData"
                @on-select-change="selectTree"
              ></Tree>
            </div>
            <Spin size="large" fix v-if="treeLoading"></Spin>
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
        <Button
          type="primary"
          :loading="submitLoading"
          @click="handelSubmitDict"
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
import {
  getAllDictList,
  addDict,
  editDict,
  deleteDict,
  searchDict,
  getAllDictDataList,
  addDictData,
  editDictData,
  deleteData,
} from "@/api/index";
export default {
  name: "dic-manage",
  data() {
    return {
      openSearch: true,
      openTip: true,
      treeLoading: false, // 树加载状态
      maxHeight: "800px",
      loading: false, // 表格加载状态
      editTitle: "", // 编辑节点名称
      searchKey: "", // 搜索树
      expand: true,
      span: 18,
      expandIcon: "ios-arrow-back",
      selectNode: {},
      treeData: [], // 树数据
      selectList: [], // 多选数据
      searchForm: {
        name: "",
        status: "",
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
      this.getAllDict();
      this.getDataList();
    },
    getAllDict() {
      this.treeLoading = true;
      this.getRequest("/grade/list").then((res) => {
        this.treeLoading = false;
        if (res.success) {
          this.treeData = res.result;
        }
      });
    },
    search() {
      // 搜索树
      if (this.searchKey) {
        this.treeLoading = true;
        searchDict({ key: this.searchKey }).then((res) => {
          this.treeLoading = false;
          if (res.success) {
            this.treeData = res.result;
          }
        });
      } else {
        // 为空重新加载
        this.getAllDict();
      }
    },
    selectTree(v) {
      if (v.length > 0) {
        this.$refs.dictForm.resetFields();
        // 转换null为""
        for (let attr in v[0]) {
          if (v[0][attr] == null) {
            v[0][attr] = "";
          }
        }
        let str = JSON.stringify(v[0]);
        let data = JSON.parse(str);
        this.selectNode = data;
        this.dictForm = data;
        this.editTitle = data.title + "(" + data.type + ")";
        // 重新加载表
        this.searchForm.pageNumber = 1;
        this.searchForm.pageSize = 10;
        this.getDataList();
      } else {
        this.cancelEdit();
      }
    },
    cancelEdit() {
      let data = this.$refs.tree.getSelectedNodes()[0];
      if (data) {
        data.selected = false;
      }
      // 取消选择后获取全部数据
      this.selectNode = {};
      this.editTitle = "";
      this.getDataList();
    },
    changeSelect(v) {
      this.selectList = v;
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
      this.clearSelectAll();
    },
    changePageSize(v) {
      this.searchForm.pageSize = v;
      this.getDataList();
    },
    getDataList() {
      this.loading = true;
      if (this.selectNode.id) {
        this.searchForm.dictId = this.selectNode.id;
      } else {
        delete this.searchForm.dictId;
      }
      if (!this.searchForm.status) {
        this.searchForm.status = "";
      }
      getAllDictDataList(this.searchForm).then((res) => {
        this.loading = false;
        if (res.success) {
          this.data = res.result.content;
          this.total = res.result.totalElements;
          if (this.data.length == 0 && this.searchForm.pageNumber > 1) {
            this.searchForm.pageNumber -= 1;
            this.getDataList();
          }
        }
      });
    },
    changeSort(e) {
      this.searchForm.sort = e.key;
      this.searchForm.order = e.order;
      if (e.order == "normal") {
        this.searchForm.order = "";
      }
      this.getDataList();
    },
    showSelect(e) {
      this.selectList = e;
    },
    clearSelectAll() {
      this.$refs.table.selectAll(false);
    },
    refreshDict() {
      this.getAllDict();
      this.selectNode = {};
      this.editTitle = "";
      this.getDataList();
    },
    handleDropdown(name) {
      if (name == "editDcit") {
        if (!this.selectNode.id) {
          this.$Message.warning("您还未选择要编辑的字典");
          return;
        }
        this.editDcit();
      } else if (name == "delDcit") {
        this.delDcit();
      } else if (name == "refreshDcit") {
        this.refreshDict();
      }
    },
    addDcit() {
      this.modalType = 0;
      this.dictModalTitle = "添加字典";
      this.$refs.dictForm.resetFields();
      this.dictForm.sortOrder = this.treeData.length + 1;
      this.cancelEdit();
      this.dictModalVisible = true;
    },
    editDcit() {
      this.modalType = 1;
      this.dictModalTitle = "编辑字典";
      this.dictModalVisible = true;
    },
    delDcit() {
      if (!this.selectNode.id) {
        this.$Message.warning("您还未选择要删除的字典");
        return;
      }
      this.$Modal.confirm({
        title: "确认删除",
        loading: true,
        content: "您确认要删除 " + this.selectNode.title + " ?",
        onOk: () => {
          // 删除
          deleteDict({ ids: this.selectNode.id }).then((res) => {
            this.$Modal.remove();
            if (res.success) {
              this.$Message.success("操作成功");
              this.refreshDict();
            }
          });
        },
      });
    },
    add() {
      if (!this.selectNode.id) {
        this.$Message.warning("请先选择一个字典类别");
        return;
      }
      this.modalType = 0;
      this.modalTitle = "添加字典 " + this.editTitle + " 的数据";
      this.$refs.form.resetFields();
      this.form.sortOrder = this.data.length + 1;
      this.modalVisible = true;
    },
    edit(v) {
      this.modalType = 1;
      if (this.editTitle) {
        this.modalTitle = "编辑字典 " + this.editTitle + " 的数据";
      } else {
        this.modalTitle = "编辑字典数据";
      }
      this.$refs.form.resetFields();
      // 转换null为""
      for (let attr in v) {
        if (v[attr] == null) {
          v[attr] = "";
        }
      }
      let str = JSON.stringify(v);
      let data = JSON.parse(str);
      this.form = data;
      this.modalVisible = true;
    },
    handelSubmitDict() {
      this.$refs.dictForm.validate((valid) => {
        if (valid) {
          this.submitLoading = true;
          if (this.modalType == 0) {
            // 添加 避免编辑后传入id等数据 记得删除
            delete this.dictForm.id;
            addDict(this.dictForm).then((res) => {
              this.submitLoading = false;
              if (res.success) {
                this.$Message.success("操作成功");
                this.getAllDict();
                this.dictModalVisible = false;
              }
            });
          } else if (this.modalType == 1) {
            // 编辑
            editDict(this.dictForm).then((res) => {
              this.submitLoading = false;
              if (res.success) {
                this.$Message.success("操作成功");
                this.getAllDict();
                this.dictModalVisible = false;
              }
            });
          }
        }
      });
    },
    handelSubmit() {
      this.$refs.form.validate((valid) => {
        if (valid) {
          this.submitLoading = true;
          if (this.modalType == 0) {
            // 添加 避免编辑后传入id等数据 记得删除
            delete this.form.id;
            this.form.dictId = this.selectNode.id;
            addDictData(this.form).then((res) => {
              this.submitLoading = false;
              if (res.success) {
                this.$Message.success("操作成功");
                this.getDataList();
                this.modalVisible = false;
              }
            });
          } else if (this.modalType == 1) {
            // 编辑
            editDictData(this.form).then((res) => {
              this.submitLoading = false;
              if (res.success) {
                this.$Message.success("操作成功");
                this.getDataList();
                this.modalVisible = false;
              }
            });
          }
        }
      });
    },
    remove(v) {
      this.$Modal.confirm({
        title: "确认删除",
        content: "您确认要删除 " + v.title + " ?",
        loading: true,
        onOk: () => {
          // 删除
          deleteData({ ids: v.id }).then((res) => {
            this.$Modal.remove();
            if (res.success) {
              this.clearSelectAll();
              this.$Message.success("操作成功");
              this.getDataList();
            }
          });
        },
      });
    },
  },
  mounted() {
    this.init();
  },
};
</script>