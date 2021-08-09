<template>
	<view class="center">
		<view>
			<view style="width: 40%;display: inline-block;padding: 10rpx;margin: 5rpx;text-align: center;" v-for="item in data" @click="goDetail(item)">
				<view><image v-if="item.icon" :src="item.user_id?item.icon:item.grey_icon"  style="width: 45px;height: 45px;"></image> </view>
				<text style="white-space:nowrap;overflow-y:hidden ;">{{item.name}}</text>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				uerInfo:{},
				data:[]
			}
		},
		mounted(){
			this.init()
		},
		onShow() {
			this.init()
		},
		methods: {
			init(){
				var userInfo = JSON.parse(uni.getStorageSync('userInfo'));
				if(userInfo){
					this.userInfo = userInfo;
					this.getMedal()
				}
			},
			getMedal(){
				var token = uni.getStorageSync('token');
				uni.request({
					url: '/xboot/api/v2/achieve/list?pageNumber=1&pageSize=50', 
					method: "GET",
					data:{},
					header: {
						token: token, //自定义请求头信息
					},
				}).then((data)=>{
					let [error, res]  = data;
					res = res.data;
					if(res.success){
						this.data = res.data.rows;
					}
				});
			},
			goDetail(item){
				this.$store.selectMedal = item;
				uni.navigateTo({
					url:'../achieve/detail'
				})
			}
		}
	}
</script>

<style>
</style>
