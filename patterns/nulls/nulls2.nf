

nextflow.enable.dsl=2

file_pair_array    = params.file_pair_array.collect{ it.collect{ file(it) } }
secondaries_array  = params.secondaries_array.collect{ it.collect{ file(it) } }

// println secondaries_array.flatten()
// println file_pair_array.flatten()

def get_primary_files(var, element_count) {
    def primary_files = []
    var.eachWithIndex {item, index -> 
        if (index % element_count == 0) {
            primary_files.add(item)
        }
    }
    return primary_files
}

workflow {
    TASK1(
        secondaries_array.flatten(),
        file_pair_array.flatten(),
    )
}

process TASK1 {
    input:
    path secondaries_array_flat, stageAs: 'secondaries_array_flat??/*'
    path file_pair_array_flat, stageAs: 'file_pair_array_flat??/*'

    output:
    stdout

    script: 
    // println secondaries_array_flat
    // println file_pair_array_flat
    def secondaries_array = get_primary_files(secondaries_array_flat, 2)
    def file_pair_array = get_primary_files(file_pair_array_flat, 2)
    println secondaries_array
    println file_pair_array
    """
    """
}