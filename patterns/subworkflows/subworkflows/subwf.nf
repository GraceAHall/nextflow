


include { GET_FILENAME } from '../modules/get_filename'
include { RENAME_FILE } from '../modules/rename_file'


workflow SUBWF {
    take:
    ch_file 

    main:
    GET_FILENAME(ch_file)
    RENAME_FILE(ch_file)

    emit:
    filename = GET_FILENAME.out
    new_file = RENAME_FILE.out
}