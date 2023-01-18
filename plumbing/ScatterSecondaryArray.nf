

nextflow.enable.dsl=2


ch_bambais = Channel.of(
    ['sample1', 'bam1', 'bai1'],
    ['sample2', 'bam2', 'bai2'],
    ['sample3', 'bam3', 'bai3'],
)   







// // ScatterSecondaryArray -> ScatterSecondaryArray
// ch_bams = Channel.of(['bam1', 'bam2', 'bam3'])   // step1 out1
// ch_bais = Channel.of(['bai1', 'bai2', 'bai3'])   // step1 out2
// ch_bams = ch_bams.flatten()           // conversion
// ch_bais = ch_bais.flatten()           
// ch_temp = Channel.of()
//                 .concat(ch_bams)
//                 .concat(ch_bais)
//                 .collect()
// ch_temp.view()            


// // parallel arrays to tuples
// ch_bams = Channel.of(['bam1', 'bam2', 'bam3'])   // step1 out1
// ch_bais = Channel.of(['bai1', 'bai2', 'bai3'])   // step1 out2
// ch_bambais = Channel.of([['bam1', 'bam2', 'bam3'], ['bai1', 'bai2', 'bai3']]).transpose().view()


// tuples to parallel arrays

// cartesian cross scatter 
// .combine()


// ScatterSecondaryArray -> Subscatter:

// ScatterSecondaryArray -> SecondaryArray:

// SecondaryArray -> ScatterSecondaryArray:


// workflow {



//     SCATTER_SECONDARY_ARRAY(
//         ch_bams.flatten(),
//         ch_bais.flatten(),
//     )
//     // SCATTER_SECONDARY_ARRAY.out.view()
// }

// process SCATTER_SECONDARY_ARRAY {
//     input:
//     tuple val(bam), val(bai)

//     output: 
//     tuple val(bam), val(bai)
    
//     script:
//     """
//     """
// }

// process SUBSCATTER {
//     input:
//     val bam
//     val bai

//     output: 
//     val bam, emit: bam
//     val bai, emit: bai

//     script:
//     """
//     """
// }


