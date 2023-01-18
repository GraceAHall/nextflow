nextflow.enable.dsl=2

process CUTADAPT {
    debug true
    container "quay.io/biocontainers/cutadapt@sha256:2141194ef375c35a34ded3d5cd5457150d6f8f797432edadee32ab238a4036d2"
    publishDir "${params.outdir}/align_and_sort/cutadapt"
    cpus "${params.align_and_sort.cutadapt.cpus}"
    memory "${params.align_and_sort.cutadapt.memory}"

    input:
    path fastq
    val outputPrefix
    val adapter
    val adapterSecondRead

    output:
    tuple path("${outputPrefix + '-R1.fastq.gz'}"), path("${outputPrefix + '-R2.fastq.gz'}"), emit: out

    script:
    def front = params.align_and_sort.five_prime_adapter_read1 ? "--front " + params.align_and_sort.five_prime_adapter_read1.join(' ') : ""
    def minimumLength = params.align_and_sort.cutadapt_minimum_length ? "--minimum-length ${params.align_and_sort.cutadapt_minimum_length}" : ""
    def qualityCutoff = params.align_and_sort.cutadapt_quality_cutoff ? "--quality-cutoff ${params.align_and_sort.cutadapt_quality_cutoff}" : ""
    def adapterSecondRead = adapterSecondRead ? "-A " + adapterSecondRead.collect{ "-A " + it }.join(' ') : ""
    def frontAdapterSecondRead = params.align_and_sort.five_prime_adapter_read2 ? "-G " + params.align_and_sort.five_prime_adapter_read2.join(' ') : ""
    def adapter = adapter ? "-a " + adapter.collect{ "-a " + it }.join(' ') : ""
    def fastq = fastq.join(' ')
    """
    cutadapt \
    ${front} \
    ${minimumLength} \
    ${qualityCutoff} \
    ${adapterSecondRead} \
    ${frontAdapterSecondRead} \
    ${adapter} \
    -o ${outputPrefix}-R1.fastq.gz \
    -p ${outputPrefix}-R2.fastq.gz \
    ${fastq} \
    """

}
