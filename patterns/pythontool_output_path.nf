
nextflow.enable.dsl=2

params.mystr = 'hello there!'

workflow {
    PYTHON_TOOL()
    // PYTHON_TOOL().view()
    STP2(PYTHON_TOOL.out.out)
    STP2.out.out.text.view()
}



process PYTHON_TOOL {
    publishDir './outputs'
    
    input:

    output: 
    val "${file("${task.workDir}/" + file("${task.workDir}/out_out").text.replace('"', ''))}", emit: out
    // path "${file("${task.workDir}/" + file("${task.workDir}/out_out").text.replace('"', ''))}", emit: out

    script:
    
    """
    #!/usr/bin/env python
    with open('output.txt', 'w') as fp:
        fp.write('hello!')

    with open('out_out', 'w') as fp:
        fp.write('"output.txt"')
    """ 
}


process STP2 {
    input: 
    path infile

    output: 
    path "contents.txt", emit: out

    script:
    """
    cat ${infile} > contents.txt
    """
}









// process PYTHON_TOOL {
//     publishDir './outputs'

//     input:
//     val inp

//     output: 
//     path "${file(file("${task.workDir}/out_out").text.replace('"', ''))}", emit: out

//     exec:

//     script:
//     """
//     #!/usr/bin/env python
//     import os
//     work_dir = os.getcwd()
//     filepath = os.path.join(work_dir, "output.txt")
//     print(filepath)
//     with open(filepath, 'w') as fp:
//         fp.write('blah blah this is the actual file we want to collect')

//     filepath = os.path.join(work_dir, f"out_out")
//     print(filepath)
//     with open(filepath, "w") as fp:
//         fp.write('"output.txt"')
//     """ 
// }