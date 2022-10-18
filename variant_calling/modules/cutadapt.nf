// nextflow.enable.dsl=2


// positional
// mandatoryOptionNoDefault
// mandatoryOptionWithDefault
// optionalOptionNoDefault
// optionalOptionWithDefault
// optionalBoolean


process CUTADAPT {
    container "quay.io/biocontainers/cutadapt:4.1--py310h1425a21_1"
    
    input:
      path reads
      val min_length //, optional:true
      val min_qual //, optional:true
      val trim_n //, optional:true

    output:
      path 'trimmed.fq', emit: trimmed_reads

    script:
      def trimN = trim_n ? '--trim-n' : ''
      def minLength = min_length ?: '100'
      def minQual = min_qual ?: '30'
      """
      cutadapt -m ${minLength} -q ${minQual} ${trimN} ${reads} > trimmed.fq
      """
}

// process cutadapt {
//     inputs:
//       path reads
//       val min_length, optional:true
//       val min_qual, optional:true
//       val trim_n, optional:true

//     outputs:
//       path 'trimmed.fq', emit: trimmed_reads

//     script:
//     def trimN = trim_n ? '--trim-n' : ''
//     def minLength = min_length ? min_length : '100'
//     def minQual = min_qual ? min_qual : '30'
//     """
//     cutadapt -m ${minLength} -q ${minQual} ${trimN} ${reads} > trimmed.fq
//     """
// }



