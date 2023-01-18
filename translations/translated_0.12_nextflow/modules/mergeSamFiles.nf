nextflow.enable.dsl=2

process MERGE_SAM_FILES {
    debug true
    container "broadinstitute/gatk@sha256:e37193b61536cf21a2e1bcbdb71eac3d50dcb4917f4d7362b09f8d07e7c2ae50"
    publishDir "${params.outdir}/merge_and_markdups/mergesamfiles"
    cpus "${params.merge_and_markdups.merge_sam_files.cpus}"
    memory "${params.merge_and_markdups.merge_sam_files.memory}"

    input:
    path bams
    path bais
    val sampleName

    output:
    tuple path("${sampleName}.merged.bam"), path("sampleName}.merged.bai"), emit: out

    script:
    def useThreading = params.merge_and_markdups.merge_sam_files_use_threading == false ? "" : "--USE_THREADING"
    def bams = bams.collect{ "-I " + it }.join(' ')
    def maxRecordsInRam = params.merge_and_markdups.max_records_in_ram ? "--MAX_RECORDS_IN_RAM ${params.merge_and_markdups.max_records_in_ram}" : ""
    def validationStringency = params.merge_and_markdups.merge_sam_files_validation_stringency ? "--VALIDATION_STRINGENCY ${params.merge_and_markdups.merge_sam_files_validation_stringency}" : ""
    def createIndex = params.merge_and_markdups.create_index == false ? "" : "--CREATE_INDEX"
    """
    gatk MergeSamFiles \
    --java-options -Xmx${8 * 3 / 4}G ${binding.hasVariable(None) ? '-Dsamjdk.compress_level=' + None : ''} ${[None, []].first().join(' ')} \
    ${useThreading} \
    -I ${bams} \
    -O ${sampleName}.merged.bam \
    ${maxRecordsInRam} \
    ${validationStringency} \
    ${createIndex} \
    --TMP_DIR /tmp/ \
    """

}
