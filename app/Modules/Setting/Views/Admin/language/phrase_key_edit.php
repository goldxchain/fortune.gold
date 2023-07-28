<div class="row">
    <div class="col-md-12 col-lg-12">
        <div class="card mb-4">
            <div class="card-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        </div>
                        <div class="">
                            <a class="btn btn-primary" href="<?php echo base_url("backend/language/phrase_list") ?>"> <i class="fa fa-list"></i>  Phrase List </a> 
                        </div>
                    </div>
                </div>
            </div> 
            <div class="card-body">           
                <?php echo  form_open(base_url('backend/language/update_phrase_key')) ?>
                    <input type="hidden" name="id" value="<?php echo esc($phraseKey->id) ?>" style="display:none;"> 
                    <div class="form-group row">
                        <label for="phrase" class="col-sm-3 col-form-label">Phrase Key<span class="text-danger"> *</span></label>
                        <div class="col-sm-9">
                            <input name="phrase" class="form-control" type="text" placeholder="Phrase Key"   value="<?php echo esc($phraseKey->phrase) ?>" required <?php echo $phraseKey->system_default == 1 ? "readonly" : "" ?> >
                            <span class="error text-danger"><?php echo $validation->getError('phrase'); ?></span>
                        </div>
                    </div>

                    <?php 
                        foreach($language_key as $language){
                    ?>
                    <div class="form-group row">
                        <label for="phrase" class="col-sm-3 col-form-label"> <?php echo esc(ucfirst($language)); ?> <span class="text-danger"> *</span></label>
                        <div class="col-sm-9">
                            <input name="phrase_value['<?php echo esc($language); ?>']" class="form-control" type="text" placeholder="<?php echo esc(ucfirst($language)); ?> Value"   value="<?php echo esc($phraseKey->$language) ?>" required>
                        </div>
                    </div>
                    <?php } ?>
                     
                    <div class="row" align="center">
                        <div class="col-sm-12 col-sm-offset-3">
                            <button type="submit" name="update" class="btn btn-success  w-md m-b-5">Update</button>
                        </div>
                    </div>
                <?php echo  form_close() ?>
            </div>
    </div>
</div>