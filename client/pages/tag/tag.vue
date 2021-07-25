<template>
	<view class="index">
		<view>
			<l-barrage ref="lBarrage" @end=""></l-barrage>
		</view>
		<view class="tag-add">
			<button type="default">+</button>
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
				this.$refs.lBarrage.start([
				    '新年到，祝福来报到：大财、小财、意外财，财源滚滚',
				    '亲情、爱情、朋友情，份份真情',
				    '官运、财运、桃花运，运运亨通',
				    '爱人、亲人、家里人，人人平安',
				    '福气多多','快乐连连','万事圆圆','微笑甜甜',
				    '一帆风顺','二龙腾飞','三羊开泰','四季平安','五福临门','六六大顺','七星高照','八方来财','九九同心','十全十美！',
				    '新年快乐',
				]);
			},
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
