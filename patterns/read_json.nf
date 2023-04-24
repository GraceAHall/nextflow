


nextflow.enable.dsl=2

params.myjson = '/home/grace/work/pp/translation/nextflow/patterns/myjson.json'
ch_json = Channel.fromPath( params.myjson )

workflow {
    READ_JSON(ch_json)
    READ_JSON.out.out_int.view()
    READ_JSON.out.out_string.view()
    READ_JSON.out.out_dict_1.view()
}


import groovy.json.JsonSlurper
def jsonSlurper = new JsonSlurper()


process READ_JSON {
    publishDir './outputs'

    input:
    path filename

    output:
    val "${jsonSlurper.parseText(file("${task.workDir}/" + "cwl.output.json").text)['out_int']}", emit: out_int
    val "${jsonSlurper.parseText(file("${task.workDir}/cwl.output.json").text)['out_string']}", emit: out_string
    val "${jsonSlurper.parseText(file("${task.workDir}/cwl.output.json").text)['out_dict']['key1']}", emit: out_dict_1

    script:
    """
    cp ${filename} cwl.output.json
    """ 
}