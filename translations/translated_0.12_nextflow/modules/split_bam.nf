nextflow.enable.dsl=2

process SPLIT_BAM {
    debug true
    container "broadinstitute/gatk@sha256:e37193b61536cf21a2e1bcbdb71eac3d50dcb4917f4d7362b09f8d07e7c2ae50"
    publishDir "${params.outdir}/vc_gatk/split_bam"
    memory "${params.vc_gatk.split_bam.memory}"

    input:
    tuple path(bam), path(bai)
    path intervals

    output:
    tuple path("${bam.name}"), path("${bam.bai}"), emit: out

    script:
    def intervals = intervals ? "--intervals ${intervals}" : ""
    """
    gatk SplitReads \
    --java-options -Xmx${4 * 3 / 4}G ${binding.hasVariable(None) ? '-Dsamjdk.compress_level=' + None : ''} ${[None, []].first().join(' ')} \
    ${intervals} \
    --output . \
    --input ${bam} \
    """

}
