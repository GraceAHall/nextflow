

include { FASTQC as FASTQC1; FASTQC as FASTQC2 } from './modules/fastqc'

params.in_fastq = '/home/grace/work/pp/translation/nextflow/data/mutant_R1.fastq'

ch_in_fastq = Channel.fromPath( params.in_fastq )

workflow {
    FASTQC1(ch_in_fastq)
    FASTQC2(ch_in_fastq)
}

