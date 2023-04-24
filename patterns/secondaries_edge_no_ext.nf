


nextflow.enable.dsl=2

params.mystring = '12_34abc'
params.mystring = 'aln.bam'
params.bambai = [
    '/home/grace/work/pp/translation/nextflow/data/aln1.sorted.bam', 
    '/home/grace/work/pp/translation/nextflow/data/aln1.sorted.bai',
]

ch_bambai = Channel.fromPath( params.bambai ).toList()

workflow {
    // SPLIT_BAM(ch_bambai)
    // SPLIT_BAM.view()
    ch_bambai.view()
    foo(ch_bambai).view()
}

// process SPLIT_BAM {
//     input:
//     tuple path(bam), path(bai)

//     output:
//     tuple path("${bam.name}"), path("/\.bai/"), emit: out
//     // tuple path("${bam.name}"), path("${bam.name.replace("\.\w*?\.bam", ".bai")}"), emit: out

//     script:
//     """
//     """

// }


process foo {
  input: 
  tuple path(bam), path(bai)
  
  output: 
  path "temp/${bam.simpleName}*.bai"

  script:
  println bam
  println bai
  println bam.simpleName
  println bai.simpleName
  """
  mkdir temp
  touch temp/${bam}
  touch temp/${bai}
  """
}
