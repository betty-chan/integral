<template>
	<view>
		<view style="width: 95%;margin: 10px;">
			<textarea v-model="form.description" placeholder="" style="border:1px solid #c3c3c3;"/>
		</view>
		<view>
			<button type="default" @click="submit">确认</button>
		</view>
	</view>
</template>

<script>
	export default {
		mounted() {
			this.init()
		},
		data() {
			return {
				form:{
					description:null,
					user_id:null,
				}
			}
		},
		methods: {
			init(){
				var userInfo = JSON.parse(uni.getStorageSync('userInfo'));
				if(userInfo){
					this.form.user_id = userInfo.userId;
				}
			},
			submit(){
				var token = uni.getStorageSync('token');
				uni.request({
					url: '/xboot/api/v2/wish/add', 
					method: "POST",
					data:this.form,
					header: {
						token: token, //自定义请求头信息
					},
				}).then((data)=>{
					let [error, res]  = data;
					res = res.data;
					if(res.success){
						uni.navigateBack();
					}
				});
			},
		}
	}
</script>

<style>
uni-textarea{
	width: 100%;
}
</style>
