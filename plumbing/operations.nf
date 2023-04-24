
nextflow.enable.dsl=2

params.bambais = [
    ['../data/aln1.sorted.bam', '../data/aln1.sorted.bai'],
    ['../data/aln2.sorted.bam', '../data/aln2.sorted.bai']
]
ch_secondary_array = Channel.fromPath( params.bambais.flatten() ).collate( 2 ).toList()
ch_array = Channel.of([1, 2]).toList() 
ch_single = Channel.of( 1 )
ch_secondary = Channel.fromPath( ['../data/aln2.sorted.bam', '../data/aln2.sorted.bai'] ).toList()



// DATATYPE MISMATCHES:

// // Array -> Single (no scatter)
// workflow {
//     ch_stp1_out = ch_array
//     ch_stp2_in = ch_stp1_out.flatten().first()
//     ch_stp1_out.view{ 'stp1 out: ' + it }
//     ch_stp2_in.view{ 'stp2 in: ' + it }    
//     SINGLE(ch_stp1_out.flatten().first())
//     SINGLE.out.view{ 'stp2 out: ' + it }
// }

// // Single -> Array
// workflow {
//     ch_stp1_out = ch_single
//     ch_stp2_in = ch_stp1_out.toList()
//     ch_stp1_out.view{ 'stp1 out: ' + it }
//     ch_stp2_in.view{ 'stp2 in: ' + it }    
//     ARRAY(ch_stp1_out.toList())
//     ARRAY.out.view{ 'stp2 out: ' + it }
// }

// // SecondaryArray -> Secondary(no scatter)
// workflow {
//     ch_stp1_out = ch_secondary_array
//     ch_stp2_in = ch_stp1_out.flatten().collate( 2 ).first()
//     ch_stp1_out.view{ 'stp1 out: ' + it }
//     ch_stp2_in.view{ 'stp2 in: ' + it }    
//     SECONDARY(ch_stp1_out.flatten().collate( 2 ).first())
//     SECONDARY.out.view{ 'stp2 out: ' + it }
// }

// // Secondary -> SecondaryArray
// // SecondaryArray passed as input must be flattened.
// // primary files are recovered as array using get_primary_files()
// workflow {
//     ch_stp1_out = ch_secondary
//     ch_stp2_in = ch_stp1_out.flatten().toList()
//     ch_stp1_out.view{ 'stp1 out: ' + it }
//     ch_stp2_in.view{ 'stp2 in: ' + it }    
//     SECONDARY_ARRAY(ch_stp1_out.flatten().toList())
//     SECONDARY_ARRAY.out.bams.view{ 'stp2 out: ' + it }
// }


// // SCATTER DOT
// // Scatter(Array) -> Scatter(Array)
// // all stp1 jobs must complete & are gathered before stp2 starts.
// workflow {
//     ch_stp1_out = ch_array.flatten()            
//     ch_stp2_in = ch_stp1_out.toList().flatten()
//     ch_stp1_out.view{ 'stp1 out: ' + it }
//     ch_stp2_in.view{ 'stp2 in: ' + it }    
//     ARRAY(ch_stp1_out.toList().flatten())
//     ARRAY.out.view{ 'stp2 out: ' + it }
// }

// // Scatter(Array) -> Array
// workflow {
//     ch_stp1_out = ch_array.flatten()    // step1 output
//     ch_stp2_inp = ch_stp1_out.toList()  // step2 input
//     ch_stp1_out.view{ 'stp1 out: ' + it }
//     ch_stp2_inp.view{ 'stp2 inp: ' + it }
//     ARRAY(ch_stp1_out.toList())
//     ARRAY.out.view{ 'stp2 out: ' + it }
// }

// // Array -> Scatter(Array)
// workflow {
//     ch_stp1_out = ch_array              // step1 output
//     ch_stp2_inp = ch_stp1_out.flatten() // step2 input
//     ch_stp1_out.view{ 'stp1 out: ' + it }
//     ch_stp2_inp.view{ 'stp2 inp: ' + it }
//     SINGLE(ch_stp1_out.flatten())
//     SINGLE.out.view{ 'stp2 out: ' + it }
// }

// // Scatter(SecondaryArray) -> Scatter(SecondaryArray) 
// // all stp1 jobs must complete & are gathered before first stp2 job starts.
// workflow {
//     ch_stp1_out = ch_secondary_array.flatten().collate( 2 )     // step1 output
//     ch_stp2_inp = ch_stp1_out.toList().flatten().collate( 2 )   // step2 input
//     ch_stp1_out.view{ 'stp1 out: ' + it }
//     ch_stp2_inp.view{ 'stp2 inp: ' + it }
//     SECONDARY(ch_stp1_out.toList().flatten().collate( 2 ))
//     SECONDARY.out.view{ 'stp2 out: ' + it }
// }

// // Scatter(SecondaryArray) -> SecondaryArray
// workflow {
//     ch_stp1_out = ch_secondary_array.flatten().collate( 2 ) // step1 output
//     ch_stp2_inp = ch_stp1_out.flatten().toList()           // step2 input
//     ch_stp1_out.view{ 'stp1 out: ' + it }
//     ch_stp2_inp.view{ 'stp2 inp: ' + it }
//     SECONDARY_ARRAY(ch_stp1_out.flatten().toList())
//     SECONDARY_ARRAY.out.bams.view{ 'stp2 out: ' + it }
// }

// // SecondaryArray -> Scatter(SecondaryArray)
// workflow {
//     ch_stp1_out = ch_secondary_array                    // step1 output
//     ch_stp2_inp = ch_stp1_out.flatten().collate( 2 )    // step2 input
//     ch_stp1_out.view{ 'stp1 out: ' + it }
//     ch_stp2_inp.view{ 'stp2 inp: ' + it }
//     SECONDARY(ch_stp1_out.flatten().collate( 2 ))
//     SECONDARY.out.view{ 'stp2 out: ' + it }
// }

// SCATTER CROSS?
// leave unimplemented for now


process SINGLE {
    input:
    val inp

    output:
    val inp, emit: out

    script:
    """
    """
}

process ARRAY {
    input:
    val inp

    output:
    val inp

    script:
    """
    """
}

process SECONDARY {
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

def get_primary_files(var) {
  def primary = []
  var.eachWithIndex {item, index -> 
      if (index % 2 == 0) {
          primary.add(item)
      }
  }
  System.out.println 'get_primary_files: ' + primary
  return primary
}

process SECONDARY_ARRAY {
    input:
    path bambai_array_flat

    output:
    path "*.bam.mod", emit: bams

    script:
    def bams = get_primary_files(bambai_array_flat).join(' ')
    // def [inp.id()] = get_primary_files(naming.process_input_secondaries_array(inp))
    """
    for bam in ${bams}; do touch \$bam.mod; done
    """
}


