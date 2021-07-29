<template>
	<view class="center">
		<view class="center-list">
			<view class="center-list-item">
				<text class="list-text">昵称</text>
				<text class="navigat-arrow">&#xe65e;</text>
			</view>
			<view class="center-list-item">
				<text class="list-text">邮箱</text>
				<text class="navigat-arrow">&#xe65e;</text>
			</view>
			<view class="center-list-item">
				<text class="list-text">出生年月</text>
				<text class="navigat-arrow">&#xe65e;</text>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
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
			},
			goOther(url){
				uni.navigateTo({
					url
				})
			},
		}
	}
</script>

<style>
</style>
