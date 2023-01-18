

nextflow.enable.dsl=2

// SecondaryArray -> SecondaryArray: Do nothing
ch_inputs1 = Channel.of(['A', 'B', 'C']).collect()   // step1 out1
ch_inputs2 = Channel.of(['1', '2', '3']).collect()   // step1 out2
ch_inputs1.view()                                    // step2 input1
ch_inputs2.view()                                    // step2 input2

// NOTE: NOT SCATTERING
// SecondaryArray -> Secondary:
ch_inputs1 = Channel.of(['A', 'B', 'C']).collect()  // step1 out1
ch_inputs2 = Channel.of(['1', '2', '3']).collect()  // step1 out2
ch_inputs1 = ch_inputs1.flatten().first()           // conversion
ch_inputs2 = ch_inputs2.flatten().first()           
ch_inputs3 = Channel.of()
                .concat(ch_inputs1)
                .concat(ch_inputs2)
                .collect()
ch_inputs3.view()                                   // step2 input

// Secondary -> SecondaryArray: 
ch_inputs = Channel.of(['bam', 'bai']).collect()        // step1 out1
ch_inputs.view()
ch_inputs_bam = ch_inputs.flatten().first().collect()  // conversion
ch_inputs_bai = ch_inputs.flatten().last().collect()
ch_inputs_bam.view()                                   // step2 input1
ch_inputs_bai.view()                                   // step2 input2

// NOT IMPLEMENTED
// // Secondary -> SecondaryArray (with sample name)
// ch_inputs = Channel.of(['samplename', ['bam', 'bai']]).collect()    // step1 out1
// ch_inputs.view()