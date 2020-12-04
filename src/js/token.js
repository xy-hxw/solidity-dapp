App = {
	web3Provider: null,
	contracts: {},
	
	init: async function() {
	  	// 是否当前浏览器提供web3(如 metaMask)?
		if (typeof web3 !== 'undefined') {
			App.web3Provider = web3.currentProvider;  //如果是就直接使用当前的
		} else {
			// 如果没有插件提供的web3, 就向本地的节点要一个
			App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
		}
		web3 = new Web3(App.web3Provider);
		return App.initContract();
	},

	initContract: function() {
		$.getJSON("HdToken.json", function(data){
			var AdoptionArtifact = data;
			App.contracts.HdToken = TruffleContract(AdoptionArtifact);
			App.contracts.HdToken.setProvider(App.web3Provider);
			return App.info();
		});
	},

	info: async function() {
		let address = web3.eth.defaultAccount;
		$('#address').html(address);
		let name = await App.para('name');
		$('#name').html(name);
		let symbol = await App.para('symbol');
		$('#symbol').html(symbol);

		let totalSupply = await App.para('totalSupply');
		$('#totalSupply').html(Number(totalSupply));
		let balance = await App.para('balanceOf', {"addr":address});
		$('#balance').html(Number(balance));
	},


	para: async function(key, obj) {
		var name = await App.contracts.HdToken.deployed().then(function(instance){
				if (obj) {
					return instance[key](obj.addr);
				} 
				return instance[key]();
			}).then(function(result){
				return result;
			}).catch(function(err){
				console.log(err.message);
			});
		return name;
	}
};

$(function() {
	$(window).load(function() {
		App.init();
	});
});

// 0xd7C859D2e1a4A75d097DDb6E8aaC3FF892A2Df4A
async function send() {
	var to = $('#to').val();
	console.log(11);
	var name = await App.contracts.HdToken.deployed().then(function(instance){
		return instance.transfer(to, 1);
	}).then(function(result){
		return result;
	}).catch(function(err){
		console.log(err.message);
	});
}