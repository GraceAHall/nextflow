nextflow.enable.dsl=2

// imports
include { SINGLE_ITEMS_CHANNELS } from './single_items_channels.nf'
include { SINGLE_ITEMS_PARAMS } from './single_items_params.nf'
include { ARRAYS_PARAMS } from './arrays_params.nf'

// channels
ch_array = Channel.fromList(params.align_penalties).collect()
ch_array.view{ it }
// ch_reads = Channel.fromPath(params.reads)
// ch_opt_optional = Channel.of(params.opt_optional).ifEmpty(null)
// ch_opt_default = Channel.of(params.opt_default).ifEmpty(null)
// ch_flag_true_default = Channel.of(params.flag_true_default).ifEmpty(null)
// ch_flag_false_default = Channel.of(params.flag_false_default).ifEmpty(null)



workflow {
    ARRAYS_PARAMS(
      ch_array
    )

    // SINGLE_ITEMS_CHANNELS(
    //   ch_reads,
    //   params.opt,
    //   ch_opt_optional,
    //   ch_opt_default,
    //   ch_flag_true_default,
    //   ch_flag_false_default
    // ).view{ it }
    
    // SINGLE_ITEMS_PARAMS(
    //   ch_reads
    // ).view{ it }
}