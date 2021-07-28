<template>
	<view>
		<view>
			{{sum}}
		</view>
		<view>
			
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
				uerInfo:{},
				sum:0,
			}
		},
		methods: {
			init(){
				var userInfo = JSON.parse(uni.getStorageSync('userInfo'));
				if(userInfo){
					this.uerInfo = userInfo;
					this.sumSorce()
				}
			},
			sumSorce(){
				var token = uni.getStorageSync('token');
				uni.request({
					url: '/xboot/api/v2/sorce/sum', 
					method: "GET",
					data:{
						type:2,
						user_id: this.uerInfo.userId
					},
					header: {
						token: token, //自定义请求头信息
					},
				}).then((data)=>{
					let [error, res]  = data;
					res = res.data;
					if(res.success){
						this.sum = res.data;
					}
				});
			},
		}
	}
</script>

<style>

</style>
