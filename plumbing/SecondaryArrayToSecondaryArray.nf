
nextflow.enable.dsl=2

// SECONDARY ARRAY -> SECONDARY ARRAY

ch_bambais = Channel.of(
    ['sample1', ['bam1', 'bai1']],
    ['sample2', ['bam2', 'bai2']],
    ['sample3', ['bam3', 'bai3']],
)

// ---- OPERATION ----

// illustration of operation below:
// ['sample1', ['bam1', 'bai1']]
// ['sample2', ['bam2', 'bai2']]
// ['sample3', ['bam3', 'bai3']]
// ->
// ['sample1', 'sample2', 'sample3']
// ['bam1', 'bam2', 'bam3']
// ['bai1', 'bai2', 'bai3']

ch_bambais.multiMap { it ->
    samples: it[0]
    bams: it[1][0]
    bais: it[1][1]
}
.set { temp }

// -------------------


workflow {
    temp.samples.toList().view()
    temp.bams.toList().view()
    temp.bais.toList().view()
    STP(
        temp.samples.toList(),
        temp.bams.toList(),
        temp.bais.toList(),
    )
}

process STP {
    input:
    val samples
    val bams
    val bais

    output:
    val samples, emit: samples
    val bams, emit: bams
    val bais, emit: bais

    script:
    """
    """
}

