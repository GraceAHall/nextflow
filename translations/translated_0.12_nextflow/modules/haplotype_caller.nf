nextflow.enable.dsl=2

process HAPLOTYPE_CALLER {
    debug true
    container "broadinstitute/gatk@sha256:e37193b61536cf21a2e1bcbdb71eac3d50dcb4917f4d7362b09f8d07e7c2ae50"
    publishDir "${params.outdir}/vc_gatk/haplotype_caller"
    cpus "${params.vc_gatk.haplotype_caller.cpus}"
    memory "${params.vc_gatk.haplotype_caller.memory}"

    input:
    tuple path(bam), path(bai)
    tuple path(fasta), path(amb), path(ann), path(bwt), path(dict), path(fai), path(pac), path(sa)
    tuple path(gz), path(tbi)
    path intervals

    output:
    tuple path("${bam.simpleName}.vcf.gz"), path("${bam.simpleName}.vcf.gz"), emit: out
    tuple path("${bam.simpleName}.bam"), path("bam.simpleName}.bai"), emit: bam

    script:
    def intervals = intervals ? "--intervals ${intervals}" : ""
    def pairHmmImplementation = params.vc_gatk.haplotype_caller_pair_hmm_implementation ? "--pair-hmm-implementation ${params.vc_gatk.haplotype_caller_pair_hmm_implementation}" : ""
    def dbsnp = gz ? "--dbsnp ${gz}" : ""
    """
    gatk HaplotypeCaller \
    --java-options -Xmx${8 * 3 / 4}G ${binding.hasVariable(None) ? '-Dsamjdk.compress_level=' + None : ''} ${[None, []].first().join(' ')} \
    --input ${bam} \
    ${intervals} \
    ${pairHmmImplementation} \
    --reference ${fasta} \
    ${dbsnp} \
    --output ${bam.simpleName}.vcf.gz \
    -bamout ${bam.simpleName}.bam \
    """

}
