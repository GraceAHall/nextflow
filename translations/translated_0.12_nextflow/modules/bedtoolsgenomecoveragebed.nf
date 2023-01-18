nextflow.enable.dsl=2

process BEDTOOLSGENOMECOVERAGEBED {
    debug true
    container "quay.io/biocontainers/bedtools@sha256:02e198f8f61329f9eafd1b9fc55828a31020b383403adec22079592b7d868006"
    publishDir "${params.outdir}/performance_summary/bedtoolsgenomecoveragebed"
    memory "${params.performance_summary.bedtoolsgenomecoveragebed.memory}"

    input:
    path genome
    path inputBam

    output:
    path "generated", emit: out

    script:
    def genome = genome ? "-g ${genome}" : ""
    def inputBam = inputBam ? "-ibam ${inputBam}" : ""
    """
    genomeCoverageBed \
    ${genome} \
    ${inputBam} \
    > generated \
    """

}
