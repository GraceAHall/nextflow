nextflow.enable.dsl=2

process BASE_RECALIBRATOR {
    debug true
    container "broadinstitute/gatk@sha256:e37193b61536cf21a2e1bcbdb71eac3d50dcb4917f4d7362b09f8d07e7c2ae50"
    publishDir "${params.outdir}/bqsr/base_recalibrator"
    cpus "${params.bqsr.base_recalibrator.cpus}"
    memory "${params.bqsr.base_recalibrator.memory}"

    input:
    tuple path(bam), path(bai)
    tuple path(fasta), path(amb), path(ann), path(bwt), path(dict), path(fai), path(pac), path(sa)
    path gzs
    path tbis
    path intervals

    output:
    path "${bam.simpleName}.table", emit: out

    script:
    def intervals = intervals ? "--intervals ${intervals}" : ""
    def knownSites = gzs.collect{ "--known-sites " + it }.join(' ')
    """
    gatk BaseRecalibrator \
    --java-options -Xmx${16 * 3 / 4}G ${binding.hasVariable(None) ? '-Dsamjdk.compress_level=' + None : ''} ${[None, []].first().join(' ')} \
    ${intervals} \
    --tmp-dir /tmp/ \
    -R ${fasta} \
    -I ${bam} \
    -O ${bam.simpleName}.table \
    --known-sites ${knownSites} \
    """

}
