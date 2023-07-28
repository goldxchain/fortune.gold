<div class="row">
    <div class="col-md-12 col-lg-12">
        <div class="card mb-4">
            <div class="card-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <a class="btn btn-primary" href="<?php echo base_url("backend/language/language_list") ?>"> <i class="fa fa-list"></i> <?php echo display('Language List') ?>  </a> 
                    </div>
                    <div class="">
                        <div class="actions">
                            <a class="btn btn-success" href="<?php echo base_url("backend/language/export_phrase/".$language) ?>">
                                <i class="fa fa-file-export"></i> <?php echo display('Export Phrase') ?>
                            </a>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#importModal">
                                <i class="fa fa-cloud-upload-alt"></i> <?php echo display('Import Phrase') ?>
                            </button>
                            <a class="btn btn-success" href="<?php echo base_url("backend/language/phrase_list") ?>"> <i class="fa fa-plus"></i> <?php echo display('Add Phrase') ?></a>
                        </div>
                    </div>
                </div>
            </div> 
            <div class="card-body"> 
                <div class="row ">
                    <div class="col-md-6"></div>
                    <div class="col-md-6 ">
                        <form method='get' action="<?php echo base_url("backend/language/edit_phrase/".$language) ?>" id="searchForm" class="form-inline float-right">
                            <input type='text' name='search' class="form-control" placeholder="Search">
                            <button type="submit" class="btn btn-primary">
                                <i class="fa fa-search"></i> <?php echo display('Search') ?> 
                            </button>
                        </form>
                    </div>
                </div>

                <?php echo  form_open(base_url('backend/language/add_lebel')) ?>
                    <table class="table table-striped">
                        <thead> 
                            <tr>
                                <th><i class="fa fa-th-list"></i></th>
                                <th><?php echo display('Phrase') ?> </th>
                                <th><?php echo display('Label') ?> </th> 
                            </tr>
                        </thead>
                        <tbody>
                            <?php echo  form_hidden('language', $language) ?>
                            <?php if (!empty($phrases)) {?>
                                <?php $sl = 1 ?>
                                <?php foreach ($phrases as $value) {?>
                                <tr class="<?php echo  (empty($value->$language)?"bg-danger":null) ?>">
                                
                                    <td><?php echo  esc($sl++) ?></td>
                                    <td><input type="text" name="phrase[]" value="<?php echo  esc($value->phrase) ?>" class="form-control" readonly></td>
                                    <td><input type="text" name="lang[]" value="<?php echo  esc($value->$language) ?>" class="form-control"></td> 
                                </tr>
                                <?php } ?>
                            <?php } ?> 
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="3" align="center"> 
                                    <button type="submit" class="btn btn-success"><?php echo display('Save') ?></button>
                                </td>
                            
                            </tr>
                        </tfoot>
                    </table>
                <?php echo $pager ?>
            <?php echo  form_close() ?>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="importModal" tabindex="-1" role="dialog" aria-labelledby="importModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="importModalLabel"><?php echo display('Modal title') ?></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form method='post' action="<?php echo base_url("backend/language/import_phrase/".$language) ?>" id="searchForm" class="form-inline float-left mr-1" enctype="multipart/form-data">
            <input type='file' name='file' class="form-control" placeholder="File" accept=".xlsx, .xls, .csv">
            <button type="submit" class="btn btn-primary ">
                Submit
            </button>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>