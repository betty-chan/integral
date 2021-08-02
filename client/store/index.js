import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);
const store = new Vuex.Store({  
    state: {  
        login: false,  
        token: '',  
        avatarUrl: '',  
        userName: '',
		user_id: null,
		
		sumSorce:0,
		selectGoods: null,
		selectMedal:null,
    },  
    mutations: {  
        login(state, provider) {  
            state.login = true;  
            state.token = provider.token;  
            state.userName = provider.userName;  
            state.avatarUrl = provider.avatarUrl;  
        },  
        logout(state) {  
            state.login = false;  
            state.token = '';  
            state.userName = '';  
            state.avatarUrl = '';  
        }  
    }  
})