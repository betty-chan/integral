<template>
	<view class="content">
	    <ren-calendar ref='ren' :markDays='markDays' :weekstart="1" :open="false" @onDayClick='onDayClick'></ren-calendar>
	</view>
</template>

<script>
import RenCalendar from '@/components/ren-calendar/ren-calendar.vue'
export default {
	components:{
		RenCalendar
	},
	data() {
		return {
			refreshing: false,
			open:false,
			list: [],
			markDays:[],
			curDate:null,
		}
	},
	onReady() {
		let today = this.$refs.ren.getToday().date;
		this.curDate = today;
		this.markDays.push(today);
	},
	methods: {
		onDayClick(data){
			 this.curDate = data.date;
		},
	}
}
</script>

<style scoped>
uni-page-body{
	background-color: #97bcff;
}
</style>