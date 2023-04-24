

params.bambais = [
    ['../data/aln1.sorted.bam', '../data/aln1.sorted.bai'],
    ['../data/aln2.sorted.bam', '../data/aln2.sorted.bai']
]

ch_bambais = Channel.fromPath( params.bambais.flatten() ).buffer( size: 2 )
// ch_bambais.view()

def get_primary_files(var) {
  def primary_files = []
  var.eachWithIndex {item, index -> 
      if (index % 2 == 0) {
          primary_files.add(item)
      }
  }
  return primary_files
}

workflow {
    STP1(ch_bambais.flatten().toList())
    // STP1.out.view()
}

process STP1 {
    input:
    path indexed_bam_array_flat

    output: 
    stdout

    script: 
    def indexed_bam_array_flat = get_primary_files(indexed_bam_array_flat)
    def secondary_array = "--secondaryArray " + indexed_bam_array_flat.join(' ')
    println secondary_array
    """
    echo ${secondary_array}
    """
}