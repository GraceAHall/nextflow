
nextflow.enable.dsl=2

// ARRAY -> ARRAY: do nothing
ch_inputs = Channel.of([1, 2]).collect()    // step1 output
ch_inputs.view()                            // step2 input

// **NOT SCATTER
// ARRAY -> SINGLE: flatten() to make individual elements in channel, take first 
ch_inputs = Channel.of([1, 2]).collect()    // step1 output
ch_inputs = ch_inputs.flatten().first()     // conversion
ch_inputs.view()                            // step2 input

// SINGLE -> ARRAY: COLLECT()
ch_inputs = Channel.of( 1 )     // step1 output
ch_inputs = ch_inputs.collect() // conversion
ch_inputs.view()                // step2 input