<template>
	<view class="l-barrage">
		<block v-for="(item,index) in items" :key="index">
			<!-- #ifdef H5 -->
			<view class="aon" :class="`track${item.trackIndex}`" :style="{top: `${item.top}px`}">
				<image src="../../static/Star.png"  style="width: 28px; height: 28px;"></image>
				<text v-if="item.display" style="line-height: 28px;">
					{{item.text}}
				</text>
			</view>
			<!-- #endif -->
			<!-- #ifndef H5 -->
			<view class="aon" :class="`track${item.trackIndex}`" :style="{top: `${item.top}px`,animation: `mymove ${Number(item.time)}s linear forwards`}">
				<image src="../../static/Star.png"  style="width: 28px; height: 28px;"></image>
				<text v-if="item.display" style="line-height: 28px;">
					{{item.text}}
				</text>
			</view>
			<!-- #endif -->		
		</block>
	</view>
</template>

<script>
let cycle;
export default {
	name: 'l-barrage',
	props: {
		minTime: {
			type: Number,
			default: 5
		},
		maxTime: {
			type: Number,
			default: 15
		},
		minTop: {
			type: Number,
			default: 0
		},
		maxTop: {
			type: Number,
			default: 85
		}
	},
	data() {
		return {
			items: [],
			trackHeight: 50,
			trackNum:3,
			tracks:[],
			clientHeight:300
		}
	},
	mounted(){
		this.init();
	},
	methods: {
		init(){
			let screen = document.querySelector("uni-page-wrapper");
			let clientWidth = screen.clientWidth;
			this.clientHeight = screen.clientHeight;
			this.clientHeight = this.clientHeight * (this.maxTop - this.minTop) /100
			this.trackNum = Math.floor(this.clientHeight  / this.trackHeight);
			this.tracks = new Array(this.trackNum).fill('idle');
		},
		getTrackIndex(){
			let index = Math.ceil(Math.random()*(this.trackNum-1));
			let domlist = this.$el.querySelectorAll(`.track${index}`);
			let length = domlist ? domlist.length:0;
			if(length){
				for(let i=0;i<length;i++){
					if(domlist[i].offsetLeft>10){
						return this.getTrackIndex();
					}
				}
			}
			return index;
		},
		add(text = '',username="",time = Math.ceil(Math.floor(Math.random()*(this.maxTime-this.minTime+1)+this.minTime))) {
			let trackIndex = this.getTrackIndex();
			let top = trackIndex*this.trackHeight+ Math.ceil(this.clientHeight *this.minTop/100);
			this.items.push({
				text,
				time,
				top,
				display: 1,
				trackIndex,
				username
			});
		},
		start(items = []) {
			this.items = [];
			cycle && (clearInterval(cycle));
			let i = 0,len = items.length;	
			cycle = setInterval(()=> {
				let time = 5;
				// #ifndef H5
				time = Math.ceil(Math.floor(Math.random()*(this.maxTime-this.minTime+1)+this.minTime));
				// #endif
				if (i < len) {
					this.add(items[i].description,items[i].username,time);
					i++;
				}else {
					clearInterval(cycle);
					setTimeout(()=>{
						this.$emit("end",{});
					},time * 1000)
				}
			}, 500)
		}
	}
}	
</script>

<style>
.l-barrage{
	z-index: 3;
	width: 100%;
	position: fixed;
}
.aon{
	position: fixed;
	white-space:nowrap;
	color: #EEEEEE;
	background-color: #ad08ff;
	border-radius: 32px;
	padding: 5px;
	animation: mymove 20s linear forwards;
	animation-timing-function: linear;
	-webkit-animation-timing-function: linear;
	animation-fill-mode: forwards;
}
@keyframes mymove{
	from{left: 100%;}
	to{left: -200%;}
}
/* Firefox */
@-moz-keyframes mymove{
	from{left: 100%;}
	to{left: -200%;}
}
/* Safari and Chrome */
@-webkit-keyframes mymove{
	from{left: 100%;}
	to{left: -200%;}
}
/* Opera */
@-o-keyframes mymove{
	from{left: 100%;}
	to{left: -200%;}
}
</style>