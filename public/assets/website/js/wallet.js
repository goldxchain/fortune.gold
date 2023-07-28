
let network = $('#ditectNetwork').attr('ditect_network');
let ditectChain = $('#ditectChain').attr('ditect_chain');
let connProvider = detectEthereumProvider();

//sign in by metamask start 
$(document).on('click', '#connect_wallet', function () {

    connProvider.then((provider) => {

        if (provider && provider.isMetaMask) {

            checkConnection();

        } else {

            alert('Please install MetaMask!');
        }

    });
});

//sign in by metamask end 
async function checkConnection() {

    await ethereum.request({
        method: 'eth_accounts'
    }).then(async (res) => {

        const _chainId = await ethereum.request({
            method: 'eth_chainId'
        });

        let chainId = parseInt(_chainId, 16);
        let result = res.length;

        if (result <= 0) {

            connect();

        } else {
            loginAction(chainId, res[0]);
        }

    }).catch(console.error);
}

ethereum.on('accountsChanged', (accounts) => {

    if (accounts.length <= 0) {

        let postData = {};
        $.ajax({
            url: base_url + '/logout-action',
            type: "post",
            data: postData,
            dataType: "json",
            success: function (res) {

                if (res == 1) {
                    window.location.href = base_url;
                }
            }
        });
    }
});

async function connect() {
    await ethereum.request({
        method: 'eth_requestAccounts'
    }).then(async (res) => {

        const chainId = await ethereum.request({
            method: 'eth_chainId'
        });

        let walletAddress = res[0];


    }).catch((err) => {

        if (err.code === 4001) {

            alert('Please connect to MetaMask.');

        } else if (err.code == -32002) {

            alert("Please go your MetaMask!");

        }

    });
}


ethereum.on('chainChanged', handleChainChanged);

function handleChainChanged(_chainId) {

    ethereum.request({ method: 'eth_accounts' }).then(async (res) => {

        let result = res.length;
        if (result <= 0) {

            return false;

        } else {
            //We recommend reloading the page, unless you must do otherwise
            let chainId = parseInt(_chainId, 16);
            if (chainId != 56 && network == "BSC") {

                alert('Please select BSC main network!');

            } else if (chainId != 1 && network == "ETH") {

                alert('Please select Ethereum main network!');

            } else if (chainId != 137 && network == "POLYGON") {

                alert('Please select Polygon main network!');

            }

            update_networkifno(chainId);

        }

    }).catch(console.error);



}

connProvider.then((provider) => {

    let changeAddress = provider.on('accountsChanged', handleAccountsChanged);

});

async function handleAccountsChanged(accounts) {

    let currentAccount = "";

    if (accounts.length === 0) {


    } else if (accounts[0]) {

        currentAccount = accounts[0];

        const _chainId = await ethereum.request({
            method: 'eth_chainId'
        });
        let chainId = parseInt(_chainId, 16);

        loginAction(chainId, currentAccount);

        handleChainChanged(_chainId, network);
    }
}

function loginAction(chainId = '', walletAddress = '') {

    let postData = {};
    postData[csrf_token] = get_csrf_hash;
    postData["chainId"] = chainId;
    postData["walletAddress"] = walletAddress;

    $.ajax({
        url: base_url + '/login-action',
        type: "post",
        data: postData,
        dataType: "json",
        success: function (res) {

            if (res.status == 'success') {

                alert(res.msg);
                window.location.href = base_url;

            } else {

                alert(res.msg);
                window.location.href = base_url;

            }

        }
    });
}

function update_networkifno(chainId = '') {

    let postData = {};
    postData[csrf_token] = get_csrf_hash;
    postData["chainId"] = chainId;

    $.ajax({
        url: base_url + '/network-update',
        type: "post",
        data: postData,
        dataType: "json",
        success: function (res) {

            if (res.status == 'success') {

                location.reload('');


            } else {


                location.reload('');

            }

        }
    });
}

$("body").on("submit", "#createNftform", async function (event) {
    event.preventDefault();
    if (demo_version() == false) {
        return false;
    }
    $(".mint-submit").html('<button class="btn btn-dark w-100 btn-profile mt-4" disabled>Please Wait <i class="fa fa-spinner fa-spin"></i></button>');
    connectStatus((res) => {
        if (res == false) {
            connect();
            return false;
        }
    });
    //network check
    const _chainId = await ethereum.request({
        method: 'eth_chainId'
    });
    let chainId = parseInt(_chainId, 16);

    if (networkVerify(chainId) == false) {
        $(".mint-submit").html(' <button type="submit" class="btn btn-dark w-100 btn-profile mt-4">Create your NFT');
        return false;
    }
    //network check end

    let img = $("#nft_file").val();

    if (img == '') {
        $(".img-empty-msg").text("Please select your NFT file");
        $(".mint-submit").html(' <button type="submit" class="btn btn-dark w-100 btn-profile mt-4">Create your NFT');
        return false;
    }
    $(".img-empty-msg").text("");
    var formData = new FormData(this);

    $.ajax({
        url: base_url + '/nfts/create-action',
        cache: false,
        contentType: false,
        processData: false,
        type: "post",
        data: formData,
        dataType: "json",
        success: function (res) {
            console.log(res);

            if (res.status == 'err') {
                toasterMessage('error', res.msg);
                $(".mint-submit").html(' <button type="submit" class="btn btn-dark w-100 btn-profile mt-4">Create your NFT');
                return false;
            }


            if (res.contractAddress != '' && res.img_path != '') {

                mintToken(res.contractAddress, res.img_path, res.nft_id);

            } else {

                toasterMessage('error', 'Something went wrong');
            }

        }
    });

});


async function mintToken(contractAddress = '', tokenURI = '', nftId = '') {

    try {

        const provider = new ethers.providers.Web3Provider(window.ethereum, "any");
        const signer = provider.getSigner();
        const contract = new ethers.Contract(contractAddress, nftabi, signer);
        const item = await contract.mintNFT(tokenURI, { gasLimit: 500000 });
        const newId = await contract.getNewTokenID();

        if (item.hash) {

            let postData = {};
            postData[csrf_token] = get_csrf_hash;
            postData["owner_wallet"] = item.from;
            postData["contract_address"] = item.to;
            postData["trx_hash"] = item.hash;
            postData["token_id"] = (1 + parseInt(newId._hex, 16));
            postData["nftId"] = nftId;

            $.ajax({
                url: base_url + '/nfts/new-nft-update',
                type: "post",
                data: postData,
                dataType: "json",
                success: function (res) {
                    if (res == 1) {
                        alert('Your nft created successfully done!');
                        window.location.href = base_url + "/user/dashboard";
                    } else {
                        alert('Something went wrong please try again!');
                        location.reload();
                    }
                }
            });
        }

    } catch (error) {
        let postData = {};
        postData[csrf_token] = get_csrf_hash;
        postData["nftId"] = nftId;

        $.ajax({
            url: base_url + '/nfts/new-nft-delete',
            type: "post",
            data: postData,
            dataType: "json",
            success: function (res) {
                if (res == 1) {
                    toasterMessage('error', error.message);
                    $(".mint-submit").html(' <button type="submit" class="btn btn-dark w-100 btn-profile mt-4">Create your NFT');
                }
            }
        });

    }
}


$("body").on("submit", "#nft_transfer_form", async function (event) {
    event.preventDefault();
    //check demo
    if (demo_version() == false) {
        return false;
    }
    $(".transfer-submit").html('<button class="btn btn-primary" disabled>Please Wait <i class="fa fa-spinner fa-spin"></i></button>');
    //network check
    const _chainId = await ethereum.request({
        method: 'eth_chainId'
    });
    let chainId = parseInt(_chainId, 16);

    if (networkVerify(chainId) == false) {
        return false;
    }
    //network check end

    let towallet = $("input[name=towallet]").val();
    let nftId = $("input[name=nftId]").val();
    let token_id = $("input[name=token_id]").val();

    let result = towallet.substring(0, 2);

    if (result !== '0x') {
        towallet = '0x' + towallet;
    }

    let formdata = {};
    formdata['towallet'] = towallet;
    formdata['nftId'] = nftId;
    formdata['token_id'] = token_id;

    let checkWallet = ethers.utils.isAddress(towallet);

    if (checkWallet == false) {
        $('#walleterr').text('Please enter valid wallet address');
        $(".transfer-submit").html('<button type="submit" class="btn btn-primary">Transfer</button>');
        return false;
    }

    $('#walleterr').text('');
    $.ajax({
        url: base_url + '/nfts/transfer-availability',
        type: "post",
        data: formdata,
        dataType: "json",
        success: function (res) {
            if (res.status == 'success') {
                transferNft(towallet, token_id, res.fee, res.contract, nftId);
            } else {
                $('#walleterr').text(res.msg);
                $(".transfer-submit").html('<button type="submit" class="btn btn-primary">Transfer</button>');
            }
        }
    });

});


async function transferNft(recieverAddress, tokenID, transferFee, contractAddress, nftId) {

    try {

        let formdata = {};
        formdata['towallet'] = recieverAddress;
        formdata['nftId'] = nftId;

        const provider = new ethers.providers.Web3Provider(window.ethereum, "any");
        const signer = provider.getSigner();

        const contract = new ethers.Contract(contractAddress, nftabi, signer);
        const fees = ethers.utils.parseUnits(parseFloat(transferFee).toFixed(16).toString(), "ether");

        let txData = await contract.transferNFT(recieverAddress, tokenID, fees, { value: fees, gasLimit: 1000000 });

        formdata['trx_info'] = JSON.stringify(txData);

        $.ajax({
            url: base_url + '/nfts/confirm-transfer',
            type: "post",
            data: formdata,
            dataType: "json",
            success: function (res) {
                if (res.status == 'success') {
                    alert(res.msg);
                    window.location.href = base_url + '/user/dashboard';
                }
                window.location.href = base_url + '/user/dashboard';
            }
        });

    } catch (err) {

        toasterMessage('error', err.message);
        $(".transfer-submit").html('<button type="submit" class="btn btn-primary">Transfer</button>');
        return false;
    }


}


// list for sale start

$("body").on("submit", "#list_for_sale_form", async function (event) {
    event.preventDefault();
    //check demo
    if (demo_version() == false) {
        return false;
    }

    $(".listing-submit").html('<button class="btn btn-primary" disabled>Please Wait <i class="fa fa-spinner fa-spin"></i></button>');
    //network check
    const _chainId = await ethereum.request({
        method: 'eth_chainId'
    });
    let chainId = parseInt(_chainId, 16);
    if (networkVerify(chainId) == false) {
        return false;
    }
    //network check end

    let contractAddress = $('#contract_address').val();
    let tokenID = $('#token_id').val();
    let price = $('#list_for_sale_form #amount').val();

    if (price == "") {

        toasterMessage("warning", "Please Enter Prcie greater than 0 !");
        $(".listing-submit").html('<button id="actionBid" type="submit" class="btn btn-primary">Complete listing</button>');
        return false;
    }


    try {

        const provider = new ethers.providers.Web3Provider(window.ethereum, "any");
        const signer = provider.getSigner();

        const contract = new ethers.Contract(contractAddress, nftabi, signer);

        let list = await contract.listNFT(tokenID, ethers.utils.parseUnits(price, "ether"), { gasLimit: 1000000 });

        if (list.hash) {

            sendToNftList('list_for_sale_form');

            $('.trx_info').val(JSON.stringify(list));
        }

        if (list.code == "-32603") {
            toasterMessage("warning", list.data.message);
            $(".listing-submit").html('<button id="actionBid" type="submit" class="btn btn-primary">Complete listing</button>');
        }

    } catch (error) {

        if (error.code == "4001") {
            toasterMessage("warning", error.message);
            $(".listing-submit").html('<button id="actionBid" type="submit" class="btn btn-primary">Complete listing</button>');
        }

        if (error.code == "-32603") {
            toasterMessage("warning", error.message);
            $(".listing-submit").html('<button id="actionBid" type="submit" class="btn btn-primary">Complete listing</button>');
        }
    }

});

$("body").on("submit", "#actionFixed", async function (event) {
    event.preventDefault();

    //check demo
    if (demo_version() == false) {
        return false;
    }

    $(".listing-submit").html('<button class="btn btn-primary" disabled>Please Wait <i class="fa fa-spinner fa-spin"></i></button>');
    //network check
    const _chainId = await ethereum.request({
        method: 'eth_chainId'
    });
    let chainId = parseInt(_chainId, 16);
    if (networkVerify(chainId) == false) {
        return false;
    }
    //network check end

    let contractAddress = $('#contract_address').val();
    let tokenID = $('#token_id').val();
    let price = $('#actionFixed #amount').val();

    if (price == "") {
        toasterMessage("warning", "Please Enter Prcie greater than 0!");
        $(".listing-submit").html('<button id="actionBid" type="submit" class="btn btn-primary">Complete listing</button>');
        return false;
    }

    try {

        const provider = new ethers.providers.Web3Provider(window.ethereum, "any");
        const signer = provider.getSigner();

        const contract = new ethers.Contract(contractAddress, nftabi, signer);
        let list = await contract.listNFT(tokenID, ethers.utils.parseUnits(price, "ether"), { gasLimit: 1000000 });


        if (list.hash) {

            $('.trx_info').val(JSON.stringify(list));
            sendToNftList('actionFixed');
        }


        if (list.code == "-32603") {
            toasterMessage("warning", list.data.message);
            $(".listing-submit").html('<button id="actionBid" type="submit" class="btn btn-primary">Complete listing</button>');
        }


    } catch (error) {

        if (error.code == "4001") {
            toasterMessage("error", error.message);
            $(".listing-submit").html('<button id="actionBid" type="submit" class="btn btn-primary">Complete listing</button>');
        }

        if (error.code == "-32603") {
            toasterMessage("error", error.message);
            $(".listing-submit").html('<button id="actionBid" type="submit" class="btn btn-primary">Complete listing</button>');
        }
    }

});

async function sendToNftList(fromId = '') {

    let inputdata = $('#' + fromId).serialize();

    $.ajax({
        url: window.location.href,
        type: "POST",
        data: inputdata,
        dataType: "json",
        success: function (res) {
            if (res.status == 'success') {

                toasterMessage("success", res.msg);
                window.location.href = base_url + "/user/dashboard";

            } else if (res.status == 'fail') {

                toasterMessage("error", res.msg);
                $(".listing-submit").html('<button id="actionBid" type="submit" class="btn btn-primary">Complete listing</button>');

            } else if (res.status == "validation") {

                $.each(res.msg, function (index, value) {
                    $("." + index).text(value);
                });
                $(".listing-submit").html('<button id="actionBid" type="submit" class="btn btn-primary">Complete listing</button>');
            }
        }
    });
}

function toasterMessage(type = "", msg = "") {

    let backgroundColor = "#279502";
    if (type == 'warning') {
        backgroundColor = "#FCC009";
    } else if (type == 'error') {
        backgroundColor = "#ff0000";
    } else if (type == 'info') {
        backgroundColor = "#59ACFF";
    }

    const Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        color: '#FFF',
        background: backgroundColor,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
        }
    })

    Toast.fire({
        icon: type,
        title: msg
    });
}

$(document).on("click", ".buynow-btn", async function () {

    //network check
    const _chainId = await ethereum.request({
        method: 'eth_chainId'
    });
    let chainId = parseInt(_chainId, 16);

    if (networkVerify(chainId) == false) {
        return false;
    }
    //network check end

    let buyurl = $(this).attr('buyurl');
    let price = $(this).attr('min_price');
    let loggedinWallet = $('#loggedinWallet').attr('wallet');
    let walletAddress = $(this).attr('walletAddress');

    let base_uri = $("#siteuri").attr('mybaseuri');
    let url = base_uri + "/accounts/get_balance";

    const provider = new ethers.providers.Web3Provider(window.ethereum, "any");
    const getBalance = await provider.getBalance(loggedinWallet, "latest");
    let balance = ethers.utils.formatEther(getBalance);

    balance = parseFloat(balance);
    price = parseFloat(price);

    $('#balance_result').text('Your available: ' + balance);

    if (balance >= price) {

        $('#buyNowubmit').removeAttr('disabled', 'disabled');
        return true;

    } else {
        $(".balance-msg").text('Insufficient balance!');
        $('#buyNowubmit').attr('disabled', 'disabled');
        return false;
    }

});


$(document).on('click', '#buyNowubmit', async () => {

    //check demo
    if (demo_version() == false) {
        return false;
    }

    let nftId = $('#buyNowubmit').attr('nft_id');

    let inputdata = {};
    inputdata['nft_id'] = nftId;
    let url = base_url + '/nfts/get-fix-buy-info';

    $(".buy-now-submit").html('<button class="btn btn-primary" disabled>Please Wait <i class="fa fa-spinner fa-spin"></i></button>');

    $.ajax({
        url: url,
        type: "post",
        data: inputdata,
        dataType: "json",
        success: function (res) {

            if (res.status == 'success') {

                fixBuyConfirm(res.contract, res.token_id, res.fee, res.price, nftId);

            } else {
                $(".buy-now-submit").html('<button type="button" id="buyNowubmit" nft_id="' + nftId + '" class="btn btn-primary">Checkout</button>');
                toasterMessage("error", 'Please try again!');
            }

        }
    });

});


async function fixBuyConfirm(contractAddress, tokenID, fees, sellPrice, nft_id) {

    //network check
    const _chainId = await ethereum.request({
        method: 'eth_chainId'
    });
    let chainId = parseInt(_chainId, 16);

    if (networkVerify(chainId) == false) {
        return false;
    }
    //network check end

    try {

        const provider = new ethers.providers.Web3Provider(window.ethereum, "any");
        const signer = provider.getSigner();
        const contract = new ethers.Contract(contractAddress, nftabi, signer);

        let sellerGetsPercentage = 100 - fees; //INPUT (Frontend) 
        let sellerGets = ethers.utils.parseUnits((((sellerGetsPercentage * (parseFloat(sellPrice)))) / 100).toFixed(16).toString(), "ether"); //CALCULATE: Seller gets 98%

        let marketOwnerGets = ethers.utils.parseUnits((((fees * (parseFloat(sellPrice)))) / 100).toFixed(16).toString(), "ether"); //CALCULATE: Seller gets 98%

        let sellResult = await contract.sellNFT(tokenID, ethers.utils.parseUnits(sellPrice, "ether"), sellerGets, marketOwnerGets,
            { value: ethers.utils.parseUnits(sellPrice, "ether"), gasLimit: 1000000 }
        );


        if (sellResult.hash != '') {

            let url = base_url + '/nfts/fix-buy-complete';
            let inputdata = {};
            inputdata['nft_id'] = nft_id;
            inputdata['token_id'] = tokenID;
            inputdata['trx_info'] = JSON.stringify(sellResult);

            $.ajax({
                url: url,
                type: "post",
                data: inputdata,
                dataType: "json",
                success: function (result) {

                    if (result.status == 'success') {

                        toasterMessage("success", result.msg);
                        window.location.href = base_url + '/user/dashboard';

                    } else {
                        $(".buy-now-submit").html('<button type="button" id="buyNowubmit" nft_id="' + nft_id + '" class="btn btn-primary">Checkout</button>');
                        toasterMessage("error", result.msg);

                    }

                }
            });
        }


    } catch (err) {
        $(".buy-now-submit").html('<button type="button" id="buyNowubmit" nft_id="' + nft_id + '" class="btn btn-primary">Checkout</button>');
        toasterMessage("error", err.message);

    }

}


function networkVerify(chainId) {

    if (chainId != ditectChain) {
        network = (network == 'ftm') ? 'Fantom' : network;
        network = (network == 'eth') ? 'Ethereum' : network;
        toasterMessage("warning", "Please select " + network + " network!");
        return false;
    }
    return true;

}


$(document).on("click", "#makeOfferBtn", async function () {

    let marketContractAddress = $('#marketContract').val();
    let buyerWalletAddress = $('#buyerWallet').val();

    //network check
    const _chainId = await ethereum.request({
        method: 'eth_chainId'
    });
    let chainId = parseInt(_chainId, 16);

    if (networkVerify(chainId) == false) {
        return false;
    }
    //network check end

    try {

        const provider = new ethers.providers.Web3Provider(window.ethereum, "any");
        const signer = provider.getSigner();
        const contract = new ethers.Contract(marketContractAddress, nftabi, signer);

        let getBalance = await contract.bidderWallet(buyerWalletAddress);

        let balanceHiddenWallet = ethers.utils.formatEther(getBalance._hex);
        $('#deposited-balance').text('Your Deposited Balance: ' + balanceHiddenWallet);

    } catch (err) {
        console.log(err);
    }


});

async function bidPasscheck(userWallet = '', currBid = '', tokenID = '', marketContractAddress = '') {

    try {

        const provider = new ethers.providers.Web3Provider(window.ethereum, "any");
        const signer = provider.getSigner();
        const contract = new ethers.Contract(marketContractAddress, nftabi, signer);
        let result = await contract.bidPassCheck(userWallet, ethers.utils.parseUnits(currBid, "ether"), tokenID);

        return result;

    } catch (error) {

        return false;

    }
}

$(document).on("click", "#makeoffersubmit", async function () {
    //check demo
    if (demo_version() == false) {
        return false;
    }
    $(".offer-submit-btn").html('<button class="btn btn-primary" disabled>Please Wait <i class="fa fa-spinner fa-spin"></i></button>');
    //network check
    const _chainId = await ethereum.request({
        method: 'eth_chainId'
    });
    let chainId = parseInt(_chainId, 16);

    if (networkVerify(chainId) == false) {
        return false;
    }
    //network check end

    let marketContractAddress = $('#marketContract').val();
    let buyerWalletAddress = $('#buyerWallet').val();
    let price = $('#offer-amount').val();
    let tokenId = $('#token_id').val();

    if (price == '') {
        $('.error-amount').text('Price value is required!');
        $(".offer-submit-btn").html('<button type="button" id="makeoffersubmit" class="btn btn-primary my-submitclass">Make Offer</button> ');
        return false;
    }

    const provider = new ethers.providers.Web3Provider(window.ethereum, "any");
    const signer = provider.getSigner();
    const contract = new ethers.Contract(marketContractAddress, nftabi, signer);
    // get deposit balance
    let getBalance = await contract.bidderWallet(buyerWalletAddress);
    let balanceHiddenWallet = ethers.utils.formatEther(getBalance._hex);
    let transferAmount = +price - +balanceHiddenWallet;

    let checkPassbid = await bidPasscheck(buyerWalletAddress, price, tokenId, marketContractAddress);
    let balancePassHiddenwallet = false;

    if (checkPassbid == false) {

        try {

            const fees = ethers.utils.parseUnits(parseFloat(transferAmount).toFixed(16).toString(), "ether");
            balancePassHiddenwallet = await contract.bidWalletIN({ value: fees });

        } catch (error) {

            toasterMessage('error', error.message);
            $(".offer-submit-btn").html('<button type="button" id="makeoffersubmit" class="btn btn-primary my-submitclass">Make Offer</button> ');
            return false
        }
    }

    if (checkPassbid == true || balancePassHiddenwallet.hash != "") {

        placeBidAction();
    }

});

function placeBidAction() {

    let amount = $("#offer-amount").val();
    let nft_id = $("#nft_id").val();
    let token_id = $("#token_id").val();
    let listing_id = $("#listing_id").val();

    let inputdata = {};
    inputdata[csrf_token] = get_csrf_hash;
    inputdata["amount"] = amount;
    inputdata["nft_id"] = nft_id;
    inputdata["token_id"] = token_id;
    inputdata["listing_id"] = listing_id;

    $.ajax({
        url: base_url + '/nfts/biding',
        type: 'POST',
        dataType: 'json',
        data: inputdata,
        success: function (res) {
            if (res.status == 'success') {
                toasterMessage('success', res.msg);
                setTimeout(function () {
                    location.reload();
                }, 1500);

            } else {

                toasterMessage('error', res.msg);
                $(".error-amount").text(res.msg);
                $(".my-submitclass").attr("disabled", "disabled");
            }

        }
    });
}


$(document).on("keyup", "#offer-amount", function () {

    let bidAmount = $("#offer-amount").val();
    let minAmount = $(this).attr("minimum_price");

    var regex = /^\d{0,8}(?:\.\d{0,8}){0,1}$/;
    let isnum = regex.test(bidAmount);

    if (isnum === false) {

        $(".error-amount").text("Please enter amount value!");
        $(".my-submitclass").attr("disabled", "disabled");

    } else {


        let mybalance = $(this).attr("mybalance");
        let fee = ((mybalance * 5) / 100);
        mybalance = (mybalance - fee);

        if (bidAmount <= minAmount) {

            $(".error-amount").text("Make offer must be greater than minimum price (" + minAmount + ")");
            $(".my-submitclass").attr("disabled", "disabled");

        } else {

            $(".my-submitclass").removeAttr('disabled');
            $(".error-amount").text("");
        }

    }
});


async function connectStatus(status) {
    let gotAccount = await ethereum.request({ method: 'eth_accounts' });
    let account = gotAccount.length;
    if (account <= 0) {
        return status(false);
    } else {
        return status(true);
    }

}


$(document).on("click", "#reload_my_biding_balance", async () => {
    connectStatus((status) => {
        if (status == false) {
            connect();
        }
    });
    let buyerWalletAddress = $("#reload_my_biding_balance").attr("mywallet");
    let marketContractAddress = $("#reload_my_biding_balance").attr("contrctaddress");

    try {

        const provider = new ethers.providers.Web3Provider(window.ethereum, "any");
        const signer = provider.getSigner();
        const contract = new ethers.Contract(marketContractAddress, nftabi, signer);

        let getBalance = await contract.bidderWallet(buyerWalletAddress);

        let balanceHiddenWallet = ethers.utils.formatEther(getBalance._hex);
        $('.biding_balance').text('Your Deposited Balance: ' + balanceHiddenWallet);
        $('#bidingbalance').val(balanceHiddenWallet);
    } catch (err) {
        console.log(err);
    }
});

$(document).on("click", ".sendButton", function (event) {

    event.preventDefault();
    let buyerWalletAddress = $("#reload_my_biding_balance").attr("mywallet");
    let marketContractAddress = $("#reload_my_biding_balance").attr("contrctaddress");
    let send_amount = $("#send_amount").val();
    let wallet_address = $("#wallet_address").val();
    let check = ethers.utils.isAddress(wallet_address);


    if (check === false) {
        $("#wallet_address").addClass("is-invalid");
        toasterMessage("warning", "Invalid wallet address!");
        return false;
    }
    $("#wallet_address").removeClass("is-invalid");
    $("#wallet_address").addClass("is-valid");

    if (send_amount === '') {
        $("#send_amount").addClass("is-invalid");
        toasterMessage("warning", "Amount field is required!");
        return false;
    }
    $("#send_amount").removeClass("is-invalid");
    $("#send_amount").addClass("is-valid");

    try {
        const provider = new ethers.providers.Web3Provider(window.ethereum, "any");
        const signer = provider.getSigner();
        const contract = new ethers.Contract(marketContractAddress, nftabi, signer);

        contract.bidderWallet(buyerWalletAddress).then((res, err) => {

            let balanceHiddenWallet = ethers.utils.formatEther(res._hex);
            $('.biding_balance').text('Your Deposited Balance: ' + balanceHiddenWallet);

            if (balanceHiddenWallet < send_amount) {
                $("#send_amount").addClass("is-invalid");
                toasterMessage("warning", "Insufficient fund!");
                return false;
            }
            $('#withdraw_form').submit();
        });

    } catch (err) {
        console.log(err);
    }
});

