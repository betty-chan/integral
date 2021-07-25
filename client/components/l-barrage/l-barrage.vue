<template>
	<view class="l-barrage">
		<block v-for="(item,index) in items" :key="index">
			<!-- #ifdef H5 -->
			<view class="aon" :style="{top: `${item.top}%`}">
				<image src="../../static/Star.png"  style="width: 28px; height: 28px;"></image>
				<text v-if="item.display" style="line-height: 28px;">
					{{item.text}}
				</text>
			</view>
			<!-- #endif -->
			
			<!-- #ifndef H5 -->
			<view class="aon" :style="{top: `${item.top}%`,animation: `mymove ${Number(item.time)}s linear forwards`}">
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
			default: 4
		},
		maxTime: {
			type: Number,
			default: 9
		},
		minTop: {
			type: Number,
			default: 0
		},
		maxTop: {
			type: Number,
			default: 60
		}
	},
	data() {
		return {
			items: [],
		}
	},
	methods: {
		add(text = '',time = Math.ceil(Math.floor(Math.random()*(this.maxTime-this.minTime+1)+this.minTime))) {
			this.items.push({
				text,
				time,
				top: Math.ceil(Math.random()*(this.maxTop-this.minTop+1)+this.minTop),
				display: 1,
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
					this.add(items[i],time);
					i++;
				}
				else {
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
.l-barrage{
  z-index: 3;
  width: 100%;
  position: fixed;
}

@keyframes mymove
{
from{left: 100%;}
  to{left: -200%;}
}

@-moz-keyframes mymove /* Firefox */
{
from{left: 100%;}
  to{left: -200%;}
}

@-webkit-keyframes mymove /* Safari and Chrome */
{
from{left: 100%;}
  to{left: -200%;}
}

@-o-keyframes mymove /* Opera */
{
from{left: 100%;}
  to{left: -200%;}
}
</style>
