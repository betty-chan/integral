<template>
	<view class="index">
		<view>
			<l-barrage ref="lBarrage" @end=""></l-barrage>
		</view>
		<view class="tag-add" @click="add">
			<button type="default">+</button>
		</view>
	</view>
</template>

<script>
	import lBarrage from '@/components/l-barrage/l-barrage.vue'
	export default {
		components:{lBarrage},
		mounted(){
			this.init()
		},
		onShow() {
			this.init()
		},
		data() {
			return {
				data: [
					{
						id: 1,
						username: '贝贝',
						description: 'http://placehold.it/150x150'
					},
					{
						id: 2,
						username: '兰兰',
						description: 'http://placehold.it/150x150'
					},
				]
			}
		},
		methods: {
			init(){
				this.getWishList();
			},
			getWishList(){
				var token = uni.getStorageSync('token');
				uni.request({
					url: '/xboot/api/v2/wish/list?pageNumber=1&pageSize=50&sort=createTime&order=desc', 
					method: "GET",
					header: {
						token: token, //自定义请求头信息
					},
				}).then((data)=>{
					let [error, res]  = data;
					res = res.data;
					if(res.success){
						let data = res.data.rows.map((item)=>{
							return {
								description:item.description,
								username:item.username
							}
						})
						this.$refs.lBarrage.start(data);
					}
				});
			},
			goList(value) {
				uni.navigateTo({
					url:'../list/list?type=' + value.type + '&id=' + value.id
				})
			},
			add(){
				uni.navigateTo({
					url:'../wish/detail'
				})
			}
		}
	}
</script>

<style>
.index{
	background-image: url(../../static/space.jpg);
}
</style>
