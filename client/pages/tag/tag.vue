<template>
	<view class="index">
		<view class="tag-add">
			<button type="default">+</button>
		</view>
	</view>
</template>

<script>
	export default {
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
			goList(value) {
				uni.navigateTo({
					url:'../list/list?type=' + value.type + '&id=' + value.id
				})
			}
		}
	}
</script>

<style>
	
</style>
