<template>
	<view class="content">
	    <ren-calendar ref='ren' :markDays='markDays' :weekstart="1" :open="false" @onDayClick='onDayClick'></ren-calendar>
		<view class="tag-add" @click="add">
			<button type="default">+</button>
		</view>
		<popup-layer ref="popupRef" :direction="'top'" v-model="boolShow">
		  <view style="padding: 15px;">
			  <input ref="inputRef" type="text" placeholder="请输入" v-model="record"/>
			  <view>
				  <button type="default" style="width: 80px;" @click="submit">确认</button>
			  </view>
		  </view>
		</popup-layer>
	</view>
</template>

<script>
import RenCalendar from '@/components/ren-calendar/ren-calendar.vue'
import popupLayer from '@/components/popup-layer/popup-layer.vue';
export default {
	components:{
		RenCalendar,
		popupLayer
	},
	data() {
		return {
			refreshing: false,
			open:false,
			list: [],
			markDays:[],
			curDate:null,
			record:"",
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
		add(){
			this.$refs.popupRef.show()
			this.$refs.inputRef.focus()
		},
		submit(){
			this.record = "";
			this.$refs.popupRef.close()
		}
	}
}
</script>

<style scoped>
uni-page-body{
	background-color: #97bcff;
}
</style>