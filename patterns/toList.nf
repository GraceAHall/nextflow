

nextflow.enable.dsl=2


ch_bams1 = Channel.of(['bam1', 'bam2', 'bam3']) 
ch_bams1.toList().view{ 'ch_bams1 toList(): ' + it }
ch_bams1.collect().view{ 'ch_bams1 collect(): ' + it }

ch_bams2 = Channel.of(['bam1', ['bam2', 'bam3']]) 
ch_bams2.toList().view{ 'ch_bams2 toList(): ' + it }
ch_bams2.collect().view{ 'ch_bams2 collect(): ' + it }

ch_bams3 = Channel.of(['bam1', [['bam2'], 'bam3']]) 
ch_bams3.toList().view{ 'ch_bams3 toList(): ' + it }
ch_bams3.collect().view{ 'ch_bams3 collect(): ' + it }