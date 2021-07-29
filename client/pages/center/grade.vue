<template>
	<view class="index">
		<swiper style="height: 160rpx;margin: 20rpx;" previous-margin="5%" next-margin="5%" @change="change" :current="selectIndex">
			<swiper-item class="swiper-container" v-for="(item,index) in gradeList" :key="index" :item-id="index" :data-year="index">
				<view class="swiper-item" :style="{background: colorList[index],backgroundSize:'cover'}" >
				  	{{item.name}}
				</view>
			</swiper-item>
		</swiper>
		<view>
			<view>{{selectIndex==myGradeIndex?"我的":gradeList[selectIndex].name}}等级</view>
			<view v-if="gradeList&& gradeList[selectIndex].list">
				<view v-for="(item,index) in gradeList[selectIndex].list">
					{{item.description}}
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		mounted(){
			this.init()
		},
		onShow() {
			this.init()
		},
		data() {
			return {
				sum:0,
				gradeList:[],
				selectIndex:0,
				myGradeIndex: 0,
				myGrade:null,
				userInfo:{},
				colorList:["#00aaff","#ffaa00","#e6e6e6","#000000"]
			}
		},
		methods: {
			init(){
				var userInfo = JSON.parse(uni.getStorageSync('userInfo'));
				if(userInfo){
					this.userInfo = userInfo;
					this.sumSorce()
				}
				this.getGradeList();
			},
			change(e) {
				this.selectIndex = e.detail.current;
				this.getPowerList();
			},
			getPowerList(){
				if(this.gradeList[this.selectIndex] && !this.gradeList[this.selectIndex].list){
					var token = uni.getStorageSync('token');
					uni.request({
						url: '/xboot/api/v2/power/list', 
						method: "GET",
						data:{
							pageNumber:1,
							pageSize:10,
							grade_id: this.gradeList[this.selectIndex].id
						},
						header: {
							token: token, //自定义请求头信息
						},
					}).then((data)=>{
						let [error, res]  = data;
						res = res.data;
						if(res.success){
							this.gradeList[this.selectIndex].list = res.data.rows;
						}
					});
				}
			},
			getGradeList(){
				var token = uni.getStorageSync('token');
				uni.request({
					url: '/xboot/api/v2/grade/list?pageNumber=1&pageSize=10&sort=createTime&order=desc', 
					method: "GET",
					header: {
						token: token, //自定义请求头信息
					},
				}).then((data)=>{
					let [error, res]  = data;
					res = res.data;
					if(res.success){
						this.gradeList = res.data.rows;
						this.sumSorce();
					}
				});
			},
			sumSorce(){
				var token = uni.getStorageSync('token');
				uni.request({
					url: '/xboot/api/v2/sorce/sum?pageNumber=1&pageSize=50', 
					method: "GET",
					data:{
						type:1,
						user_id: this.userInfo.userId
					},
					header: {
						token: token, //自定义请求头信息
					},
				}).then((data)=>{
					let [error, res]  = data;
					res = res.data;
					if(res.success){
						this.sum = res.data || 0;
						this.getMyGrade();
					}
				});
			},
			getMyGrade(){
				this.gradeList.forEach((item,key)=>{
					if(this.sum >= item.score){
						this.myGradeIndex = key;
						this.myGrade = item.name;
					}
				})
				this.selectIndex = this.myGradeIndex
				this.getPowerList();
			}
		}
	}
</script>

<style>
.swiper-item{
	height: 90%;
}
</style>
