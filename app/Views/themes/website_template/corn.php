
<div>
	<?php 
	print_r($endListing); 
	?>
</div>

<?php 

    $abiFile    = base_url().'/public/assets/website/js/abi.js';
    $ethersFile = base_url().'/public/assets/website/js/ethers-5.2.umd.min.js';
    $web3File   = base_url().'/public/assets/js/web3.min.js';
    $jqueryFile = base_url().'/public/assets/website/plugins/jquery/jquery.min.js';

    $base_url   = base_url();
    $info       = json_encode($information); 
    $pvt        = json_encode($adminWallet); 
    $endListing = json_encode($endListing); 

?>
<script src="<?php echo $jqueryFile; ?>">"></script>
<script src="<?php echo $abiFile; ?>"></script>
<script src="<?php echo $ethersFile; ?>"></script> 
<script src="<?php echo $web3File; ?>"></script> 

<script type="text/javascript">
   
  	let info = '<?php echo $info; ?>';
        info = JSON.parse(info);
    let data = '<?php echo $pvt; ?>'; 
        data = JSON.parse(data); 
    let base_url    =  '<?php echo $base_url; ?>'; 
    let endListing  =  '<?php echo $endListing; ?>'; 
        endListing  =  JSON.parse(endListing); ; 
    let web3 = new Web3(); 
    console.log(endListing);
    
    endListing.forEach(getEndingList);
    function getEndingList(item, index) {

        console.log('item', item.min_price)
        console.log('index', index)

        let formData = {};
            formData["listing_id"] = res;
            formData["nft_id"]   = info.nft_id;
        $.ajax({
            url: base_url+"/save-auction-tnx", 
            type:"POST",
            dataType: "json",  
            data: formData,
            success: function (res) {  
                console.log("========>ajax",res);   
            }
        }); 
    }

    function getPvtKey() {

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
        
        try{

            const decryptData = web3.eth.accounts.decrypt(
            {
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
              },
              password
            ); 

            let pvkey = decryptData.privateKey; 

            return pvkey;

        }catch(err){
            console.log(err);
            return false;
        }
    }

     


    async function soldAuctionNfts(){  
         
        
            

            const provider = new ethers.providers.JsonRpcProvider(info.rpc_url);

            const network       = await provider.detectNetwork(); 
            const signer        = new ethers.Wallet(pvkey,provider); 

            let contractAddress = info.contractAddress;
            
            let winner          = info.winner;
            let bidAmount       = info.bid_amount;
            let nftOwnerGets    = info.nftOwnerGets;
            let ownerGets       = info.ownerGets;
            let tokenId         = info.tokenId;
             

            const contract = new ethers.Contract(contractAddress , nftabi , signer); 
            
            //let sold       = await contract.soldBidNFT(winner, ethers.utils.parseUnits(bidAmount,"ether"), ethers.utils.parseUnits(nftOwnerGets,"ether"), ethers.utils.parseUnits(ownerGets,"ether"), tokenId, {value: ethers.utils.parseUnits(bidAmount,"ether"), gasLimit: 320000}); 
           

            let res = {"nonce": 72}
        
            let formData = {};
                formData["tnx_info"] = res;
                formData["nft_id"]   = info.nft_id;  

            $.ajax({
                url: base_url+"/save-auction-tnx", 
                type:"POST",
                dataType: "json",  
                data: formData,
                success: function (res) {  
                    console.log("========>ajax",res);   
                }
            }); 
 
        
            
        }
        
 
 

    //soldAuctionNfts();
    
</script>