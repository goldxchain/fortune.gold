
(function ($) {

    "use strict";

    var base_url = $("#base_url").val();

    if ($('#ajaxusertableform_nft').length) {
        var table;
        let listing_type = $("#listing_type").val();
        let urls = '';
        if (listing_type != '') {
            urls = '?type=' + listing_type;
        }

        table = $('#ajaxtable_nft').DataTable({

            // "responsive": true,
            "lengthChange": true,
            "processing": true, //Feature control the processing indicator.
            "serverSide": true, //Feature control DataTables' server-side processing mode.
            "order": [],
            "pageLength": 10,
            "lengthMenu": [
                [10, 25, 50, 100, -1],
                [10, 25, 50, 100, "All"]
            ],

            "paging": true,
            "searching": true,
            dom: "<'row'<'col-sm-3'l><'col-sm-3'B><'col-sm-3'f>>tp",
            dom: 'Bflrtip',
            "buttons": [
                {
                    extend: 'copy',
                    text: '<i class="far fa-copy"></i>',
                    titleAttr: 'Copy',
                    className: 'btn-success'
                },
                {
                    extend: 'csv',
                    text: '<i class="fas fa-file-csv"></i>',
                    titleAttr: 'CSV',
                    className: 'btn-success'
                },
                {
                    extend: 'excel',
                    text: '<i class="far fa-file-excel"></i>',
                    titleAttr: 'Excel',
                    className: 'btn-success'
                },
                {
                    extend: 'pdf',
                    text: '<i class="far fa-file-pdf"></i>',
                    titleAttr: 'PDF',
                    className: 'btn-success'
                },
                {
                    extend: 'print',
                    text: '<i class="fa fa-print" aria-hidden="true"></i>',
                    titleAttr: 'Print',
                    className: 'btn-success'
                }
            ],
            // Load data for the table's content from an Ajax source
            "ajax": {
                "url": base_url + '/backend/nft/ajax_list' + urls,
                "type": "POST",
                "data": { csrf_token: get_csrf_hash },
            },


            "columnDefs": [
                {
                    "targets": [0], //first column / numbering column
                    "orderable": false, //set not orderable
                },
            ],
            "fnInitComplete": function (oSettings, response) {
            }

        });

        $.fn.dataTable.ext.errMode = 'none';
    }

    if ($('#ajaxusercompletedform_nft').length) {
        var table;

        table = $('#ajaxtable_completed').DataTable({

            // "responsive": true,
            "lengthChange": true,
            "processing": true, //Feature control the processing indicator.
            "serverSide": true, //Feature control DataTables' server-side processing mode.
            "order": [],
            "pageLength": 10,
            "lengthMenu": [
                [10, 25, 50, 100, -1],
                [10, 25, 50, 100, "All"]
            ],

            "paging": true,
            "searching": true,
            dom: "<'row'<'col-sm-3'l><'col-sm-3'B><'col-sm-3'f>>tp",
            dom: 'Bflrtip',
            "buttons": [
                {
                    extend: 'copy',
                    text: '<i class="far fa-copy"></i>',
                    titleAttr: 'Copy',
                    className: 'btn-success'
                },
                {
                    extend: 'csv',
                    text: '<i class="fas fa-file-csv"></i>',
                    titleAttr: 'CSV',
                    className: 'btn-success'
                },
                {
                    extend: 'excel',
                    text: '<i class="far fa-file-excel"></i>',
                    titleAttr: 'Excel',
                    className: 'btn-success'
                },
                {
                    extend: 'pdf',
                    text: '<i class="far fa-file-pdf"></i>',
                    titleAttr: 'PDF',
                    className: 'btn-success'
                },
                {
                    extend: 'print',
                    text: '<i class="fa fa-print" aria-hidden="true"></i>',
                    titleAttr: 'Print',
                    className: 'btn-success'
                }
            ],
            // Load data for the table's content from an Ajax source
            "ajax": {
                "url": base_url + '/backend/nft/ajax_auction_completed',
                "type": "POST",
                "data": { csrf_token: get_csrf_hash },
            },


            "columnDefs": [
                {
                    "targets": [0], //first column / numbering column
                    "orderable": false, //set not orderable
                },
            ],
            "fnInitComplete": function (oSettings, response) {
            }

        });

        $.fn.dataTable.ext.errMode = 'none';
    }




    $(document).on("change", "#is_featured", function () {

        let value = $('#is_featured').val();
        if ($('#is_featured').is(":checked")) {

            var url = base_url + "/backend/nft/is_featured/" + value + "/check";
            $.ajax({
                url: url,
                type: 'GET',
                success: function (res) {
                    var result = JSON.parse(res);
                    if (result.status == true) {
                        sweetAlert('success', result.msg);
                    }
                }
            });
        } else {

            var url = base_url + "/backend/nft/is_featured" + value + "/uncheck";

            $.ajax({
                url: url,
                type: 'GET',
                success: function (res) {
                    var result = JSON.parse(res)

                    if (result.status == true) {
                        sweetAlert('success', result.msg);
                    }
                }
            });
        }


    });


    $(document).on("click", "#detail_change_status", function () {

        let val = $(this).attr("infostatus");
        let id = $(this).attr("infoid");

        let optionData = "";
        let bodyData = [];
        bodyData[0] = "Pending";
        bodyData[1] = "Active";
        bodyData[2] = "Suspend";

        for (let i = 0; i <= 2; i++) {
            optionData += "<option value='" + i + "' " + (i == val ? 'selected' : 'null') + ">" + (bodyData[i]) + "</option>";
        }


        $('.nftHtmlData_' + id).html("");
        $('.nftHtmlData_' + id).html('<select id="change_val" valid="' + id + '" class"form-control">' + optionData + '</select>');
    });


    $(document).on("change", "#change_val", function () {

        let id = $(this).attr("valid");
        var value = $("#change_val").val();
        if (value == 2) {
            $(".suspend-msg-input").removeClass('d-none');
        } else {
            $(".suspend-msg-input").css('display', 'none');
        }


        if (value != 2) {

            var url = base_url + "/backend/nft/changestatus/" + id + "/" + value;
            $.ajax({
                url: url,
                type: 'GET',
                data: { csrf_token: get_csrf_hash },
                success: function (res) {
                    var result = JSON.parse(res)

                    if (result.status === 'success') {
                        if (value == 1) {
                            $('.nftHtmlData_' + id).html('<span id="detail_change_status" infoid="' + id + '" infostatus="' + value + '"class="btn btn-success btn-md ">Active <i class="fas fa-angle-down" ></i> </span>');
                            sweetAlert('success', 'Activate');
                        } else if (value == 0) {
                            $('.nftHtmlData_' + id).html('<span id="detail_change_status" infoid="' + id + '" infostatus="' + value + '" class="btn btn-warning btn-md ">Pending <i class="fas fa-angle-down" ></i></span>');
                            sweetAlert('warning', 'Deactivate');
                        }

                    }
                }
            });
        }

    });


    function readProfile(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#profile_tag').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
    function readBanner(input) {

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#banner_tag').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
    $("#profile_img").change(function () {

        readProfile(this);
    });
    $("#banner_img").change(function () {

        readBanner(this);
    });


    function readProfile(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#profile_tag').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
    $("#profile_img").change(function () {

        readProfile(this);
    });
    $("#banner_img").change(function () {

        readBanner(this);
    });


    $("#contract_form").on("submit", (event) => {
        event.preventDefault();

        var inputval = $("#contract_form").serialize();
        let contractName = $("input[name=contract_name]").val();
        let contractSymbol = $("input[name=contract_symbol]").val();
        let gotMaxTokenSupply = $("input[name=max_supply]").val();
        let rpc_url = $("input[name=rpc_url]").val();

        let formdata = {};
        formdata['contractName'] = contractName;
        formdata['contractSymbol'] = contractSymbol;
        formdata['gotMaxTokenSupply'] = gotMaxTokenSupply;


        let web3 = new Web3();

        $(".deployedmsg").text('Please wait for smart contract to deploy. (Estimated time: 1-2 minutes)');
        $(".aftersubmit").html('<button class="btn btn-success" disabled><i class="fa fa-spinner fa-spin"></i></button>');

        $.ajax({
            url: base_url + "/backend/nft/getAdminWallet",
            type: "POST",
            data: inputval,
            dataType: "json",
            success: async (res) => {
                if (res.status == 'success') {

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

                    let privateKey = decryptData.privateKey;

                    if (privateKey != '') {

                        try {
                            const provider = new ethers.providers.JsonRpcProvider(rpc_url);
                            const network = await provider.detectNetwork();
                            const signer = new ethers.Wallet(privateKey, provider);
                            const factory = new ethers.ContractFactory(nftabi, bytecode, signer);

                            const contract = await factory.deploy(contractName, contractSymbol, gotMaxTokenSupply);

                            formdata['contract_address'] = contract.address;
                            formdata['tnx_hash'] = contract.deployTransaction.hash;

                            $.ajax({
                                url: base_url + "/backend/nft/nft_setup_ajax",
                                type: "POST",
                                data: formdata,
                                dataType: "json",
                                success: function (res) {

                                    if (res.status === 'success') {

                                        setTimeout(async () => {

                                            const contract2 = new ethers.Contract(contract.address, nftabi, signer);
                                            const setContract = await contract2.marketSetup(contract.address);

                                            $(".aftersubmit").html('<button type="submit" class="btn btn-success">Deploy</button>');
                                            location.reload();


                                        }, 60000);


                                    } else {
                                        $('#contract_form').trigger("reset");
                                        $(".aftersubmit").html('<button type="submit" class="btn btn-success">Deploy</button>');

                                        $('.msg').html('<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>' + res.message + '</div>');
                                    }

                                }

                            });

                        } catch (err) {
                            console.log(err);
                            $(".aftersubmit").html('<button type="submit" class="btn btn-success">Deploy</button>');
                            sweetAlert('error', err.message);
                        };
                    }

                }


                return false;
            }

        });


    });


    $("#wallet_import_form").on('submit', (event) => {

        event.preventDefault();
        let fromVal = $("#wallet_import_form").serialize();
        let private_key = $("input[name=private_key]").val();
        if (private_key.length !== 64) {
            sweetAlert('warning', 'Worng! Please enter your 64 characters private key');
            return false;
        }
        let web3 = new Web3();
        let password = "Bdtask@123";
        try {
            // Encrypt admin private key
            let encryptinfo = web3.eth.accounts.encrypt(private_key, password);

            let inputdata = {};
            inputdata[csrf_token] = get_csrf_hash;
            inputdata['version'] = encryptinfo.version;
            inputdata['id'] = encryptinfo.id;
            inputdata['wallet_address'] = encryptinfo.address;
            inputdata['ciphertext'] = encryptinfo.crypto.ciphertext;
            inputdata['iv'] = encryptinfo.crypto.cipherparams.iv;
            inputdata['cipher'] = encryptinfo.crypto.cipher;
            inputdata['kdf'] = encryptinfo.crypto.kdf;
            inputdata['dklen'] = encryptinfo.crypto.kdfparams.dklen;
            inputdata['salt'] = encryptinfo.crypto.kdfparams.salt;
            inputdata['n'] = encryptinfo.crypto.kdfparams.n;
            inputdata['r'] = encryptinfo.crypto.kdfparams.r;
            inputdata['p'] = encryptinfo.crypto.kdfparams.p;
            inputdata['mac'] = encryptinfo.crypto.mac;
            inputdata['encrypt_val'] = password;
            inputdata['balance'] = 0;

            $.ajax({
                url: base_url + '/backend/nft/wallet_setup',
                type: 'POST',
                dataType: 'JSON',
                data: inputdata,
                success: function (data) {

                    if (data.status == 'success') {
                        sweetAlert('success', data.msg);
                        setTimeout(() => {
                            window.location.href = base_url + '/backend/nft/nft_setup';
                        }, 3000);

                    } else {
                        sweetAlert('warning', data.msg);
                        setTimeout(() => {
                            window.location.href = base_url + '/backend/nft/nft_setup';
                        }, 3000);
                    }

                },

            });

        } catch (err) {
            sweetAlert('warning', 'Worng private key!');
        }

    });

    $(document).on("change", ".network-information", () => {
        let id = $(".network-information").val();
        let postdata = {};
        postdata['id'] = id;
        $.ajax({
            url: base_url + '/backend/nft/get-net-info/',
            type: 'POST',
            dataType: 'JSON',
            data: postdata,
            success: function (res) {
                if (res.status == 'success') {
                    let info = res.data;
                    $('input[name = chain_id]').val(info.chain_id);
                    $('input[name = currency_symbol]').val(info.currency_symbol);
                    $('input[name = rpc_url]').val(info.rpc_url);
                    $('input[name = explorer_url]').val(info.explore_url);
                    $('input[name = port]').val(info.port);
                    $('input[name = server_ip]').val(info.server_ip);
                } else {
                    sweetAlert('warning', 'Data not found!');
                }

            },

        });
    });

    function getinfo(callback) {

        $.ajax({
            url: base_url + "/backend/nft/getAdminWallet",
            type: "GET",
            success: (res) => {

                res = JSON.parse(res);

                if (res.status == 'success') {
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
                    callback({ info, password });
                } else {
                    sweetAlert('error', 'Admin wallet not found!');
                    return false;
                }
            }

        });
    }



    $(document).on("click", "#complete_today_auction", () => {

        let web3 = new Web3();

        getinfo((res) => {
            $(".complete-auction-btn").html('<button class="btn btn-lg btn-success mb-2" disabled>Please Wait <i class="fa fa-spinner fa-spin"></i></button>');
            const decryptData = web3.eth.accounts.decrypt(res.info, res.password);
            let url = base_url + '/backend/nft/today-completed-auction';

            $.ajax({
                url: url,
                type: 'GET',
                success: (res) => {
                    let result = JSON.parse(res);
                    if (result.maindata.length == 0 || result.data.length == 0) {
                        sweetAlert('warning', 'Data not found!');
                        $(".complete-auction-btn").html('<button type="button" class="btn btn-lg btn-warning mb-2" id="complete_today_auction">Complete auction</button>');
                        return false;
                    }

                    let rpc_url = result.maindata.rpc_url;
                    let contractAddress = result.maindata.contractAddress;

                    const provider = new ethers.providers.JsonRpcProvider(rpc_url);
                    const signer = new ethers.Wallet(decryptData.privateKey, provider);
                    const contract = new ethers.Contract(contractAddress, nftabi, signer);

                    let arrLength = result.data.length;
                    let LoopEnd = (arrLength - 1);
                    $.each(result.data, function (index, value) {

                        $(".complete-auction-btn").html('<button class="btn btn-lg btn-success mb-2" disabled>Please Wait <i class="fa fa-spinner fa-spin"></i></button>');
                        setTimeout(async () => {
                            $(".complete-auction-btn").html('<button class="btn btn-lg btn-success mb-2" disabled>Please Wait <i class="fa fa-spinner fa-spin"></i></button>');
                            if (value.option == 'sell') {
                                try {

                                    let sellPrice = value.sellPrice;
                                    let fees = value.fees;
                                    let tokenID = value.tokenID;
                                    let winner = value.winner;

                                    let sellerGetsPercentage = 100 - fees; //INPUT (Frontend)

                                    let sellerGets = ethers.utils.parseUnits((((sellerGetsPercentage * (parseFloat(sellPrice)))) / 100).toFixed(16).toString(), "ether"); //CALCULATE: Seller gets %
                                    let marketOwnerGets = ethers.utils.parseUnits((((fees * (parseFloat(sellPrice)))) / 100).toFixed(16).toString(), "ether"); //CALCULATE: Seller gets %

                                    //sold NFT from seller to buyer
                                    contract.soldBidNFT(winner, ethers.utils.parseUnits(sellPrice, "ether"), sellerGets, marketOwnerGets, tokenID, { value: ethers.utils.parseUnits(sellPrice, "ether"), gasLimit: 320000 })
                                        .then((result, err) => {

                                            let postdata = {};
                                            postdata['listId'] = value.listing_id;
                                            postdata['type'] = value.option;
                                            postdata['winner_id'] = value.winner_id;
                                            postdata['winner_wallet'] = winner;
                                            postdata['bid_id'] = value.bid_id;
                                            postdata['amount'] = sellPrice;
                                            postdata['fees'] = fees;
                                            postdata['blockchain_info'] = JSON.stringify(result);

                                            let urll = base_url + '/backend/nft/confirm-auctions/';
                                            $.ajax({
                                                url: urll,
                                                type: 'POST',
                                                dataType: 'JSON',
                                                data: postdata,
                                                success: function (res) {
                                                    if (res.status == 'success') {
                                                        $(".complete-auction-btn").html('<button type="button" class="btn btn-lg btn-success mb-2" id="complete_today_auction">Complete auction</button>');
                                                        if (LoopEnd == index) {
                                                            location.reload();
                                                        }
                                                    }
                                                }
                                            });
                                        });

                                } catch (err) {
                                    // console err here
                                }

                            }
                            else if (value.option == 'unlist') {

                                try {

                                    let tokenID = value.tokenID;
                                    contract.unlistNFT(tokenID, { gasLimit: 320000 }).then((result, err) => {

                                        let postdata = {};
                                        postdata['listId'] = value.listing_id;
                                        postdata['type'] = value.option;
                                        postdata['blockchain_info'] = JSON.stringify(result);

                                        let urll = base_url + '/backend/nft/confirm-auctions/';
                                        $.ajax({
                                            url: urll,
                                            type: 'POST',
                                            dataType: 'JSON',
                                            data: postdata,
                                            success: function (res) {
                                                if (res.status == 'success') {

                                                    $(".complete-auction-btn").html('<button type="button" class="btn btn-lg btn-success mb-2" id="complete_today_auction">Complete auction</button>');
                                                    if (LoopEnd == index) {
                                                        location.reload();
                                                    }
                                                }
                                            }
                                        });
                                    });

                                } catch (err) {
                                    // console err here
                                }

                            }


                        }, index * 5000);


                    });


                }
            });
        });
    });



    $(document).on("click", "#submit_purchase", function () {
        let purchase_key = $("#purchase_key").val();

        $("#purchase_key").removeClass('is-invalid');
        $.ajax({
            url: base_url + '/backend/nft/get-purchase-info',
            type: 'POST',
            dataType: 'JSON',
            data: {
                purchase_key
            },
            success: function (res) {

                if (res.status === 200) {
                    sweetAlert('success', res.message);
                    $("#purchase_key_check").html('');
                    $('#purchase_key_check_show').html(`<span class="fs-17 font-weight-600 mb-0 alert alert-success"> Purchase Key Verified &nbsp; <i class="fa fa-check-circle  fa-lg text-success" aria-hidden="true"></i></span>`);
                    $("#contact_setup_network").html(res.view);
                }
                else if (res.status === 422) {
                    sweetAlert('error', "Validation Error");
                    let errors = res.errors;
                    Object.keys(errors).map((value, key) => {
                        $(`#${value}`).addClass('is-invalid');
                    });
                }
                else {
                    sweetAlert('error', res.message);
                }
            },
            error: function (e) {

                if (e.message) {
                    sweetAlert('error', res.message);
                }
                else {
                    sweetAlert('error', "There is something is wrong");
                }
            }
        });
    });

}(jQuery));

let ditectNetworkRPC = $("#ditectNetworkRPC").val();
let ditectNetwork = $("#ditectNetwork").val();
let base_urls = $("#base_url").val();
"use strict";
function mfun(id, val) {


    let optionData = "";
    let bodyData = [];
    bodyData[0] = "Pending";
    bodyData[1] = "Verified";

    for (let i = 0; i <= 1; i++) {
        optionData += "<option value='" + i + "' " + (i == val ? 'selected' : 'null') + ">" + (bodyData[i]) + "</option>";
    }

    $('.nftHtmlData_' + id).html("");
    $('.nftHtmlData_' + id).html('<select id="change_val" onchange="changestatusFun(' + id + ')" class"form-control">' + optionData + '</select>');

}

"use strict";
function changestatusFun(id) {

    var value = $("#change_val").val();
    var url = base_urls + "/backend/nft/changestatus/" + id + "/" + value;

    $.ajax({
        url: url,
        type: 'GET',
        success: function (res) {
            var result = JSON.parse(res)

            if (result.status === 'success') {
                if (value == 1) {
                    $('.nftHtmlData_' + id).html('<span onclick="mfun(' + id + ',' + value + ')" class="btn btn-success btn-md ">Verified <i class="fas fa-angle-down" ></i> </span>');
                    sweetAlert('success', 'Activate');
                } else if (value == 2) {
                    $('.nftHtmlData_' + id).html('<span onclick="mfun(' + id + ',' + value + ')" class="btn btn-danger btn-md ">Suspend <i class="fas fa-angle-down" ></i></span>');
                } else if (value == 0) {
                    $('.nftHtmlData_' + id).html('<span onclick="mfun(' + id + ',' + value + ')" class="btn btn-warning btn-md ">Pending <i class="fas fa-angle-down" ></i></span>');
                    sweetAlert('warning', 'Deactivate');
                }

            }
        }
    });
}


/* Type status change functions */
"use strict";
function typestatus(id, val) {


    let optionData = "";
    let bodyData = [];
    bodyData[0] = "Deactive";
    bodyData[1] = "Active";

    for (let i = 0; i <= 1; i++) {
        optionData += "<option value='" + i + "' " + (i == val ? 'selected' : 'null') + ">" + (bodyData[i]) + "</option>";
    }


    $('.typestatus_' + id).html("");
    $('.typestatus_' + id).html('<select id="change_val" onchange="typestatusChange(' + id + ')" class"form-control">' + optionData + '</select>');
}

"use strict";
function typestatusChange(id) {

    var value = $("#change_val").val();


    var url = base_urls + "/backend/nft/transfer_option_change/" + id + "/" + value;
    $.ajax({
        url: url,
        type: 'GET',
        data: { csrf_token: get_csrf_hash },
        success: function (res) {
            var result = JSON.parse(res)

            if (result.status === 'success') {
                if (value == 1) {
                    $('.typestatus_' + id).html('<span onclick="typestatus(' + id + ',' + value + ')" class="btn btn-success btn-md ">Active <i class="fas fa-angle-down" ></i> </span>');
                } else if (value == 0) {
                    $('.typestatus_' + id).html('<span onclick="typestatus(' + id + ',' + value + ')" class="btn btn-warning btn-md ">Deactive <i class="fas fa-angle-down" ></i></span>');
                }

            }
        }
    });
}


/* Selling type status change option */
"use strict";
function selling_typestatus(id, val) {


    let optionData = "";
    let bodyData = [];
    bodyData[0] = "Deactive";
    bodyData[1] = "Active";

    for (let i = 0; i <= 1; i++) {
        optionData += "<option value='" + i + "' " + (i == val ? 'selected' : 'null') + ">" + (bodyData[i]) + "</option>";
    }


    $('.typestatus_' + id).html("");
    $('.typestatus_' + id).html('<select id="change_val" onchange="selling_typestatusChange(' + id + ')" class"form-control">' + optionData + '</select>');
}

"use strict";
function selling_typestatusChange(id) {

    var value = $("#change_val").val();

    var url = base_urls + "/backend/nft/typestatuschange/" + id + "/" + value;
    $.ajax({
        url: url,
        type: 'GET',
        data: { csrf_token: get_csrf_hash },
        success: function (res) {
            var result = JSON.parse(res)

            if (result.status === 'success') {
                if (value == 1) {
                    $('.typestatus_' + id).html('<span onclick="selling_typestatus(' + id + ',' + value + ')" class="btn btn-success btn-md ">Active <i class="fas fa-angle-down" ></i> </span>');
                    sweetAlert('success', 'Activate');

                } else if (value == 0) {
                    $('.typestatus_' + id).html('<span onclick="selling_typestatus(' + id + ',' + value + ')" class="btn btn-warning btn-md ">Deactive <i class="fas fa-angle-down" ></i></span>');
                    sweetAlert('warning', 'Deactivate');
                }

            }
        }
    });

}



/* A wallet reload function */
"use strict";
async function reloadFunction() {

    let address = $('#wallet_address_balace').val();
    let web3 = getWeb3(ditectNetwork);
    let balance = await web3.eth.getBalance(address);

    balance = parseFloat(balance) / 10 ** 18;

    $('#admin_balance').html(balance);

    $("#reloadbalance").html('<i class="fa fa-spinner fa-spin"></i>');

    let postdata = {};
    postdata[csrf_token] = get_csrf_hash;
    postdata['balance'] = balance;
    postdata['wallet_address'] = address;

    $.ajax({
        url: base_urls + "/backend/nft/wallet_reload",
        type: 'POST',
        dataType: 'json',
        data: postdata,
        success: function (res) {


            if (res.status == 'success') {
                $("#reloadbalance").html('<i class="fa fa-cog" aria-hidden="true"></i> Reload Balance');
            } else {
                $("#reloadbalance").html('<i class="fa fa-cog" aria-hidden="true"></i> Reload Balance');
            }

        },

    });

};


function getWeb3(netWork) {
    return new Web3(new Web3.providers.HttpProvider(ditectNetworkRPC));
}