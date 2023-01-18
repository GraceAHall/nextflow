
nextflow.enable.dsl=2

/*
SECONDARY ARRAY -> SECONDARY (PROCESS INPUT)
(see janis_core.tests.testworkflows.operations for janis examples)

NOTE: scatter or datatype mismatch: Array -> Single

*/

ch_bambais = Channel.of(
    ['sample1', ['bam1', 'bai1']],
    ['sample2', ['bam2', 'bai2']],
    ['sample3', ['bam3', 'bai3']],
)

// ---- OPERATION ----
temp = ch_bambais.map{ it -> [it[0], it[1][0], it[1][1]] }
// [sample1, [bam1, bai1]] -> [sample1, bam1, bai1]
// -------------------  


workflow {
    // temp.view{ 'input: ' + it }
    // STP(temp)
    // STP.out.sample.view{ 'output sample: ' + it }
    // STP.out.bambai.view{ 'output bambai: ' + it }

    STP_ALT(ch_bambais)
    STP_ALT.out.view()
}

process STP {
    input:
    tuple val(sampleid), val(bam), val(bai)

    output:
    val sampleid, emit: sampleid
    tuple val(bam), val(bai), emit: bambai

    script:
    """
    """
}

process STP_ALT {
    input:
    tuple val(sampleid), val(bambai)

    output:
    tuple val(sampleid), val(bambai)

    script:
    bam = bambai[0]
    bai = bambai[1]
    """
    echo "bam: ${bam}"
    echo "bai: ${bai}"
    """
}









// // format 1: CORRECT FORMAT
// workflow {
//     // remap channel elements to format needed for process 
//     ch_bambais.multiMap { it ->
//         samples: it[0]
//         bams: it[1][0]
//         bais: it[1][1]
//     }
//     .set { temp }

//     // call process
//     FMT1_ARRAY(
//         temp.samples.collect(),
//         temp.bams.collect(),
//         temp.bais.collect(),
//     )
//     // IMPORTANT: disallow any output which is an Array(SecondaryType).
//     FMT1_ARRAY.out.samples.view()
//     FMT1_ARRAY.out.bams.view()
//     FMT1_ARRAY.out.bais.view()

//     // // call process
//     // FMT1_SCATTER_OR_DATATYPE_MISMATCH_SINGLE(
//     //     temp.samples,
//     //     temp.bams,
//     //     temp.bais,
//     // )
//     // FMT1_SCATTER_OR_DATATYPE_MISMATCH_SINGLE.out.view()

// }

// process FMT1_ARRAY {
//     input:
//     val samples
//     val bams
//     val bais

//     output:
//     val samples, emit: samples
//     val bams, emit: bams
//     val bais, emit: bais

//     script:
//     """
//     """
// }

// process FMT1_SCATTER_OR_DATATYPE_MISMATCH_SINGLE {
//     input:
//     val sample
//     val bam
//     val bai

//     output:
//     tuple val(sample), val(bam), val(bai)

//     script:
//     """
//     """
// }

// // format 2
// workflow {
    // ch_bambais.multiMap { it ->
    //     samples: it[0]
    //     bambais: [it[1][0], it[1][1]]
    // }
    // .set { temp }

    // FMT2_ARRAY(
    //     temp.samples.toList(),
    //     temp.bambais.toList(),
    // )
    // FMT2_ARRAY.out.samples.view()
    // FMT2_ARRAY.out.bambais.view()

    // FMT2_SINGLE(
    //     temp.samples,
    //     temp.bambais,
    // )
    // FMT2_SINGLE.out.view()
// }

// process FMT2_ARRAY {
//     input:
//     val samples
//     val bambais

//     output:
//     val samples, emit: samples
//     val bambais, emit: bambais

//     script:
//     """
//     """
// }

// process FMT2_SINGLE {
//     input:
//     val sample
//     val bambai

//     output:
//     tuple val(sample), val(bambai)

//     script:
//     """
//     """
// }
