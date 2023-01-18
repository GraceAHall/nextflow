
nextflow.enable.dsl=2

// NOTE:
// Janis does not allow scattering on non-array datatypes. 
// No implicit conversion to array. 

// Scatter -> Scatter
// Assuming here that ch_inputs is the input scattered on in both steps.
ch_inputs = Channel.of([1, 2])  // step1 output
ch_inputs = ch_inputs.collect() // reassign
ch_inputs.flatten().view()      // step2 call

// Scatter -> Subscatter: do nothing
ch_inputs = Channel.of([1, 2])   // step1 output
ch_inputs.view()                 // step2 call

// Scatter -> Array: collect.
ch_inputs = Channel.of([1, 2])   // step1 output
ch_inputs = ch_inputs.collect()  // reassign
ch_inputs.view()                 // step2 call  (use array)

// Array -> Scatter: 
ch_inputs = Channel.of([1, 2]).collect()  // step1 output
ch_inputs.flatten().view()                // step2 call