<template>
	<view>
		<view>
			<image :src="$store.selectGoods.cover_img"  style="width: 100%;"></image>
			<view>{{$store.selectGoods.title}}</view>
			<view>{{$store.selectGoods.description}}</view>
			<view>年龄要求：{{$store.selectGoods.limit?`${$store.selectGoods.limit}岁及以上`:'无'}}</view>
			<image :src="$store.selectGoods.other_img"  style="width: 100%;"></image>
		</view>
		<view>
			<button type="default" @click="submit" :disabled="disabled">确认兑换</button>
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
				user_id: null,
				selectGoods:{},
				disabled:true,
			}
		},
		methods: {
			init(){
				var userInfo = JSON.parse(uni.getStorageSync('userInfo'));
				if(userInfo){
					this.user_id = userInfo.userId;
				}
				this.disabled = this.$store.sumSorce<this.$store.selectGoods.value;
			},
			submit(){
				var token = uni.getStorageSync('token');
				uni.request({
					url: '/xboot/api/v2/record/add', 
					method: "POST",
					data:{
						goods_id: this.$store.selectGoods.id,
						user_id: this.user_id,
						value: this.$store.selectGoods.value,
					},
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
