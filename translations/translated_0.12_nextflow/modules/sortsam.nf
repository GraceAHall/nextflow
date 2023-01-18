nextflow.enable.dsl=2

process SORTSAM {
    debug true
    container "broadinstitute/gatk@sha256:c0f45677e9af6bba65e7234c33a7447f615febd1217e80ea2231fab69bb350a0"
    publishDir "${params.outdir}/align_and_sort/sortsam"
    cpus "${params.align_and_sort.sortsam.cpus}"
    memory "${params.align_and_sort.sortsam.memory}"

    input:
    path bam
    val tmpDir

    output:
    tuple path("${bam.simpleName}.sorted.bam"), path("bam.simpleName}.sorted.bai"), emit: out

    script:
    def maxRecordsInRam = params.align_and_sort.sortsam_max_records_in_ram ? "--MAX_RECORDS_IN_RAM ${params.align_and_sort.sortsam_max_records_in_ram}" : ""
    def tmpDir = tmpDir ? tmpDir : /tmp/
    def validationStringency = params.align_and_sort.sortsam_validation_stringency ? "--VALIDATION_STRINGENCY ${params.align_and_sort.sortsam_validation_stringency}" : ""
    def createIndex = params.align_and_sort.sortsam_create_index == false ? "" : "--CREATE_INDEX"
    """
    gatk SortSam \
    --java-options -Xmx${8 * 3 / 4}G ${binding.hasVariable(None) ? '-Dsamjdk.compress_level=' + None : ''} ${[None, []].first().join(' ')} \
    -I ${bam} \
    -SO ${params.align_and_sort.sortsam_sort_order} \
    -O ${bam.simpleName}.sorted.bam \
    ${maxRecordsInRam} \
    --TMP_DIR ${tmpDir} \
    ${validationStringency} \
    ${createIndex} \
    """

}
