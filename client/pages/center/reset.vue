<template>
	<form class='loginView' @submit="submit">
		<view class="input-view">
			<view class="label-view">
				<text class="label">旧密码</text>
			</view>
			<input class="input" type="password" placeholder="请输入旧密码" v-model="form.oldPassword"  />
		</view>
		<view class="input-view">
			<view class="label-view">
				<text class="label">密码</text>
			</view>
			<input class="input" type="password" placeholder="请输入密码" v-model="form.password"  />
		</view>
		<view class="button-view">
			<button type="default" class="login" hover-class="hover" formType="submit">确认</button>
		</view>
	</form>
</template>

<script>
	export default {
		data() {
			return {
				form:{
					oldPassword:null,
					password:null,
				}
			};
		},
		methods: {
			submit() {
				// var token = uni.getStorageSync('token');
				// uni.request({
				//     url: '/xboot/api/v2/login', 
				// 	method: "POST",
				// header: {
				// 	token: token, //自定义请求头信息
				// },
				// 	data:{
				// 	    email: this.form.username,
				// 	    password: this.form.password,
				// 	}
				// }).then((data)=>{
				// 	let [error, res]  = data;
				// 	res = res.data;
				// 	if(res.success){
				// 		uni.setStorageSync('token',res.data.token);
				// 		this.getUserInfo();
				// 		uni.navigateBack();
				// 	}
				// });
			},
		}
	}
</script>

<style>
	
</style>
