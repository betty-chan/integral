<template>
	<view>
		<view>
			<image :src="$store.selectMedal.icon"  style="width: 80rpx;height: 80rpx;"></image>
			<view>{{$store.selectMedal.name}}</view>
			<view>{{$store.selectMedal.description}}</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
			}
		},
		methods: {
			init(){},
		}
	}
</script>

<style>
</style>
