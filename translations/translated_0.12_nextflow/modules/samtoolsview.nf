nextflow.enable.dsl=2

process SAMTOOLSVIEW {
    debug true
    container "quay.io/biocontainers/samtools@sha256:3883c91317e7b6b62e31c82e2cef3cc1f3a9862633a13f850a944e828dd165ec"
    publishDir "${params.outdir}/performance_summary/samtoolsview"

    input:
    val sam

    output:
    path "${sam}.bam", emit: out

    script:
    def doNotOutputAlignmentsWithBitsSet = params.performance_summary.samtoolsview_do_not_output_alignments_with_bits_set ? "-F ${params.performance_summary.samtoolsview_do_not_output_alignments_with_bits_set}" : ""
    """
    samtools view \
    -S \
    -h \
    -b \
    ${doNotOutputAlignmentsWithBitsSet} \
    -o ${sam}.bam \
    ${sam} \
    """

}
