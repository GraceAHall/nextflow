nextflow.enable.dsl=2

// imports
include { CUTADAPT } from './modules/cutadapt.nf'


// channels
reads = Channel.fromPath(params.reads)


workflow {
    CUTADAPT(
      reads,
      params.cutadapt_min_length,
      params.cutadapt_min_qual,
      params.cutadapt_trim_n
    ).view{ it }
}