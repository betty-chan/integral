<template>
  <div></div>
</template>

<script>
export default {
  name: "home",
  components: {},
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
  mounted() {
    this.init();
  },
  computed: {
    currNav() {
      return this.$store.state.app.currNav;
    },
  },
  methods: {
    init() {},
  },
};
</script>
<style lang="less">
@import "./home.less";
@import "../../styles/common.less";
</style>