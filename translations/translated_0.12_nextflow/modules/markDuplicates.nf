nextflow.enable.dsl=2

process MARK_DUPLICATES {
    debug true
    container "broadinstitute/gatk@sha256:e37193b61536cf21a2e1bcbdb71eac3d50dcb4917f4d7362b09f8d07e7c2ae50"
    publishDir "${params.outdir}/merge_and_markdups/markduplicates"
    cpus "${params.merge_and_markdups.mark_duplicates.cpus}"
    memory "${params.merge_and_markdups.mark_duplicates.memory}"

    input:
    path bam
    val outputPrefix

    output:
    tuple path("${[outputPrefix, 'generated'].first()}.markduped.bam"), path("[outputPrefix, 'generated'].first()}.markduped.bai"), emit: out
    path "${[outputPrefix, 'generated'].first()}.metrics.txt", emit: metrics

    script:
    def bam = bam.join(' ')
    def maxRecordsInRam = params.merge_and_markdups.max_records_in_ram ? "--MAX_RECORDS_IN_RAM ${params.merge_and_markdups.max_records_in_ram}" : ""
    def createIndex = params.merge_and_markdups.create_index == false ? "" : "--CREATE_INDEX"
    """
    gatk MarkDuplicates \
    --java-options -Xmx${8 * 3 / 4}G ${binding.hasVariable(None) ? '-Dsamjdk.compress_level=' + None : ''} ${[None, []].first().join(' ')} \
    -I ${bam} \
    -M ${[outputPrefix, 'generated'].first()}.metrics.txt \
    -O ${[outputPrefix, 'generated'].first()}.markduped.bam \
    ${maxRecordsInRam} \
    ${createIndex} \
    --TMP_DIR tmp/ \
    """

}
