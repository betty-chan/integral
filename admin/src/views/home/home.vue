<style lang="less">
@import "./home.less";
@import "../../styles/common.less";
</style>

<template>
  <div>
    <div v-show="currNav == 'xboot'" class="home">
      <Row :gutter="10">
        <i-col :lg="24" :xl="8">
          <Row :gutter="10">
            <i-col :lg="12" :xl="24" :style="{ marginBottom: '10px' }">
              <Card>
                <Row type="flex" class="user-info">
                  <i-col span="8">
                    <Row
                      class-name="made-child-con-middle"
                      type="flex"
                      align="middle"
                    >
                      <img class="avator-img" :src="avatarPath" />
                    </Row>
                  </i-col>
                  <i-col span="16" style="padding-left: 6px">
                    <Row
                      class-name="made-child-con-middle"
                      type="flex"
                      align="middle"
                    >
                      <div>
                        <b class="card-user-info-name">{{ username }}</b>
                        <p>您好，欢迎您的使用</p>
                      </div>
                    </Row>
                  </i-col>
                </Row>
                <div class="line-gray"></div>
                <Row class="margin-top-8">
                  <i-col span="8">
                    <p class="notwrap">本次登录地点:</p>
                  </i-col>
                  <i-col span="16" class="padding-left-8">{{ city }}</i-col>
                </Row>
              </Card>
            </i-col>
            <i-col :lg="12" :xl="24" style="margin-bottom: 10px">
              <Card>
                <p slot="title">
                  <Icon
                    type="logo-github"
                    size="20"
                    style="margin-right: 5px"
                  />
                </p>
                <div style="height: 268px">
                  <Timeline>
                    <TimelineItem>
                      <Icon
                        type="logo-youtube"
                        color="#fb7299"
                        slot="dot"
                      ></Icon>
                    </TimelineItem>
                    <TimelineItem>
                      <Icon
                        type="logo-youtube"
                        color="#fb7299"
                        slot="dot"
                      ></Icon>
                    </TimelineItem>
                  </Timeline>
                </div>
              </Card>
            </i-col>
          </Row>
        </i-col>
        <i-col :lg="24" :xl="16">
          <Row :gutter="5">
            <i-col :sm="24" :md="12" :lg="6" :style="{ marginBottom: '10px' }">
              <info-card
                id-name="user_created_count"
                :end-val="count.createUser"
                iconType="md-person-add"
                color="#2d8cf0"
                intro-text="今日新增用户"
              ></info-card>
            </i-col>
            <i-col :sm="24" :md="12" :lg="6" :style="{ marginBottom: '10px' }">
              <info-card
                id-name="visit_count"
                :end-val="count.visit"
                iconType="ios-eye"
                color="#64d572"
                :iconSize="50"
                intro-text="今日浏览量"
              ></info-card>
            </i-col>
            <i-col :sm="24" :md="12" :lg="6" :style="{ marginBottom: '10px' }">
              <info-card
                id-name="collection_count"
                :end-val="count.collection"
                iconType="md-cloud-upload"
                color="#ffd572"
                intro-text="今日数据采集量"
              ></info-card>
            </i-col>
            <i-col :sm="24" :md="12" :lg="6" :style="{ marginBottom: '10px' }">
              <info-card
                id-name="transfer_count"
                :end-val="count.transfer"
                iconType="md-shuffle"
                color="#f25e43"
                intro-text="今日服务调用量"
              ></info-card>
            </i-col>
          </Row>
        </i-col>
      </Row>
      <Row :gutter="10">
        <i-col :lg="24" :xl="16" :style="{ marginBottom: '10px' }">
          <visit-volume />
        </i-col>
        <i-col :lg="24" :xl="8" :style="{ marginBottom: '10px' }">
          <visit-separation />
        </i-col>
      </Row>
    </div>
  </div>
</template>

<script>
import { ipInfo } from "@/api/index";
import visitVolume from "./components/visitVolume.vue";
import visitSeparation from "./components/visitSeparation.vue";
import infoCard from "./components/infoCard.vue";
import Cookies from "js-cookie";
export default {
  name: "home",
  components: {
    visitVolume,
    visitSeparation,
    infoCard,
  },
  data() {
    return {
      showVideo: false,
      count: {
        createUser: 496,
        visit: 3264,
        collection: 24389305,
        transfer: 39503498,
      },
      city: "",
      username: "",
    };
  },
  computed: {
    currNav() {
      return this.$store.state.app.currNav;
    },
    avatarPath() {
      return localStorage.avatorImgPath;
    },
  },
  methods: {
    init() {
      let userInfo = JSON.parse(Cookies.get("userInfo"));
      this.username = userInfo.nickname;
      ipInfo().then((res) => {
        if (res.success) {
          this.city = res.result;
        }
      });
    },
    showNotice() {
      getNotice().then((res) => {
        if (res.success) {
          if (!res.result) {
            return;
          }
          let data = res.result;
          if (
            data.open &&
            (data.title || data.content) &&
            data.position == "HOME"
          ) {
            this.$Notice.info({
              title: data.title,
              desc: data.content,
              duration: data.duration,
            });
          }
        }
      });
    },
  },
  mounted() {
    this.init();
  },
};
</script>