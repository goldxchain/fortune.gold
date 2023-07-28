(function ($) {
    "use strict";
    var base_url = $("#base_url").val();

    function getinfo(callback){ 
        
        $.ajax({
            url: base_url + "/backend/nft/getAdminWallet", 
            type: "GET",  
            success: (res) =>{ 
                 
                res = JSON.parse(res);

                if(res.status == 'success'){
                    let data = res.data; 
                    let version = data.version;
                    let id = data.id;
                    let address = data.wallet_address;
                    let ciphertext = data.ciphertext;
                    let iv = data.iv; 
                    let dklen = data.dklen;
                    let salt = data.salt;
                    let mac = data.mac; 
                    let cipher = data.cipher; 
                    let kdf = data.kdf;  
                    let password = data.encrypt_val;  
                    let info = {
                        version: +version,
                        id,
                        address,
                        crypto: {
                          ciphertext,
                          cipherparams: { iv },
                          cipher,
                          kdf,
                          kdfparams: {
                            dklen: +dklen,
                            salt,
                            n: +data.n,
                            r: +data.r,
                            p: +data.p,
                          },
                          mac,
                        },
                    }; 
                    callback({info, password});
                }
            } 
        });  
    }
    
    $(".approve_trnscation").on("click", function(){
        
        let web3 = new Web3(); // connect web3
        let to_wallet             = $(this).attr("to_wallet");
        let send_amount           = $(this).attr("send_amount"); 
        let transaction_id        = $(this).attr("transaction_id"); 
        let marketContractAddress = $("#market_contract").val();
        let network_rpc           = $("#network_rpc").val();

        $('.trnscation_btn_'+transaction_id).html('<button class="btn btn-warning" disabled>Please Wait <i class="fa fa-spinner fa-spin"></i></button>');

        getinfo( async (res)=>{
            const decryptData = web3.eth.accounts.decrypt(res.info, res.password);
            try { 
               
                const provider  = new ethers.providers.JsonRpcProvider(network_rpc);
                const signer    = new ethers.Wallet(decryptData.privateKey, provider);  
                const contract  = new ethers.Contract(marketContractAddress, nftabi, signer); 
                send_amount     = parseFloat(send_amount).toString(); 
               
                contract.bidWalletOUT(to_wallet, ethers.utils.parseUnits(send_amount, "ether"), {value: ethers.utils.parseUnits(send_amount, "ether"), gasLimit: 3200000}).then((result, err)=>{ 

                    let postdata = {};
                        postdata['transaction_id'] = transaction_id;
                        postdata['trx'] = JSON.stringify(result);
                    $.ajax({
                        url: base_url+'/backend/customers/transcation-omplete/',
                        type: 'POST',
                        dataType: 'JSON',
                        data: postdata,
                        success: function (res) { 
                            console.log("res", res);
                             if(res.status == 'success'){ 
                                console.log("success", res); 
                                $('.trnscation_btn_'+transaction_id).html('<button type="button" class="btn btn-success btn-sm"><i class="fa fa-check-double"></i>Approved</button>');
                                sweetAlert('success', 'Success'); 
                             }else{   
                                sweetAlert('warning', 'please try again'); 
                             } 
                        },
                    
                    });
                });   

            } catch (error) {
                //console-log
            } 
            
        }); 
       
    });


}(jQuery));


     