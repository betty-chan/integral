<template>
	<view>
		<view style="background-color: #FFFFFF;border-radius: 30rpx;height: 80rpx;margin: 10rpx auto;padding: 10rpx;width: 80%;">
			<view style="width: 50%;display: inline-block;text-align: center;">
				<view>我的积分</view>
				<view>{{sum}}</view>
			</view>
			<view style="width: 50%;display: inline-block;text-align: center;">
				<view>待审核</view>
				<view>{{0}}</view>
			</view>
		</view>
		<view>
		</view>
		<view style="margin: 10rpx auto;">
			<view style="width: 40%;display: inline-block;padding: 10rpx;" v-for="item in goodsList" @click="goDetail(item)">
				<image :src="item.cover_img"  style="width: 100%;"></image>
				<text>{{item.title}}</text>
				<text>{{item.limit}}</text>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	mounted(){
		this.init()
	},
	onShow() {
		this.init()
	},
	data() {
		return {
			userInfo:{},
			sum:0,
			goodsList:[]
		}
	},
	methods: {
		init(){
			var userInfo = JSON.parse(uni.getStorageSync('userInfo'));
			if(userInfo){
				this.userInfo = userInfo;
				this.sumSorce()
			}
			this.getGoodsList();
		},
		sumSorce(){
			var token = uni.getStorageSync('token');
			uni.request({
				url: '/xboot/api/v2/sorce/sum?pageNumber=1&pageSize=50', 
				method: "GET",
				data:{
					type:2,
					user_id: this.userInfo.userId
				},
				header: {
					token: token, //自定义请求头信息
				},
			}).then((data)=>{
				let [error, res]  = data;
				res = res.data;
				if(res.success){
					this.sum = res.data;
					this.$store.sumSorce = this.sum;
				}
			});
		},
		getGoodsList(){
			var token = uni.getStorageSync('token');
			uni.request({
				url: '/xboot/api/v2/goods/list?pageNumber=1&pageSize=10&sort=createTime&order=desc', 
				method: "GET",
				header: {
					token: token, //自定义请求头信息
				},
			}).then((data)=>{
				let [error, res]  = data;
				res = res.data;
				if(res.success){
					this.goodsList = res.data.rows;
				}
			});
		},
		goDetail(item){
			this.$store.selectGoods = item;
			uni.navigateTo({
				url:'../sorce/detail'
			})
		}
	}
}
</script>

<style>

</style>
