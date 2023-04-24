

include { GET_FILENAME } from './modules/get_filename'
include { RENAME_FILE } from './modules/rename_file'
include { SUBWF } from './subworkflows/subwf'




ch_file = Channel.fromPath( params.file )

workflow {
    GET_FILENAME(ch_file).view()
    RENAME_FILE(ch_file).view()
    SUBWF(ch_file)
    SUBWF.out.filename.view()
    SUBWF.out.new_file.view()
}


