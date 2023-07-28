(function ($) {
    "use strict";
    var base_url = $("#base_url").val();

    if ($('#ajaxusertableform_nft').length) {
        var table;
        let earning_type = $("#earning_type").val();
        let category = $("#category").val();
        let collection = $("#collection").val();
        let user_val = $("#user_val").val();
        let urls = "?earning_type=" + earning_type + "&category=" + category + "&collection=" + collection + "&user=" + user_val;

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
                "url": base_url + '/backend/report/report_ajax_list' + urls,
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
                $(".total-earned").text(response.totalAmount);
            }

        });

        $.fn.dataTable.ext.errMode = 'none';
    }


    $(".select2").select2({});

}(jQuery));


