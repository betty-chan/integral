<template>
	<view class="center">
		<view class="logo" @click="goLogin" :hover-class="!login ? 'logo-hover' : ''">
			<image class="logo-img" :src="uerInfo.avatarUrl || avatarUrl"></image>
			<view class="logo-title">
				<text class="uer-name">Hi，{{login ? uerInfo.username : '您未登录'}}</text>
				<text class="go-login navigat-arrow">&#xe65e;</text>
			</view>
		</view>
		<view class="center-list">
			<view class="center-list-item border-bottom" @click="goOther('../center/grade')">
				<text class="list-icon">&#xe60c;</text>
				<text class="list-text">会员等级</text>
				<text class="navigat-arrow">&#xe65e;</text>
			</view>
			<view class="center-list-item" @click="goOther('../sorce/list')">
				<text class="list-icon">&#xe60d;</text>
				<text class="list-text">我的积分</text>
				<text class="navigat-arrow">&#xe65e;</text>
			</view>
		</view>
		<view class="center-list">
			<view class="center-list-item" @click="goAbout">
				<text class="list-icon">&#xe603;</text>
				<text class="list-text">关于</text>
				<text class="navigat-arrow">&#xe65e;</text>
			</view>
		</view>
		<view class="center-list">
			<view class="center-list-item border-bottom" @click="goOther('../center/reset')">
				<text class="list-icon">&#xe609;</text>
				<text class="list-text">重置密码</text>
				<text class="navigat-arrow">&#xe65e;</text>
			</view>
			<view class="center-list-item" @click="loginout">
				<text class="list-icon">&#xe601;</text>
				<text class="list-text">退出</text>
				<text class="navigat-arrow">&#xe65e;</text>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				login:false,
				avatarUrl:"../../static/logo.png",
				uerInfo:{}
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
					this.login = true;
					this.uerInfo = userInfo;
				}else{
					uni.navigateTo({
						url:"../login/login"
					})
				}
			},
			goLogin() {
				if(!this.login){
					uni.navigateTo({
						url:"../login/login"
					})
				}else{
					uni.navigateTo({
						url:"../center/info"
					})
				}
			},
			goOther(url){
				uni.navigateTo({
					url
				})
			},
			goAbout() {
				// #ifdef APP-PLUS
				uni.navigateTo({
					url:'/platforms/app-plus/about/about'
				});
				// #endif
				// #ifdef H5
				uni.navigateTo({
					url:'/platforms/h5/about/about'
				});
				// #endif
			},
			loginout(){
				var token = uni.getStorageSync('token');
				uni.request({
					url: '/xboot/api/v2/login/signout', 
					method: "GET",
					header: {
						token: token, //自定义请求头信息
					},
				}).then((data)=>{
					let [error, res]  = data;
					res = res.data;
					if(res.success){
						uni.setStorageSync('token',null);
						uni.setStorageSync('userInfo',null);
						this.login = false;
						this.uerInfo = {}
					}
				});
			}
		}
	}
</script>

<style>
</style>
