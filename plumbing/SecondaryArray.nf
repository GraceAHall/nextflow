

nextflow.enable.dsl=2

// ch_strings = Channel.of(['A1', 'A2', 'A3'], ['B1', 'B2', 'B3'])   // step1 out1
// ch_strings.view()  // step2 input1

// ch_bambais = Channel.fromPath(
//     ['../data/aln1.sorted.bam', '../data/aln1.sorted.bai'], 
// ).toList()   // step1 out1
// ch_bambais.view()


params.bambais = [
    ['../data/aln1.sorted.bam', '../data/aln1.sorted.bai'],
    ['../data/aln2.sorted.bam', '../data/aln2.sorted.bai']
]

ch_bambais = Channel.fromPath( params.bambais.flatten() ).buffer( size: 2 )
ch_bambais.view()

workflow {
    SECONDARIES(
        ch_bambais
    )
}

process SECONDARIES {
    input:
    tuple path(bam), path(bai)

    output:
    tuple path(bam), path(bai)

    script:
    """
    touch ${bam}
    touch ${bai}
    """
}


// ch_bambais = Channel.of()
//                 .concat(Channel.fromPath(params.bambais[0]).toList())
//                 .concat(Channel.fromPath(params.bambais[1]).toList())
//                 .view()


// ch_bambais = Channel.of()
//                 .concat(Channel.fromPath(['../data/aln1.sorted.bam', '../data/aln1.sorted.bai']).toList())
//                 .concat(Channel.fromPath(['../data/aln2.sorted.bam', '../data/aln2.sorted.bai']).toList())

// ch_bambais.view()


// ch_bambais = Channel.fromPath([
//     ['../data/aln1.sorted.bam', '../data/aln1.sorted.bai'], 
//     ['../data/aln2.sorted.bam', '../data/aln2.sorted.bai'], 
// ])   // step1 out1
// ch_bambais.view()


// workflow {
//     SECONDARIES(
//         ch_bambais
//     )
// }

// process SECONDARIES {
//     input:
//     path bambai

//     output:
//     path bambai, emit: bambai

//     script:
//     def bam = bambai[0]
//     def bai = bambai[1]
//     """
//     """
// }



// // SecondaryArray -> SecondaryArray: Do nothing

// NOTE: NOT SCATTERING
// SecondaryArray -> Secondary:

// Secondary -> SecondaryArray: 


