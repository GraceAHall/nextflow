


process BUNDLE_BAM_SECONDARIES {

    input:
    path bam
    path bai

    output:
    tuple path(bam), path(bai)

    script:
    """
    """
}

process BAM_MERGE {
    publishDir "./outputs", mode: 'copy'

    input: 
    path bams
    path bais

    output: 
    tuple path('*.{bam}{,.bai}')
    tuple path('out.bam'), path('out.bam.bai')

    script:
    """
    cat *.bam >> out.bam
    cat *.bai >> out.bam.bai
    """
}


process BAMBAI {
    publishDir "./outputs", mode: 'symlink'
    
    input:
    tuple path(bam), path(bai)

    output:
    tuple path('*.bam'), path('*.bai')

    script:
    """
    cat ${bam} > ${bam.simpleName}_out.bam
    cat ${bai} > ${bam.simpleName}_out.bam.bai
    """
}

process BAMBAI2 {
    publishDir "./outputs", mode: 'symlink'
    
    input:
    tuple path(bam), path(bai)

    output:
    tuple path("*.{bam}{,.bai}")

    script:
    """
    cat ${bam} > ${bam.simpleName}_out.bam
    cat ${bai} > ${bam.simpleName}_out.bam.bai
    """
}


process BWA {
    publishDir "./outputs", mode: 'symlink'
    
    input:
    tuple path(ref), path(amb), path(ann), path(bwt), path(pac), path(sa)

    output:
    tuple path("*.{fna}{,.amb,.ann,.bwt,.pac,.sa}")

    script:
    """
    cat ${ref} > ${ref.simpleName}_out.fna
    cat ${amb} > ${amb.simpleName}_out.fna.amb
    cat ${ann} > ${ann.simpleName}_out.fna.ann
    cat ${bwt} > ${bwt.simpleName}_out.fna.bwt
    cat ${pac} > ${pac.simpleName}_out.fna.pac
    cat ${sa} > ${sa.simpleName}_out.fna.sa
    """
}

process VCFMERGE {
    publishDir "./outputs", mode: 'symlink'
    
    input:
    tuple path(vcfs), path(tbis)

    output:
    tuple path("*.{vcf}"), emit: merged_variants

    script:
    """
    cat ${ref} > ${ref.simpleName}_out.fna
    cat ${amb} > ${amb.simpleName}_out.fna.amb
    cat ${ann} > ${ann.simpleName}_out.fna.ann
    cat ${bwt} > ${bwt.simpleName}_out.fna.bwt
    cat ${pac} > ${pac.simpleName}_out.fna.pac
    cat ${sa} > ${sa.simpleName}_out.fna.sa
    """
}



process OPTIONAL_OUTPUT {
  output: 
  path 'foo.txt', optional: true

  script:
  '''
  if [[ $(( ( RANDOM % 2 ) )) == 0 ]]; then 
    echo Hello world > foo.txt 
  fi
  '''
}