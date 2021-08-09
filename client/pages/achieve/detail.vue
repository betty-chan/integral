<template>
	<view>
		<view style="padding: 10px;">
			<view style="text-align: center;"><image :src="$store.selectMedal.icon"  style="width: 80px;height: 80px;"></image></view>
			<view style="font-size: 20px;">{{$store.selectMedal.name}}</view>
			<view style="font-size: 14px;">{{$store.selectMedal.description}}</view>
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
