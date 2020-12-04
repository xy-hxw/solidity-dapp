App = {
  web3Provider: null,
  contracts: {},

  init: async function() {
    // Load pets.
    $.getJSON('../pets.json', function(data) {
      var petsRow = $('#petsRow');
      var petTemplate = $('#petTemplate');

      for (i = 0; i < data.length; i ++) {
        petTemplate.find('.panel-title').text(data[i].name);
        petTemplate.find('img').attr('src', data[i].picture);
        petTemplate.find('.pet-breed').text(data[i].breed);
        petTemplate.find('.pet-age').text(data[i].age);
        petTemplate.find('.pet-location').text(data[i].location);
        petTemplate.find('.btn-adopt').attr('data-id', data[i].id);

        petsRow.append(petTemplate.html());
      }
      
    });

    return await App.initWeb3();
  },

  initWeb3: async function() {
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
    $.getJSON("Adoption.json", function(data){
      var AdoptionArtifact = data;
      App.contracts.Adoption = TruffleContract(AdoptionArtifact);
      App.contracts.Adoption.setProvider(App.web3Provider);
      return App.markAdopted();
    });

    $.getJSON("HdToken.json", function(data){
      var AdoptionArtifact = data;
      App.contracts.HdToken = TruffleContract(AdoptionArtifact);
      App.contracts.HdToken.setProvider(App.web3Provider);
      return App.test();
    });

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '.btn-adopt', App.handleAdopt);
  },

  markAdopted: function(adopters, account) {
    var adoptionInstance;
    App.contracts.Adoption.deployed().then(function(instance){
      adoptionInstance = instance;
      return adoptionInstance.getAdopters.call();
    }).then(function(adopters){
      for (i = 0; i < adopters.length; i++) {
        if(adopters[i] !== '0x0000000000000000000000000000000000000000') {
          $('.panel-pet').eq(i).find('button').text('Success').attr('disabled', true);
        }
      }
    }).catch(function(err){
      console.log(err.message);
    })
  },

  handleAdopt: function(event) {
    event.preventDefault();

    var petId = parseInt($(event.target).data('id'));

    web3.eth.getAccounts(function(error, accounts){
      var account = accounts[0];
      App.contracts.Adoption.deployed().then(function(instance){
        adoptionInstance = instance;
        return adoptionInstance.adopt(petId, {from: account});
      }).then(function(result){
        console.log(result);
        return App.markAdopted();
      }).catch(function(err){
        console.log(err.message);
      })
    })
  },

  math: function(event) {
    let address = web3.eth.defaultAccount;
    console.log("address="+address);
    web3.eth.getBalance(address, function(err, res){
      console.log(res.toNumber());
    });

    web3.eth.getAccounts(function(error, accounts){
      var account = accounts[0];
      App.contracts.Math.deployed().then(function(instance){
        adoptionInstance = instance;
        var result = adoptionInstance.addFunc.call(2, 9);
        console.log(result);
        return result;
      }).then(function(result){
        console.log("---"+result.toNumber());
        return App.markAdopted();
      }).catch(function(err){
        console.log(err.message);
      })
    })
  },

  test: function(event) {
    let address = web3.eth.defaultAccount;
    console.log("address="+address);
    
    var aa = App.contracts.HdToken.deployed().then(function(instance){
        return instance.totalSupply();
      }).then(function(result){
        console.log("---"+result);
        return result;
      }).catch(function(err){
        console.log(err.message);
      })
    console.log(aa);
  }
};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
