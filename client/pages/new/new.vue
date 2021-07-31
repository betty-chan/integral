<template>
	<view class="content">
	    <ren-calendar ref='ren' :markDays='markDays' :weekstart="1" :open="false" @onDayClick='onDayClick' :disabledAfter="true"></ren-calendar>
		<view class="card">
			<block v-for="(item, index) in list" :key="index">
				<view style="padding: 5rpx;">
					<checkbox v-model="item.status"/>
					<text class="card-title">{{item.title}}</text>
				</view>
			</block>
		</view>
	</view>
</template>

<script>
import RenCalendar from '@/components/ren-calendar/ren-calendar.vue'
export default {
	components:{
		RenCalendar
	},
	data() {
		return {
			refreshing: false,
			open:false,
			providerList: [],
			list: [],
			fetchPageNum: 1,
			markDays:[],
			curDate:null,
		}
	},
	onReady() {
		let today = this.$refs.ren.getToday().date;
		this.curDate = today;
		this.markDays.push(today);
	},
	onLoad() {
		this.getData();
		uni.getProvider({
			service: "share",
			success: (e) => {
				let data = []
				this.providerList = data;
			},
			fail: (e) => {
				console.log("获取登录通道失败", e);
			}
		});
	},
	methods: {
		onDayClick(data){
			 this.curDate = data.date;
		},
		getData() {
			uni.request({
				url: this.$serverUrl + '/api/picture/posts.php?page=' + (this.refreshing ? 1 : this.fetchPageNum) + '&per_page=5',
				success: (ret) => {
					console.log("data",ret);
					if (ret.statusCode !== 200) {
						console.log("失败!");
					} else {
						if (this.refreshing && ret.data[0].id === this.list[0].id) {
							uni.showToast({
								title: "已经最新",
								icon: "none",
							})
							this.refreshing = false;
							uni.stopPullDownRefresh();
							return;
						}
						if (this.refreshing) {
							this.refreshing = false;
							uni.stopPullDownRefresh()
							this.list = ret.data;
							this.fetchPageNum = 2;
						} else {
							this.list = this.list.concat(ret.data);
							this.fetchPageNum += 1;
						}
					}
				}
			});
		},
		goDetail(e) {
			uni.navigateTo({
				url:"../detail/detail?data=" + encodeURIComponent(JSON.stringify(e))
			})
		},
	}
}
</script>

<style scoped>
uni-page-body{
	background-color: #97bcff;
}
</style>