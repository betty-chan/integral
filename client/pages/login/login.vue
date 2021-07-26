<template>
	<form class='loginView' @submit="login">
		<view class="input-view">
			<view class="label-view">
				<text class="label">账号 </text>
			</view>
			<input class="input" type="text" placeholder="请输入用户名" v-model="form.username" />
		</view>
		<view class="input-view">
			<view class="label-view">
				<text class="label">密码</text>
			</view>
			<input class="input" type="password" placeholder="请输入密码" v-model="form.password"  />
		</view>
		<view class="button-view">
			<button type="default" class="login" hover-class="hover" formType="submit">登录</button>
		<!-- 	<button type="default" class="register" hover-class="hover" @click="register">免费注册</button> -->
		</view>
	</form>
</template>

<script>
	export default {
		data() {
			return {
				form:{
					username:null,
					password:null,
				}
			};
		},
		methods: {
			login(e) {
				uni.request({
				    url: '/xboot/api/v2/login', 
					method: "POST",
					data:{
					    email: this.form.username,
					    password: this.form.password,
					}
				}).then((data)=>{
					let [error, res]  = data;
					res = res.data;
					console.log(res.success);
					if(res.success){
						uni.navigateBack();
					}
				});
			},
			register() {
				console.log("前往注册页面")
			}
		}
	}
</script>

<style>
	
</style>
