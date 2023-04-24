

nextflow.enable.dsl=2


// params.inp = '[hey, there, friend]'
params.inp = 'hi'


workflow {
    STP1(params.inp)
    // STP1.out.out_R1_sequences.view{ '\n\nprocess output --- \nval: ' + it + '  class: ' + it.getClass() }
    // ch_stp1_out_R1_sequences = STP1.out.out_R1_sequences.map{ it -> it.split(', ')}
    // ch_stp1_out_R1_sequences.view{ '\n\nreformatted --- \nval: ' + it + '  class: ' + it.getClass() }
    // STP2(STP1.out.out_R1_sequences)
    // STP2(STP1.out.out_R1_sequences.split(', '))
    STP2(STP1.out.out_R1_sequences.filter{ it != '' }.map{ it -> it.split(', ') }.ifEmpty( null ))
}


process STP1 {
    input: 
    val inp

    output:
    val "${file("${task.workDir}/out_out_R1_sequences").text.replace('[', '').replace(']', '')}", emit: out_R1_sequences

    exec: 
    // exec allows us to access task.workDir to collect files. 
    
    script:
    """
    #!/usr/bin/env python
    import os
    
    work_dir = os.getcwd()
    with open(os.path.join(work_dir, "out_out_R1_sequences"), "w") as fp:
        # fp.write("[hi, there]")
        fp.write("[]")
    """
}

process STP1_ALT {
    input: 
    val inp

    output:
    val "out_out_R1_sequences", emit: out_R1_sequences

    exec: 
    // exec allows us to access task.workDir to collect files. 
    
    script:
    """
    #!/usr/bin/env python
    import os
    
    work_dir = os.getcwd()
    with open(os.path.join(work_dir, "out_out_R1_sequences"), "w") as fp:
        fp.write("[hi, there]")
    """
}


process STP2 {
    input: 
    val myarray

    output:
    stdout

    script:
    println '\nSTEP4 ----'
    println 'class: ' + myarray.getClass()
    println 'value: ' + myarray
    println 'length: ' + myarray.length
    println 'null: ' + (myarray == null)
    println '\n'

    """
    echo "${myarray}"
    """
}
