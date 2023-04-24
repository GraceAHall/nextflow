

nextflow.enable.dsl=2

params.bam = '/home/grace/work/pp/translation/nextflow/data/aln1.sorted.bam'
params.bai = '/home/grace/work/pp/translation/nextflow/data/aln1.sorted.bam.bai'

ch_bambai = Channel.fromPath( [params.bam, params.bai] ).collect()
ch_invervals = Channel.of( ).ifEmpty( null )

workflow {
    SPLIT_BAM(
        ch_bambai,
        ch_invervals
    )
}

process SPLIT_BAM {
    input:
    tuple path(bam), path(bai)
    path intervals, stageAs: 'intervals.bed'

    output:
    tuple path("${params.vc_gatk.split_bam_output_filename + "/" + bam.name}"), path("*.bai"), emit: out

    script:
    def compression_level = null
    def java_options = null
    def intervals = intervals ? "--intervals ${intervals}" : ""
    def output_filename = params.vc_gatk.split_bam_output_filename ? params.vc_gatk.split_bam_output_filename : '.'
    """
    mkdir -p '${params.vc_gatk.split_bam_output_filename}' \
    gatk SplitReads \
    --java-options "-Xmx${4 * 3 / 4}G ${compression_level ? "-Dsamjdk.compress_level=" + compression_level : ""} ${[java_options, []].find{ it != null }.join(" ")}" \
    ${intervals} \
    --output ${output_filename} \
    --input ${bam} \
    """

}