<template>
	<view>
		<view style="width: 95%;margin: 10px;">
			<textarea placeholder="" style="border:1px solid #c3c3c3;"/>
		</view>
		<view>
			<button type="default" @click="submit">确认</button>
		</view>
	</view>
</template>

<script>
	import lBarrage from '@/components/l-barrage/l-barrage.vue'
	export default {
		components:{lBarrage},
		mounted() {
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
			},
			submit(){
				
			}
		}
	}
</script>

<style>
uni-textarea{
	width: 100%;
}

</style>
