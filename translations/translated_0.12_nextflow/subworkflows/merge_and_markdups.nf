nextflow.enable.dsl=2

include { MERGE_SAM_FILES } from '../modules/mergeSamFiles'
include { MARK_DUPLICATES } from '../modules/markDuplicates'

workflow MERGE_AND_MARKDUPS {

    take:
    ch_bams_bais
    ch_bams_bams
    ch_sample_name

    main:
    MERGE_SAM_FILES(
        ch_bams_bais,
        ch_bams_bams,
        ch_sample_name
    )

    MARK_DUPLICATES(
        MERGE_SAM_FILES.out.out,
        ch_sample_name
    )

    emit:
    out = MARK_DUPLICATES.out.out

}
